class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    def parse_yaml(file)
      YAML::load(File.open(file))
    end
 end
 