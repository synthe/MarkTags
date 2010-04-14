# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def tag_cleanup
    query = "DELETE FROM tags WHERE id NOT IN (SELECT DISTINCT tag_id FROM marktags)"
    ActiveRecord::Base.connection.execute(query)
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
