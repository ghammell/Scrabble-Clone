class CreateCoordinates < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.integer :horizontal
      t.integer :vertical
      t.string :letter, default: ""

      t.timestamps
      t.references :neighbor
      t.belongs_to :game
    end
  end
end
