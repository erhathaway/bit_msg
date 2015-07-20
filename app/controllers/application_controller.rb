class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #added by ethan as a patch to the submit message missing auth token
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  helper_method :new_coupon
  helper_method :check_coupon_balance
end
