class CoursesController < ApplicationController
  before_action :authenticate_student_or_instructor

  def index
    @list_of_courses = Course.all.order({ :created_at => :desc })
    render({ :template => "courses/index" })
  end

  def show
    @the_course = Course.where({ :id => params["path_id"] }).first
    @documents = Document.where({ :course_id => params["path_id"] }).order({ :created_at => :desc })

    if instructor_signed_in?
      @instructors = Instructor.all.order({ :name => :asc })
      @sample_questions = SampleQuestion.where({ :course_id => params["path_id"] }).order({ :created_at => :desc })
      render({ :template => "courses/show_instructor" })
    elsif student_signed_in?
      @enrollment = Enrollment.where({ :course_id => params["path_id"] }).where({ :student_id => current_student.id }).first
      render({ :template => "courses/show_student" })
    end
  end

  def create
    the_course = Course.new
    the_course.name = params.fetch("query_name")
    the_course.instructor_id = params.fetch("query_instructor_id")
    the_course.isactive = params.fetch("query_isactive", false)
    the_course.system_prompt = "You are an instructor on #{params.fetch("query_name")}. Ask questions to a student, then evaluate their response, provide feedback to the student as well as a score out of 5. This is an exam setting. Do not engage with the student on irrelevant answers. Totally irrelevant or nonsensical answers should get a score of 0.
    
    Here are some examples of questions that you can ask. Use these to set the difficulty of the questions and the scope of the questions:"

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


  private 
  def authenticate_student_or_instructor
    unless student_signed_in? || instructor_signed_in?
      redirect_to new_student_session_path
    end
  end

end
