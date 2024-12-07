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

  def question_create
    @the_enrollment = Enrollment.where({ :id => params["path_id"] }).first

    message_list = [
    { "role" => "system", "content" => @the_enrollment.course.system_prompt },
    { "role" => "user", "content" => "Ask the first question."}
    ]

    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

    api_response = client.chat(
      parameters: {
        model: ENV.fetch("OPENAI_MODEL"),
        messages: message_list
      }
    )

    new_question = Question.new
    new_question.enrollment_id = @the_enrollment.id
    new_question.question_body = api_response.fetch("choices").at(0).fetch("message").fetch("content")
    new_question.save

    redirect_to("/exam/#{@the_enrollment_id}", { :notice => "Question created successfully." })
  end


  def question_update
    the_question = Question.where({ :id => params["path_id"] }).first
    the_question.student_answer = params.fetch("query_student_answer")

    if the_question.valid?
      the_question.save

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

      client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

      api_response = client.chat(
        parameters: {
          model: ENV.fetch("OPENAI_MODEL"),
          messages: message_list
        }
      )

      new_question = Question.new
      new_question.enrollment_id = the_question.enrollment_id
      new_question.question_body = api_response.fetch("choices").at(0).fetch("message").fetch("content")
      new_question.save

      redirect_to("/exam/#{the_question.enrollment_id}", { :notice => "Question created successfully." })
    else
      redirect_to("/exam/#{the_question.enrollment_id}", { :alert => the_question.errors.full_messages.to_sentence })
    end
  end

end
