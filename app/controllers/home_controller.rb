class HomeController < ApplicationController
  before_action :authenticate_student!, only: [:student_home]
  before_action :authenticate_instructor!, only: [:instructor_home]

  def login
    render({ :template => "home/login" })
  end

  def student_home
    @enrollments = Enrollment.where( :id => current_student.id ).order({ :created_at => :desc })
    @courses = Course.where( :isactive => true )
    render({ :template => "home/student_home"})
  end

  def instructor_home
    @courses = Course.where( :instructor_id => current_instructor.id ).order({ :created_at => :desc })
    render({ :template => "home/instructor_home"})
  end

end
