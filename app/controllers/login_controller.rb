class LoginController < ApplicationController
  def login
    @student = Student.new
    render({ :template => "devise/sessions/new" })
  end


end
