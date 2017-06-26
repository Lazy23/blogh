class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :authorize

  protect_from_forgery with: :exception

  protected

  def authorize
    unless signed_in?
      redirect_to home_url, alert: 'You have no permissions to do this'
    end
  end
end
