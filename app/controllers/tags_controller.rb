class TagsController < ApplicationController
  def index
    tags = Tag.all
    #this is sorting things weirdly.  not sure why
    @tags = tags.sort! { |a,b| b.bookmarks.count <=> a.bookmarks.count }
    maxCount = @tags[0].bookmarks.count
    minCount = @tags[@tags.length-1].bookmarks.count
    
    #can't quite figure out why this is showing up as 0
    @sizeModifier = (1 / (maxCount.to_f));
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookmarks }
    end
  end
end
