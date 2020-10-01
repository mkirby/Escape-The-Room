class Escape < ActiveRecord::Base
    has_many :records
    has_many :items, through: :records
    has_many :characters, through: :records

    def where_am_i_load_that_location
        location = self.where_am_i
        if location == "Pool Table"
            system("clear")
            #self.pool_table
        elsif location == "Shelves"
            system("clear")
            ##Sheleves method story
        elsif location == "Surgical Table"
            system("clear")
            ##Surgical Table method story
        elsif location == "Machine"
            system("clear")
            ##Machine method story
        elsif location == "Bookcase"
            system("clear")
            ##Bookcase method story
        elsif location == "Desk"
            system("clear")
            ##Desk method story
        elsif location == "Safe"
            system("clear")
            ##Safe method story
        elsif location == "Door up the stairs"
            system("clear")
            ##Door method story
        elsif location == "Middle of Room"
            system("clear")
            self.middle_of_room
        elsif location == "Cage"
            system("clear")
            self.cage
        end
    end

    def intro
        ##CHANGE TO ENTER TO CONTINUE TO SEE TEXT

        prompt = TTY::Prompt.new
        system('clear')
        puts "Everything is black..."
        sleep 1
        puts "\nYour head feels clouded as if your thoughts swim through a fog. You try to open your eyes but your vision swims with pulsing, painful light."
        sleep 1
        system('clear')
        puts "You begin to open your eyes..."
        sleep 1
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
        self.cage
    end

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
            EscapeTheRoom.change_health(-3)
            sleep 3
            prompt.keypress("Press space or enter to try again", keys: [:space, :return])
            system("clear")
            self.cage  ##Sends back to start of cage story of waking up dizzy
            
        elsif choice == "Reach for cue stick"
            EscapeTheRoom.add_character_item("Cue Stick")
            choice2 = prompt.select('You now have a cue stick, what what you like to do with it?') do |menu|
                menu.choice "Rattle cage and scream for help"
                menu.choice "Reach for keys with cue stick"
            end
            if choice2 == "Rattle cage and scream for help"
                puts "You rattle the cage and yell for help\n\nA man runs down the stairs towards your cage.\n\nHe opens your cage door...unfortunately he has a bat.\n\nThat's the last thing you see before being knocked out.\n\n\n"
                EscapeTheRoom.change_health(-3)
                sleep 3
                prompt.keypress("Press space or enter to try again", keys: [:space, :return])
                system("clear")
                self.cage ##Sends back to start of cage story waking up dizzy

            elsif choice2 == "Reach for keys with cue stick"
                puts "You reach for the keys with the cue stick\n\nMiraculously you are about to get the key ring to slide down\n\nthe cue stick!! You pull the cue stick back into the cage\n\nand grab the keys! FREEDOM!!!"
                EscapeTheRoom.add_character_item("Ring of Keys")
                sleep 3
                choice3 = prompt.select('You now have the keys, what what you like to do with it?') do |menu|
                    menu.choice "Unlock the cage"
                end
                if choice3 == "Unlock the cage"
                    system('clear')
                    self.middle_of_room
                end
            end
                
        elsif choice == "Reach for keys"
            ###Need story of character grabbing keys immediate and hurting arm decreasing health by 1
            puts "You extend your arms and reach out for the keys\n\nyour fingertips are so close you can feel the chill from the metal.\n\nAHHH!! A bat flies in and tries to perch on your extended arm!\n\nThat's the last thing you remember before fainting from fear\n\n\n"
            EscapeTheRoom.change_terror(3)
            sleep 3
            prompt.keypress("Press space or enter to try again", keys: [:space, :return])
            system("clear")
            self.cage ##Sends back to start of cage story waking up dizzy

        elsif choice == "View Escape Menu"
            EscapeTheRoom.escape_menu
        end
    end

    def middle_of_room
        prompt = TTY::Prompt.new
        self.update(where_am_i: "Middle of Room")
        puts "You're currently standing in the middle of the basement\n\n"
        sleep 2
        choice = prompt.select('Where would you like to investigate?', per_page: 9) do |menu|
            menu.choice "Pool Table"
            menu.choice "Shelves"
            menu.choice "Surgical Table"
            menu.choice "Machine"
            menu.choice "Bookcase"
            menu.choice "Desk"
            menu.choice "Safe"
            menu.choice "Door up the stairs"
            menu.choice "Escape Menu"
        end
        system("clear")
        if choice != "Escape Menu"
            self.update(where_am_i: "#{choice}")
            if choice == "Pool Table"
                ###Pool Table Method story
                puts "Going to the #{choice}!"
            elsif choice == "Shelves"
                self.shelves
            elsif choice == "Surgical Table"
                ##Surgical Table method story
                puts "Going to the #{choice}!"
            elsif choice == "Machine"
                ##Machine method story
                puts "Going to the #{choice}!"
            elsif choice == "Bookcase"
                ##Bookcase method story
                puts "Going to the #{choice}!"
            elsif choice == "Desk"
                ##Desk method story
                puts "Going to the #{choice}!"
            elsif choice == "Safe"
                ##Safe method story
                puts "Going to the #{choice}!"
            elsif choice == "Door up the stairs"
                ##Door method story
                puts "Going to the #{choice}!"
            end
        elsif choice == "Escape Menu"
            EscapeTheRoom.escape_menu
        end
    end

    def shelves
        prompt = TTY::Prompt.new
        puts "Description of Shelves as a whole\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Examine Top Shelf", 1
            menu.choice "Examine Middle Shelf", 2
            menu.choice "Examine Bottom Shelf", 3
            menu.choice "Examine under the Shelves", 4
            menu.choice "Return to the middle of the moom", 5
            menu.choice "View Escape Menu", 6
        end
        system('clear')
        if choice == 1
            self.shelves_top
        elsif choice == 2
            self.shelves_middle
        elsif choice == 3
            self.shelves_bottom
        elsif choice == 4
            self.shelves_under
        elsif choice == 5
            self.middle_of_room
        elsif choice == 6
            EscapeTheRoom.escape_menu
        end
    end

    def shelves_top
        prompt = TTY::Prompt.new
        puts "Description of The Top Shelf\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Back", 1
        end
        system('clear')
        if choice == 1
            self.shelves
        end
    end
    def shelves_middle
        prompt = TTY::Prompt.new
        puts "Description of The Middle Shelf\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Back", 1
        end
        system('clear')
        if choice == 1
            self.shelves
        end
    end
    def shelves_bottom
        prompt = TTY::Prompt.new
        puts "Description of The Bottom Shelf\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Back", 1
        end
        system('clear')
        if choice == 1
            self.shelves
        end
    end
    def shelves_under
        prompt = TTY::Prompt.new
        puts "Description of Under The Shelves\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Back", 1
        end
        system('clear')
        if choice == 1
            self.shelves
        end
    end
end