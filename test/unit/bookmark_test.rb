require File.dirname(__FILE__)+'/../test_helper'

class BookmarkTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "can make tags string" do
    aBookmark = Bookmark.new(:title => "test title", :url => "http://blah")
    assert_equal "", aBookmark.tags_string
  end
  
  test "can associate tags" do
    aBookmark = Bookmark.new(:title => "test title", :url => "http://blah")
    aBookmark.tags << Tag.new(:name => "test tag")
    assert_equal "test tag", aBookmark.tags_string
  end
  
  test "can have more tags" do
    aBookmark = Bookmark.new(:title => "test title", :url => "http://blah")
    aBookmark.tags << Tag.new(:name => "test tag")
    aBookmark.tags << Tag.new(:name => "tag2")
    assert_equal "test tag,tag2", aBookmark.tags_string
  end
  
  test "can save and recall from db" do
    aBookmark = Bookmark.new(:title => "test title", :url => "http://blah")
    aBookmark.tags << Tag.new(:name => "test tag")
    aBookmark.tags << Tag.new(:name => "tag2")
    aBookmark.save
    
    dbBookmark = Bookmark.find(aBookmark.id)
    assert_equal "test tag,tag2", dbBookmark.tags_string
  end
  
  test "can convert comma tags to objects" do
    tagsString = "tag1,tag2"
    aBookmark = Bookmark.new(:title => "test title", :url => "http://blah")
    aBookmark.save
    aBookmark.tags_string = tagsString
    assert_equal tagsString, aBookmark.tags_string
  end
end
