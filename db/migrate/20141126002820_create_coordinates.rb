class CreateCoordinates < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.integer :horizontal
      t.integer :vertical
      t.string :letter, default: ""

      t.timestamps
    end
  end
end
