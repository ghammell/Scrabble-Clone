class AddIndexToCoordinates < ActiveRecord::Migration
  def change
    add_index :coordinates, :game_id
  end
end
