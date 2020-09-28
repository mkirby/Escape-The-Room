class Character < ActiveRecord::Base
    belongs_to :user
    has_many :saves
    has_many :items, through: :saves
    has_many :escapes, through: :saves

end