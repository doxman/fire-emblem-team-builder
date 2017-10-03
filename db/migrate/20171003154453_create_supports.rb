class CreateSupports < ActiveRecord::Migration[5.1]
  def change
    create_table :supports do |t|
      t.references :character, index: true, foreign_key: true
      t.references :partner, index: true

      t.timestamps
    end

    add_foreign_key :supports, :characters, column: :partner_id
    add_index :supports, [:character_id, :partner_id], unique: true
  end
end
