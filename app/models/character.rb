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

    def save_quit
        prompt = TTY::Prompt.new
        leave = prompt.ask("Do you want to save and quit?") do |menu|
            menu.choice "Yes"
            menu.choice "No Return to Game"
        if leave == "Yes"
            #NEED
            #save where I am - what character?
            #character.escapes.update (where_am_i: "Where they leave from")
            User.user_menu
        elsif leave == "No Return to Game"
            #NEED
            #return to where we were
        end
    end
end