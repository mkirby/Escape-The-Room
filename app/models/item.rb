class Item < ActiveRecord::Base
    has_many :saves
    has_many :characters, through: :saves
    has_many :escapes, through: :saves

end