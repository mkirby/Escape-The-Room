class CreateCharactersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :health
      t.integer :terror
      t.integer :user_id
  end
end
