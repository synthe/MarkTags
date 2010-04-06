class CreateMarktags < ActiveRecord::Migration
  def self.up
    create_table :marktags do |t|
      t.integer :bookmark_id
      t.integer :tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :marktags
  end
end
