class Bookmark < ActiveRecord::Base
  has_many :marktags
  has_many :tags, :through => :marktags
  
  validates_presence_of :title
  validates_uniqueness_of :url
  
  def tags_string
    tagsArr = tags.collect { |i| i.name }
    tagsArr.join(",")
  end
  
  #setting tags based off of tags string
  def tags_string=(commastring)
    #need to fix this beotch up to be sexier
    #Marktags.delete_all(["bookmark_id = ?", id])
    #self.tags = []

    #lets see what tags is right out of the bat
    puts YAML::dump(tags)
    
    if (commastring.length > 0)
      tagsArr = commastring.split(',');
      tagsArr.each do |tagname|
        # remove white space
        tagname = tagname.strip
        
        tags << Tags.new(:name => tagname)
        
        #if (Tags.find_by_name(tag))
        #  tagID = Tags.find_by_name(tag).id
        #else
        #  aTag = Tags.new(:name => tag)
        #  aTag.save
        #  tagID = aTag.id
        #end
        
        #Marktags.new(:bookmark_id => bookmarkid, :tag_id => tagID).save
      end
    end    
    
  end
end
