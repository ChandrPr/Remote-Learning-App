class CoursesController < ApplicationController
  def index
    @list_of_courses = Course.all.order({ :created_at => :desc })
    render({ :template => "courses/index" })
  end

  def show
    @the_course = Course.where({ :id => params["path_id"] }).first
    render({ :template => "courses/show" })
  end

  def create
    the_course = Course.new
    the_course.name = params.fetch("query_name")
    the_course.instructor_id = params.fetch("query_instructor_id")
    the_course.isactive = params.fetch("query_isactive", false)

    if the_course.valid?
      the_course.save
      redirect_to("/courses/#{the_course.id}", { :notice => "Course created successfully." })
    else
      redirect_to("/instructor_home", { :alert => the_course.errors.full_messages.to_sentence })
    end
  end

  def update
    the_course = Course.where({ :id => params["path_id"] }).first
    the_course.name = params.fetch("query_name")
    the_course.instructor_id = params.fetch("query_instructor_id")
    the_course.isactive = params.fetch("query_isactive", false)

    if the_course.valid?
      the_course.save
      redirect_to("/courses/#{the_course.id}", { :notice => "Course updated successfully."} )
    else
      redirect_to("/courses/#{the_course.id}", { :alert => the_course.errors.full_messages.to_sentence })
    end
  end

  def destroy
    Course.where({ :id => params["path_id"] }).first.destroy
    redirect_to("/courses", { :notice => "Course deleted successfully."} )
  end
end
