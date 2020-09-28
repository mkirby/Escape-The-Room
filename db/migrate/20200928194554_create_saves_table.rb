class CreateSavesTable < ActiveRecord::Migration[6.0]
  def change
      create_table :saves do |t|
        t.integer :character_id
        t.integer :item_id
        t.boolean :item_used?
        t.integer :escape_id
      end
  end
end
