class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:index]
  before_action :set_current_user, if: :user_signed_in?
  around_action :log_request_response

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def set_current_user
    @current_user = current_user
  end

  def log_request_response
    logger.info "-------------------------------"
    logger.info "request: " + request.to_s # request.inspect logs too much
    logger.info "-------------------------------"

    yield # Execution of actual action

    logger.info "-------------------------------"
    logger.info "response: " + response.to_s # response.inspect logs too much
    logger.info "-------------------------------"
  end

  private

  def owner?(object)
    return false unless object.present?
    current_user == object.user
  end
end
