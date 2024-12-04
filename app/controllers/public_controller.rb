class PublicController < ApplicationController

  def login
    render({ :template => "home/login" })
  end

end
