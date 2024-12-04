class InstructorController < ApplicationController
  before_action :authenticate_instructor!

  def home
    @courses = Course.where( :instructor_id => current_instructor.id ).order({ :created_at => :desc })
    render({ :template => "home/instructor_home"})
  end

end
