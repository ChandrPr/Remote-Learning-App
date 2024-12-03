class SampleQuestionsController < ApplicationController
  def index
    @list_of_sample_questions = SampleQuestion.all.order({ :created_at => :desc })
    render({ :template => "sample_questions/index" })
  end

  def show
    matching_sample_questions = SampleQuestion.where({ :id => params["path_id"] }).first
    render({ :template => "sample_questions/show" })
  end

  def create
    the_sample_question = SampleQuestion.new
    the_sample_question.question_body = params.fetch("query_question_body")
    the_sample_question.course_id = params.fetch("query_course_id")

    if the_sample_question.valid?
      the_sample_question.save
      redirect_to("/sample_questions", { :notice => "Sample question created successfully." })
    else
      redirect_to("/sample_questions", { :alert => the_sample_question.errors.full_messages.to_sentence })
    end
  end

  def update
    the_sample_question = SampleQuestion.where({ :id => params["path_id"] }).first
    the_sample_question.question_body = params.fetch("query_question_body")
    the_sample_question.course_id = params.fetch("query_course_id")

    if the_sample_question.valid?
      the_sample_question.save
      redirect_to("/sample_questions/#{the_sample_question.id}", { :notice => "Sample question updated successfully."} )
    else
      redirect_to("/sample_questions/#{the_sample_question.id}", { :alert => the_sample_question.errors.full_messages.to_sentence })
    end
  end

  def destroy
    SampleQuestion.where({ :id => params["path_id"] }).first.destroy
    redirect_to("/sample_questions", { :notice => "Sample question deleted successfully."} )
  end
end
