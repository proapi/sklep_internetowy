ENV["RAILS_ENV"] ||= "production"

require File.dirname(__FILE__) + "/../../config/environment"

module Mercury
  module Authentication

    def can_edit?
      session[:can_edit]
    end
  end
end
