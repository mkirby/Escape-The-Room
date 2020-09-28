class CreateExcapesTable < ActiveRecord::Migration[6.0]
  def change
      create_table :escapes do |t|
        t.string :name
        t.string :where_am_i
      end
  end
end
