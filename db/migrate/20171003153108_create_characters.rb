class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name, index: true
      t.integer :recruitment_chapter
      t.integer :rating
      t.references :game, foreign_key: true

      t.timestamps
    end

    add_index :characters, [:name, :game_id], unique: true
  end
end
