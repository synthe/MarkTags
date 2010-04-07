class Marktag < ActiveRecord::Base
  belongs_to :bookmark
  belongs_to :tag

  validates_uniqueness_of :tag_id, :scope => "bookmark_id"
end
