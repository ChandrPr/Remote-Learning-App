class QuestionsController < ApplicationController
  def index
    @list_of_questions = Question.all.order({ :created_at => :desc })
    render({ :template => "questions/index" })
  end

  def show
    @the_question = Question.where({ :id => params["path_id"] }).first
    render({ :template => "questions/show" })
  end

  def create
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

  def update
    the_question = Question.where({ :id => params["path_id"] }).first
    the_question.enrollment_id = params.fetch("query_enrollment_id")
    the_question.body = params.fetch("query_body")
    the_question.student_answer = params.fetch("query_student_answer")
    the_question.feedback = params.fetch("query_feedback")
    the_question.score = params.fetch("query_score")

    if the_question.valid?
      the_question.save
      redirect_to("/questions/#{the_question.id}", { :notice => "Question updated successfully."} )
    else
      redirect_to("/questions/#{the_question.id}", { :alert => the_question.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_question = Question.where({ :id => params["path_id"] }).first
    enrollment_id = the_question.enrollment_id
    the_question.destroy
    redirect_to("/enrollments/#{enrollment_id}", { :notice => "Question deleted successfully."} )
  end
end
