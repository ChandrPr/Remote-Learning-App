class StudentController < ApplicationController
  before_action :authenticate_student!

  def home
    @enrollments = Enrollment.where( :student_id => current_student.id ).order({ :created_at => :desc })
    @courses = Course.where( :isactive => true )
    render({ :template => "home/student_home"})
  end

  def exam
    @enrollment = Enrollment.where( :id => params["enrollment_id"] ).first
    render({ :template => "home/exam"})
  end

  def retake_exam
    Question.where({ :enrollment_id => params["enrollment_id"] }).destroy_all
    enrollment = Enrollment.where({ :id => params["enrollment_id"] }).first
    enrollment.status = "In Progress"
    enrollment.grade = 0
    enrollment.save
    redirect_to("/enrollments/#{params["enrollment_id"]}", { :notice => "Exam has been cleared."} )
  end

  def JSON_OpenAIcall(message_list)

    request_headers_hash = {
      "Authorization" => "Bearer #{ENV.fetch("OPENAI_API_KEY")}",
      "content-type" => "application/json"
    }

    schema_from_generator = '{
      "name": "question_answer_format",
      "schema": {
        "type": "object",
        "properties": {
          "feedback": { "type": "string", "description": "Text response providing feedback on the previous question." },
          "score": { "type": "number", "description": "Score out of 5 for the previous question." },
          "new_question": { "type": "string", "description": "The new question to be presented." }
        },
        "required": [ "feedback", "score", "new_question" ],
        "additionalProperties": false
      },
      "strict": true
    }'

    response_format = JSON.parse("{
      \"type\": \"json_schema\",
      \"json_schema\": #{schema_from_generator}
    }")

    request_body_hash = {
      "model" => "gpt-4o-mini",
      "response_format" => response_format,
      "messages" => message_list
    }

    request_body_json = JSON.generate(request_body_hash)

    # Make the API call
    raw_response = HTTP.headers(request_headers_hash).post(
      "https://api.openai.com/v1/chat/completions",
      :body => request_body_json
    ).to_s

    # Parse the response JSON into a Ruby Hash
    parsed_response = JSON.parse(raw_response)
    message_content = parsed_response.dig("choices", 0, "message", "content")
    JSON.parse(message_content)
  end

  def question_create
    @the_enrollment = Enrollment.where({ :id => params["path_id"] }).first

    message_list = [
    { "role" => "system", "content" => @the_enrollment.course.system_prompt },
    { "role" => "user", "content" => "Ask the first question."}
    ]

    structured_output = JSON_OpenAIcall(message_list)

    new_question = Question.new
    new_question.enrollment_id = @the_enrollment.id
    new_question.question_body = structured_output["new_question"]
    if new_question.valid?
      new_question.save
      redirect_to("/exam/#{@the_enrollment.id}", { :notice => "Question created successfully." })
    else
      redirect_to("/exam/#{@the_enrollment.id}", { :alert => new_question.errors.full_messages.to_sentence })
    end
  end


  def question_update
    the_question = Question.where({ :id => params["path_id"] }).first
    the_question.student_answer = params.fetch("query_student_answer")

    message_list = []
    message_list.push({
      "role" => "system",
      "content" => the_question.enrollment.course.system_prompt
    })

    the_question.enrollment.questions.order(:created_at).each do |question|
      unless the_question.question_body.empty?
        message_list.push({
          "role" => "assistant",
          "content" => the_question.question_body
        })
      end
      unless the_question.student_answer.empty?
        message_list.push({
          "role" => "user",
          "content" => the_question.student_answer
        })
      end
    end

    structured_output = JSON_OpenAIcall(message_list)

    the_question.feedback = structured_output["feedback"]
    the_question.score = structured_output["score"]

    if the_question.valid?
      the_question.save

      qns = Question.where({ :enrollment_id => the_question.enrollment_id })
      num_qns = qns.count
      if num_qns < 6
        new_question = Question.new
        new_question.enrollment_id = the_question.enrollment_id
        new_question.question_body = structured_output["new_question"]
        new_question.save
      elsif num_qns = 6
        enrollment = Enrollment.where({ :id => the_question.enrollment_id }).first
        enrollment.grade = qns.sum(:score)
        if qns.sum(:score) >= 21
          enrollment.status = 'Passed'
        else
          enrollment.status = 'Failed'
        end
        enrollment.save
      end

      redirect_to("/exam/#{the_question.enrollment_id}", { :notice => "Question created successfully." })
    else
      redirect_to("/exam/#{the_question.enrollment_id}", { :alert => the_question.errors.full_messages.to_sentence })
    end
  end

end
