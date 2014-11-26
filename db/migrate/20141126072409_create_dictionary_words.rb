class CreateDictionaryWords < ActiveRecord::Migration
  def change
    create_table :dictionary_words do |t|
      t.string :word
      t.integer :points

      t.timestamps
    end
  end
end
