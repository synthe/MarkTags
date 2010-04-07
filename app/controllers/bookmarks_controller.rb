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
    @tags = @bookmark.tags.collect { |i| i.name }

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
    @tags = @bookmark.tags.collect { |i| i.name }

  end

  # POST /bookmarks
  # POST /bookmarks.xml
  def create
    @bookmark = Bookmark.new(params[:bookmark])
    

    respond_to do |format|
      if @bookmark.save
        tagsString = params[:bookmark_tags]
        save_tagstring_to_tags(tagsString, @bookmark.id)

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
    @tags = @bookmark.tags.collect { |i| i.name }

    tagsString = params[:bookmark_tags]
    #@bookmark.tags = commatags_to_array(tagsString)
    
    save_tagstring_to_tags(tagsString, @bookmark.id)

    respond_to do |format|
      if @bookmark.update_attributes(params[:bookmark])
        flash[:notice] = 'Bookmark was successfully updated.'
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
    
    Marktags.delete_all(["bookmark_id = ?", params[:id]])

    respond_to do |format|
      format.html { redirect_to(bookmarks_url) }
      format.xml  { head :ok }
    end
  end
  
  
  
end
