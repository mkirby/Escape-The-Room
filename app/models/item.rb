class Item < ActiveRecord::Base
    has_many :save_tables
    has_many :characters, through: :save_tables
    has_many :escapes, through: :save_tables

end