class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    def parse_yaml(file)
      YAML::load(File.open(file))
    end

    private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?

        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end
 end
 