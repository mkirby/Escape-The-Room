class Escape < ActiveRecord::Base
    has_many :saves
    has_many :items, through: :saves
    has_many :characters, through: :saves

end