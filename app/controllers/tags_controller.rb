class TagsController < ApplicationController
  def index
    #size constants
    minSize = 1
    maxSize = 3
    
    tags = Tag.all(:include => :bookmarks)
    @tags = tags.sort! { |a,b| b.bookmarks.count <=> a.bookmarks.count }
    if (@tags.count > 0 && @tags[0].bookmarks.count > 0) 
      maxCount = @tags[0].bookmarks.count
      @sizeModifier = ((maxSize - minSize) / (maxCount.to_f));
    else
      @sizeModifier = 0;
    end
    
    minCount = @tags[@tags.length-1].bookmarks.count
    if (minCount < 1)
      minCount = 1
    end
    @additive = (minSize - (minCount.to_f * @sizeModifier))
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end
  
  def show
    @tag = Tag.find(params[:id])
  end
end
