class CreateCoordinates < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.integer :horizontal
      t.integer :vertical
      t.string :letter, default: ""
      t.string :multiplier, default: ""
      t.integer :multiple, default: 0

      t.timestamps
      t.belongs_to :game
    end
  end
end
