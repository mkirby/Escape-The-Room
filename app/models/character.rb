class Character < ActiveRecord::Base
    belongs_to :user
    has_many :records
    has_many :items, through: :records
    has_many :escapes, through: :records

    def check_stats
        prompt = TTY::Prompt.new
        system('clear')
        puts "Name: #{self.name}"
        puts "Health: #{self.health}"
        puts "Terror: #{self.terror}\n\n"
        prompt.keypress("Return", keys: [:space, :return])
        system("clear")
        EscapeTheRoom.escape_menu
    end

    def view_inventory
        prompt = TTY::Prompt.new
        system('clear')
        if EscapeTheRoom.has_zero_items?
            puts "You currently have no items.\n\n"
        else
            self.items.reload.map do |item|
                puts "#{item.name} - '#{item.description}'"
            end
        end
        prompt.keypress("Return", keys: [:space, :return])
        system("clear")
        EscapeTheRoom.escape_menu
    end

    def save_quit
        prompt = TTY::Prompt.new
        leave = prompt.select("Do you want to save and quit?") do |menu|
            menu.choice "Yes"
            menu.choice "No"
        end
        if leave == "Yes"
            system('clear')
            EscapeTheRoom.user_menu ## this may return to 86 or 137 in EscapeTheRoom
        elsif leave == "No"
            system('clear')
            EscapeTheRoom.escape_menu ## this may return to 86 or 137 in EscapeTheRoom
        end
    end
end