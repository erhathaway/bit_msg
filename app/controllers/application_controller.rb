class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #added by ethan as a patch to the submit message missing auth token
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  helper_method :format_time


  def format_time(time)

    time_difference = Time.now - time
    days = (time_difference / (60 * 60 * 24))
    # binding.pry
    if days < 1
      days = (days * 24)
      if days < 1
        days = (days * 60)
        if days.to_i == 1
          ending = ' minute ago'
        else
          ending = ' minutes ago'
        end
      elsif days.to_i == 1
        ending = ' hour ago'
      else
        ending = ' hours ago'
      end
    elsif days.to_i == 1
      # days = days.to_i
      ending = ' day ago'
    else
      # days = days.to_i
      ending = ' days ago'
    end
    days = days.to_i
    days.to_s + ending
  end
end
