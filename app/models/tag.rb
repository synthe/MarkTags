class Tag < ActiveRecord::Base
  has_many :marktags
  has_many :bookmarks, :through => :marktags

  validates_uniqueness_of :name
  
  def self.clear_unused
    query = "DELETE FROM tags WHERE id NOT IN (SELECT DISTINCT tag_id FROM marktags)"
    ActiveRecord::Base.connection.execute(query)
  end
end
