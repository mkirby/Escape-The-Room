class Character < ActiveRecord::Base
    belongs_to :user
    has_many :save_tables
    has_many :items, through: :save_tables
    has_many :escapes, through: :save_tables
    
end