class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :name
      t.string :full_name
      t.string :difficulty
      t.integer :num_chapters
      t.integer :min_team_size
      t.integer :max_team_size

      t.timestamps
    end

    add_index :games, [:name, :difficulty], unique: true
  end
end
