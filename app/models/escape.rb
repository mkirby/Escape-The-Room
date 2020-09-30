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
    

    def cage
        prompt = TTY::Prompt.new
        self.update(where_am_i: "Cage")
        
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Yell for help"
            menu.choice "Reach for cue stick"
            menu.choice "Reach for keys"
            menu.choice "View Escape Menu"
        end
        system("clear")
        if choice == "Yell for help"
            ####NEED story of captors beating character up and decreasing health by 3
            puts "You yell for help and a man runs down the stairs towards your cage.\n\nHe opens your cage door...unfortunately he has a bat.\n\nThat's the last thing you see before being knocked out.\n\n\n"
            ##character.health =- 3
            sleep 3
            prompt.keypress("Press space or enter to try again", keys: [:space, :return])
            system("clear")
            self.cage  ##Sends back to start of cage story of waking up dizzy
            
        elsif choice == "Reach for cue stick"
            ###Need story of character grabbing stick and add cue stick to character.items
            #puts "You now have a cue stick, what what you like to do with it?"
            choice2 = prompt.select('You now have a cue stick, what what you like to do with it?') do |menu|
                menu.choice "Rattle cage and scream for help"
                menu.choice "Reach for keys with cue stick"
            end
            if choice2 == "Rattle cage and scream for help"
                puts "You rattle the cage and yell for help\n\nA man runs down the stairs towards your cage.\n\nHe opens your cage door...unfortunately he has a bat.\n\nThat's the last thing you see before being knocked out.\n\n\n"
                ###character.health =-3
                sleep 3
                prompt.keypress("Press space or enter to try again", keys: [:space, :return])
                system("clear")
                self.cage ##Sends back to start of cage story waking up dizzy

            elsif choice2 == "Reach for keys with cue stick"
                puts "You reach for the keys with the cue stick\n\nMiraculously you are about to get the key ring to slide down\n\nthe cue stick!! You pull the cue stick back into the cage\n\nand grab the keys! FREEDOM!!!"
                ###character.item ADD key and cuestick
                sleep 3
                choice3 = prompt.select('You now have the keys, what what you like to do with it?') do |menu|
                    menu.choice "Unlock the cage"
                end
                if choice3 == "Unlock the cage"
                    ###method that moves outside of the cage
                    puts "leaving the cage need method!"
                end
            end
                
        elsif choice == "Reach for keys"
            ###Need story of character grabbing keys immediate and hurting arm decreasing health by 1
            puts "You extend your arms and reach out for the keys\n\nyour fingertips are so close you can feel the chill from the metal.\n\nAHHH!! A bat flies in and tries to perch on your extended arm!\n\nThat's the last thing you remember before fainting from fear\n\n\n"
            ###character.terror =+3
            sleep 3
            prompt.keypress("Press space or enter to try again", keys: [:space, :return])
            system("clear")
            self.cage ##Sends back to start of cage story waking up dizzy

        elsif choice == "View Escape Menu"
            puts "escape menu coming soon"
            ####self.escape_menu
        end
    end



    def self.intro
        prompt = TTY::Prompt.new
        system('clear')
        puts "Everything is black..."
        sleep 3
        puts "\nYour head feels clouded as if your thoughts swim through a fog. You try to open your eyes but your vision swims with pulsing, painful light."
        sleep 7
        system('clear')
        puts "You begin to open your eyes..."
        sleep 3
        system('clear')
        puts "\nYou feel the coldness of a cement floor beneath your body, as your eyes adjust to the yellow glow of overhead lights."
        puts "\nYou find yourself laying in a floor to ceiling cage with just enough floor space to lay down."
        puts "\nThe sound of footsteps on the floor above draws your attention to the room outside your cage."
        puts "\nYour cage is located in the corner of a partially finished basement with no windows to the outside world."
        puts "\nThere is a pool table hastily pushed into the corner off to your right and a surgical table sitting prominently in middle of the room."
        puts "\nA broken cue stick rack has dropped several cue sticks that have rolled across the floor."
        puts "\nA towering machine with two conical spires looms on the far wall between a large wooden desk and a dusty bookcase."
        puts "\nA steel door is closed at the top of a wooden staircase."
        puts "\nYou can see the front of small safe next to the desk protruding out of the wall from under the staircase."
        puts "\nA long row of rusty metal shelves is filled with jars, surgical supplies, and an overflow of dusty items that can aptly be called 'junk'."
        puts "\nAt the end of those shelves, hanging from a hook a few feet away from the bars of your cage, dangles a ring of brass keys."
        
        prompt.keypress("\n\nPress space or enter to try to escape", keys: [:space, :return])
        Escape.cage
    end
end