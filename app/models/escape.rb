class Escape < ActiveRecord::Base
    has_many :records
    has_many :items, through: :records
    has_many :characters, through: :records

    def middle_of_room
        prompt = TTY::Prompt.new
        puts "You're now standing in the middle of the basement"
        sleep 2
        choice = prompt.select('Where would you like to investigate?', per_page: 8) do |menu|
            menu.choice "Pool Table"
            menu.choice "Shelves"
            menu.choice "Surgical Table"
            menu.choice "Machine"
            menu.choice "Bookcase"
            menu.choice "Desk"
            menu.choice "Safe"
            menu.choice "Door up the stairs"
        end
        system("clear")
        if choice == "Pool Table"
            system("clear")
            ###Pool Table Method story
            puts "Going to pool table!"
        elsif choice == "Shelves"
            system("clear")
            ##Sheleves method story
        elsif choice == "Surgical Table"
            system("clear")
            ##Surgical Table method story
        elsif choice == "Machine"
            system("clear")
            ##Machine method story
        elsif choice == "Bookcase"
            system("clear")
            ##Bookcase method story
        elsif choice == "Desk"
            system("clear")
            ##Desk method story
        elsif choice == "Safe"
            system("clear")
            ##Safe method story
        elsif choice == "Door up the stairs"
            system("clear")
            ##Door method story
        end
    end



end