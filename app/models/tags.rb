class Tags < ActiveRecord::Base
  has_and_belongs_to_many :bookmarks
end
