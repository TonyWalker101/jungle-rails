class Admin::DashboardController < ApplicationController
  user_name = ENV['USER_NAME']
  user_password = ENV['USER_PASSWORD']

  http_basic_authenticate_with name: user_name, password: user_password
  
  def show
  end
end
