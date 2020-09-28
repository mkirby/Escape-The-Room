class Item < ActiveRecord::Base
    has_many :records
    has_many :characters, through: :records
    has_many :escapes, through: :records

end