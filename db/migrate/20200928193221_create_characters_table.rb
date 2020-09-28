class CreateCharactersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :health, :default => 10
      t.integer :terror, :default => 0
      t.integer :user_id
    end
  end
end
