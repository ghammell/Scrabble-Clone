class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.belongs_to :coordinate
      t.belongs_to :friend, :class_name => "Coordinate"

      t.timestamps
    end
  end
end
