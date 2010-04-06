module BookmarksHelper
  def tags_to_string(bookmarkid)
    association = Marktags.find(:all, :conditions => ["bookmark_id = ?",bookmarkid])
    tags = []
    association.each do |assoc|
      thistag = Tags.find(assoc.tag_id)
      tags.push thistag.name
    end
    tags = tags.join(",")
  end
end
