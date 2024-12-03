class TopicsController < ApplicationController
  def index
    @list_of_topics = Topic.all.order({ :created_at => :desc })
    render({ :template => "topics/index" })
  end

  def show
    @the_topic = Topic.where({ :id => params["path_id"] }).first
    render({ :template => "topics/show" })
  end

  def create
    the_topic = Topic.new
    the_topic.name = params.fetch("query_name")
    the_topic.instructor_id = params.fetch("query_instructor_id")
    the_topic.isactive = params.fetch("query_isactive", false)

    if the_topic.valid?
      the_topic.save
      redirect_to("/topics", { :notice => "Topic created successfully." })
    else
      redirect_to("/topics", { :alert => the_topic.errors.full_messages.to_sentence })
    end
  end

  def update
    the_topic = Topic.where({ :id => params["path_id"] }).first
    the_topic.name = params.fetch("query_name")
    the_topic.instructor_id = params.fetch("query_instructor_id")
    the_topic.isactive = params.fetch("query_isactive", false)

    if the_topic.valid?
      the_topic.save
      redirect_to("/topics/#{the_topic.id}", { :notice => "Topic updated successfully."} )
    else
      redirect_to("/topics/#{the_topic.id}", { :alert => the_topic.errors.full_messages.to_sentence })
    end
  end

  def destroy
    Topic.where({ :id => params["path_id"] }).first.destroy
    redirect_to("/topics", { :notice => "Topic deleted successfully."} )
  end
end
