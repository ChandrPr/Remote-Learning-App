class EnrollmentsController < ApplicationController

  def show
    @the_enrollment = Enrollment.where({ :id => params["path_id"] }).first
    @questions = Question.where({ :enrollment_id => params["path_id"] }).order({ :created_at => :asc })
    render({ :template => "enrollments/show" })
  end

  def create
    the_enrollment = Enrollment.new
    the_enrollment.course_id = params.fetch("query_course_id")
    the_enrollment.student_id = params.fetch("query_student_id")
    the_enrollment.status = "In Progress"
    the_enrollment.grade = 0

    if the_enrollment.valid?
      the_enrollment.save
      redirect_to("/enrollments/#{the_enrollment.id}", { :notice => "Enrollment created successfully." })
    else
      redirect_to("/student_home", { :alert => the_enrollment.errors.full_messages.to_sentence })
    end
  end

  def update
    the_enrollment = Enrollment.where({ :id => params["path_id"] }).first
    the_enrollment.course_id = params.fetch("query_course_id")
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
    redirect_to("/student_home", { :notice => "Enrollment deleted successfully."} )
  end
end
