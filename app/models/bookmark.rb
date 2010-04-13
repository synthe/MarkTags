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
    self.tags.clear
    
    if (commastring.length > 0)
      tagsArr = commastring.split(',');
      tagsArr.each do |tagname|
        # remove white space
        tagname = tagname.strip
        
        
        if (Tag.find_by_name(tagname))
          aTag = Tag.find_by_name(tagname)
        else
          aTag = Tag.new(:name => tagname)
          aTag.save
        end
        
        self.tags << aTag
      end
    end    
    
  end
end
