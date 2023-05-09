class ApplicationController < ActionController::Base
  config.middleware.use Rack::Auth::Basic do |username, password|
    username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
  end
end
