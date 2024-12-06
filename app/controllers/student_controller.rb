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

end
