class Tag < ActiveRecord::Base
  has_many :marktags
  has_many :bookmarks, :through => :marktags

  validates_uniqueness_of :name
end
