class Record < ActiveRecord::Base
    belongs_to :character
    belongs_to :item
    belongs_to :escape

end