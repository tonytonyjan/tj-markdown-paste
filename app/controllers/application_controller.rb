class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to request.referer || root_url, :alert => exception.message
  end

  def current_user
    nil
  end
  helper_method :current_user
end
