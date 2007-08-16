# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_forum_session_id'
  include AuthenticatedSystem
  require 'chronic'
  require 'custom_methods'
  before_filter :login_from_cookie
  before_filter :ip_banned_redirect
end
