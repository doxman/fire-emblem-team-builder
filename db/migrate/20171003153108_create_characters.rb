class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name, index: true
      t.string :game

      t.timestamps
    end

    add_index :characters, [:name, :game], unique: true
  end
end
