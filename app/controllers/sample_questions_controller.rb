class SampleQuestionsController < ApplicationController
  def index
    matching_sample_questions = SampleQuestion.all

    @list_of_sample_questions = matching_sample_questions.order({ :created_at => :desc })

    render({ :template => "sample_questions/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_sample_questions = SampleQuestion.where({ :id => the_id })

    @the_sample_question = matching_sample_questions.at(0)

    render({ :template => "sample_questions/show" })
  end

  def create
    the_sample_question = SampleQuestion.new
    the_sample_question.question_body = params.fetch("query_question_body")
    the_sample_question.topic_id = params.fetch("query_topic_id")

    if the_sample_question.valid?
      the_sample_question.save
      redirect_to("/sample_questions", { :notice => "Sample question created successfully." })
    else
      redirect_to("/sample_questions", { :alert => the_sample_question.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_sample_question = SampleQuestion.where({ :id => the_id }).at(0)

    the_sample_question.question_body = params.fetch("query_question_body")
    the_sample_question.topic_id = params.fetch("query_topic_id")

    if the_sample_question.valid?
      the_sample_question.save
      redirect_to("/sample_questions/#{the_sample_question.id}", { :notice => "Sample question updated successfully."} )
    else
      redirect_to("/sample_questions/#{the_sample_question.id}", { :alert => the_sample_question.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_sample_question = SampleQuestion.where({ :id => the_id }).at(0)

    the_sample_question.destroy

    redirect_to("/sample_questions", { :notice => "Sample question deleted successfully."} )
  end
end
