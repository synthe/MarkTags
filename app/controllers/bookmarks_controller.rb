class BookmarksController < ApplicationController
  # GET /bookmarks
  # GET /bookmarks.xml
  def index
    @bookmarks = Bookmark.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookmarks }
    end
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.xml
  def show
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bookmark }
    end
  end

  # GET /bookmarks/new
  # GET /bookmarks/new.xml
  def new
    @bookmark = Bookmark.new
    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bookmark }
    end
  end

  # GET /bookmarks/1/edit
  def edit
    @bookmark = Bookmark.find(params[:id])
    @association = Marktags.find(:all, :conditions => ["bookmark_id = ?",@bookmark.id])
    @tags = []
    @association.each do |assoc|
      thistag = Tags.find(assoc.tag_id)
      @tags.push thistag.name
    end
    @tags = @tags.join(",")
  end

  # POST /bookmarks
  # POST /bookmarks.xml
  def create
    @bookmark = Bookmark.new(params[:bookmark])

    respond_to do |format|
      if @bookmark.save
        flash[:notice] = 'Bookmark was successfully created.'
        format.html { redirect_to(@bookmark) }
        format.xml  { render :xml => @bookmark, :status => :created, :location => @bookmark }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bookmarks/1
  # PUT /bookmarks/1.xml
  def update
    @bookmark = Bookmark.find(params[:id])

    tagsString = params[:bookmark_tags]
    @tagsResponse = "<br/>";

    Marktags.delete_all(["bookmark_id = ?", @bookmark.id])

    if (tagsString.length > 0)
      @tagsArr = tagsString.split(',');
      @tagsArr.each do |tag|
        if (Tags.find_by_name(tag))
          @tagID = Tags.find_by_name(tag).id
        else
          @aTag = Tags.new(:name => tag)
          @aTag.save
          @tagID = @aTag.id
        end
        
        Marktags.new(:bookmark_id => @bookmark.id, :tag_id => @tagID).save
        
        @tagsResponse += "bookmark:"+@bookmark.id.to_s+"->"+@tagID.to_s+"<br/>"
      end
    end  

    respond_to do |format|
      if @bookmark.update_attributes(params[:bookmark])
        flash[:notice] = 'Bookmark was successfully updated.'+@tagsResponse
        format.html { redirect_to(@bookmark) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.xml
  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to(bookmarks_url) }
      format.xml  { head :ok }
    end
  end
end
