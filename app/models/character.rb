class Character < ActiveRecord::Base
    belongs_to :user
    has_many :records
    has_many :items, through: :records
    has_many :escapes, through: :records

    def check_stats
        puts "Name: #{self.name}"
        puts "Health: #{self.health}"
        puts "Terror: #{self.terror}"
    end

    def view_inventory
        self.items.map do |item|
            puts "#{item.name} - '#{item.description}'"
        end
    end
end