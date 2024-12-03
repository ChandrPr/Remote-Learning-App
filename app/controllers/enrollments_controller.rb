class EnrollmentsController < ApplicationController
  def index
    @list_of_enrollments = Enrollment.all.order({ :created_at => :desc })
    render({ :template => "enrollments/index" })
  end

  def show
    @the_enrollment = Enrollment.where({ :id => params["path_id"] }).first
    render({ :template => "enrollments/show" })
  end

  def create
    the_enrollment = Enrollment.new
    the_enrollment.topic_id = params.fetch("query_topic_id")
    the_enrollment.student_id = params.fetch("query_student_id")
    the_enrollment.status = params.fetch("query_status")
    the_enrollment.grade = params.fetch("query_grade")

    if the_enrollment.valid?
      the_enrollment.save
      redirect_to("/enrollments", { :notice => "Enrollment created successfully." })
    else
      redirect_to("/enrollments", { :alert => the_enrollment.errors.full_messages.to_sentence })
    end
  end

  def update
    the_enrollment = Enrollment.where({ :id => params["path_id"] }).first
    the_enrollment.topic_id = params.fetch("query_topic_id")
    the_enrollment.student_id = params.fetch("query_student_id")
    the_enrollment.status = params.fetch("query_status")
    the_enrollment.grade = params.fetch("query_grade")

    if the_enrollment.valid?
      the_enrollment.save
      redirect_to("/enrollments/#{the_enrollment.id}", { :notice => "Enrollment updated successfully."} )
    else
      redirect_to("/enrollments/#{the_enrollment.id}", { :alert => the_enrollment.errors.full_messages.to_sentence })
    end
  end

  def destroy
    Enrollment.where({ :id => params["path_id"] }).first.destroy
    redirect_to("/enrollments", { :notice => "Enrollment deleted successfully."} )
  end
end
