class TagsController < ApplicationController
  def index
    #size constants
    minSize = 1
    maxSize = 3
    
    tags = Tag.find(:all, :joins => :marktags, :group => :tag_id, :select => "tags.*, count(tag_id) AS bookcount")
    tags.each do |tag|
      tag.bookcount = tag.bookcount.to_i
    end
    @tags = tags.sort! { |a,b| b.bookcount <=> a.bookcount }
    if (@tags.count > 0 && @tags[0].bookcount > 0) 
      maxCount = @tags[0].bookcount
      @sizeModifier = ((maxSize - minSize) / (maxCount.to_f));
    else
      @sizeModifier = 0;
    end
    
    minCount = @tags[@tags.length-1].bookcount
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
  
  def search
    @tags = Tag.find :all, :conditions => ["name like ?", "%#{params[:q]}%"]
    
    respond_to do |format|
      format.html { render :layout => false }# search.html.erb
      format.json  { render :layout => false, :json => @tags.to_json }
    end
  end
end
