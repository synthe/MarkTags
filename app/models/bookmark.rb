class Bookmark < ActiveRecord::Base
  has_and_belongs_to_many :tags
  validates_uniqueness_of :url
end
