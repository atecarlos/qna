class ApplicationController < ActionController::Base
  
  clear_helpers
  protect_from_forgery

  before_filter :authenticate_user!
  
end
