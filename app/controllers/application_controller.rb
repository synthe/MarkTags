# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details


  
  def save_tagstring_to_tags(commastring, bookmarkid)
    Marktags.delete_all(["bookmark_id = ?", bookmarkid])
    
    if (commastring.length > 0)
      tagsArr = commastring.split(',');
      tagsArr.each do |tag|
        if (Tags.find_by_name(tag))
          tagID = Tags.find_by_name(tag).id
        else
          aTag = Tags.new(:name => tag)
          aTag.save
          tagID = aTag.id
        end
        
        Marktags.new(:bookmark_id => bookmarkid, :tag_id => tagID).save
      end
    end
  end
  
  

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
