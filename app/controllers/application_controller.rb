# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def commatags_to_array(commastring)
    tagsArr = []
    if (commastring.length >0) 
      workArr = commastring.split(",")
      workArr.each do |tag|
        tag = tag.strip
        if !tag.empty?
          if (Tags.find_by_name(tag))
            tagID = Tags.find_by_name(tag).id
          else
            aTag = Tags.new(:name => tag)
            aTag.save
            tagID = aTag.id
          end


          tagsArr.push tagID
        end
      end
    end
    tagsArr
  end
  
  def save_tagstring_to_tags(commastring, bookmarkid)
    Marktags.delete_all(["bookmark_id = ?", bookmarkid])
    
    if (commastring.length > 0)
      tagsArr = commastring.split(',');
      tagsArr.each do |tag|
        # remove white space
        tag = tag.strip
        
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
    
    tag_cleanup()
  end
  
  def tag_cleanup
    #not quite sure how to do this with ruby alone.  this is probably faster anyways
    #this removes all tags that aren't associated with any bookmarks
    query = "DELETE FROM tags WHERE id NOT IN (SELECT DISTINCT tag_id FROM marktags)"
    ActiveRecord::Base.connection.execute(query)
    #tags = Tags.find(:all)
    #tags.each do |tag|
    #  associations = Marktags.find(:all, :conditions => ["tag_id = ?", tag.id])
    #  puts tag.id.to_s+"<br/>"
    #  if (associations.length == 0)
    #    tag.delete
    #  end
    #end
  end
  
  

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
