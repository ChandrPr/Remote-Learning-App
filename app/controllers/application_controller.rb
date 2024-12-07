class ApplicationController < ActionController::Base
  skip_forgery_protection

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ensure_only_one_session

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private
  def ensure_only_one_session
    if student_signed_in? && instructor_signed_in?
      # prioritize instructor sign-in.
      sign_out(:student)
    end
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

end
