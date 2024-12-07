class ApplicationController < ActionController::Base
  skip_forgery_protection

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Student)
      "/student_home"
    elsif resource.is_a?(Instructor)
      "/instructor_home"
    else
      super
    end
  end
#  def after_sign_out_path_for(student)
#    "/"
#  end
#  def after_sign_out_path_for(instructor)
#    "/"
#  end

end
