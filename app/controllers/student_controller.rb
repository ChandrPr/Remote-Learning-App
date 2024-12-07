class StudentController < ApplicationController
  before_action :authenticate_student!

  def home
    @enrollments = Enrollment.where( :student_id => current_student.id ).order({ :created_at => :desc })
    @courses = Course.where( :isactive => true )
    render({ :template => "home/student_home"})
  end

  def question_create
    the_question = Question.new
    the_question.enrollment_id = params.fetch("query_enrollment_id")
    the_question.body = params.fetch("query_body")
    the_question.student_answer = params.fetch("query_student_answer")
    the_question.feedback = params.fetch("query_feedback")
    the_question.score = params.fetch("query_score")

    if the_question.valid?
      the_question.save
      redirect_to("/enrollments/#{the_question.enrollment_id}", { :notice => "Question created successfully." })
    else
      redirect_to("/enrollments/#{the_question.enrollment_id}", { :alert => the_question.errors.full_messages.to_sentence })
    end
  end

  def message_create
    the_message = Message.new
    the_message.enrollment_id = params.fetch("query_enrollment_id")
    the_message.body = params.fetch("query_body")
    the_message.role = params.fetch("query_role")
    the_message.score = params.fetch("query_score")
    the_message.feedback = params.fetch("query_feedback")

    if the_message.valid?
      the_message.save
      redirect_to("/enrollments/#{the_message.enrollment_id}", { :notice => "Message created successfully." })
    else
      redirect_to("/enrollments/#{the_message.enrollment_id}", { :alert => the_message.errors.full_messages.to_sentence })
    end
  end

  def message_destroy
    the_message = Message.where({ :id => params[("path_id")] }).first
    enrollment_id = the_message.enrollment_id
    the_message.destroy
    redirect_to("/enrollments/#{enrollment_id}", { :notice => "Message deleted successfully."} )
  end

end
