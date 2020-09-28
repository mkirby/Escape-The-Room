class CreateItemsTable < ActiveRecord::Migration[6.0]
  def change  
    create_table :items do |t|
      t.string :name
      t.string :description
    end
  end
end
