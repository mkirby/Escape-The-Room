require 'pry'
require "pastel"
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
            self.shelves
        elsif location == "Surgical Table"
            system("clear")
            ##Surgical Table method story
        elsif location == "Machine"
            system("clear")
            self.machine
        elsif location == "Bookcase"
            system("clear")
            ##Bookcase method story
        elsif location == "Desk"
            system("clear")
            self.desk
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
        elsif location == "Examine Desk Top"
            self.desk_top
        end
    end

    def intro
        prompt = TTY::Prompt.new
        system('clear')
        puts "Everything is black...\n\n"
        prompt.keypress("Continue", keys: [:space, :return])
        system('clear')
        puts "\nYour head feels clouded as if your thoughts swim through a fog. You try to open your eyes but your vision swims with pulsing, painful light.\n\n"
        prompt.keypress("Continue", keys: [:space, :return])
        system('clear')
        puts "You begin to open your eyes...\n\n"
        prompt.keypress("Continue", keys: [:space, :return])
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
                self.machine
            elsif choice == "Bookcase"
                ##Bookcase method story
                puts "Going to the #{choice}!"
            elsif choice == "Desk"
                self.desk
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

    def machine
        prompt = TTY::Prompt.new
        self.reload.machine_on
        if machine_on == true
            puts "You walk up to the buzzing machine.\n\nIt's full of life.\n\nThe desk nearby is suddenly humming away..."
        elsif machine_on == false
            puts "You walk up to the machine with two conical spires and a keypad.\n\nYou think, 'What could this thing possibly be for??'\n\n"
        end
        sleep 1
        
        choice = prompt.select('Where would you like to investigate?', per_page: 9) do |menu|
            menu.choice "Enter access code"
            menu.choice "Go back to middle of room"
            menu.choice "Escape Menu"
        end
        system("clear")

        if choice == "Enter access code"
            self.machine_access_code
        elsif choice == "Go back to middle of room"
            self.middle_of_room
        elsif choice == "Escape Menu"
            EscapeTheRoom.escape_menu
        end
    end
    def machine_access_code
        prompt = TTY::Prompt.new
        puts "The machine has four buttons and it looks like it takes 3 inputs"
        choices = ["╭╯", "╭╮", "╰╮", "╰╯"]
        choice1 = prompt.select("Enter the first symbol", choices)
        choice2 = prompt.select("Enter the second symbol", choices)
        choice3 = prompt.select("Enter the third symbol", choices)
        enter_code = choice1 + choice2 + choice3
        if enter_code  == "╭╯╭╮╰╯"
            self.machine_correct_code
        else 
            self.machine_incorrect_code
        end
    end
    def machine_correct_code
        prompt = TTY::Prompt.new
        self.update(machine_on: true)
            puts "'ACCESS GRANTED...'\n\n"
            sleep 2
            puts "You hear the machine start to turn on\n\n"
            sleep 2
            prompt.keypress("Press space or enter to go back", keys: [:space, :return])
            system("clear")
            self.machine
    end
    def machine_incorrect_code
        self.update(machine_on: false)
            puts "'ACCESS DENIED!'\n\n"
            puts "An electric shock zaps you"
            sleep 1
            EscapeTheRoom.change_health(-1)
            puts "Your health has been affected: -1"
            sleep 2
            system("clear")
            self.machine
    end
    
    def shelves
        prompt = TTY::Prompt.new
        puts "Description of Shelves as a whole\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Examine Top Shelf", 1
            menu.choice "Examine Middle Shelf", 2
            menu.choice "Examine Bottom Shelf", 3
            menu.choice "Examine under the Shelves", 4
            menu.choice "Return to the middle of the room", 5
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
        if !EscapeTheRoom.has_item?("Bible")
            puts "Description of The Bottom Shelf\n"
            choice = prompt.select('Choose an option') do |menu|
                menu.choice "Examine Bible", 1
                menu.choice "Back", 2
            end
            system('clear')
            if choice == 1
                self.shelves_bible
            elsif choice == 2
                self.shelves
            end
        else
            puts "Description of The Bottom Shelf WITHOUT Bible\n"
            choice = prompt.select('Choose an option') do |menu|
                menu.choice "Back", 1
            end
            system('clear')
            if choice == 1
                self.shelves
            end
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
    def shelves_bible
        prompt = TTY::Prompt.new
        puts "Description of Under The Bibles\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "View Creased Passage", 1
            menu.choice "Back", 2
        end
        system('clear')
        if choice == 1
            EscapeTheRoom.view_bible_passage
        elsif choice == 2
            system('clear')
            self.shelves
        end
    end

    def desk
        prompt = TTY::Prompt.new
        puts "Description of Desk as a whole\n"
        choice = prompt.select('Choose an option', per_page: 8) do |menu|
            menu.choice "Examine Desk Top", 1
            menu.choice "Examine Center Drawer", 2
            menu.choice "Examine Left Top Drawer", 3
            menu.choice "Examine Left Bottom Drawer", 4
            menu.choice "Examine Left Top Drawer", 5
            menu.choice "Examine Left Bottom Drawer", 6
            menu.choice "Return to the middle of the room", 7
            menu.choice "View Escape Menu", 8
        end
        system('clear')
        if choice == 1
            self.update(where_am_i: "#{choice}")
            self.desk_top
        elsif choice == 2
            self.desk_center #locked to start
        elsif choice == 3
            self.desk_left_top
        elsif choice == 4
            self.desk_left_bottom
        elsif choice == 5
            self.desk_right_top
        elsif choice == 6
            self.desk_right_bottom
        elsif choice == 7
            self.middle_of_room
        elsif choice == 8
            EscapeTheRoom.escape_menu
        end
    end
    def desk_top
        prompt = TTY::Prompt.new
        puts "The top of the desk is engraved with four mythical symbols:\n\n"
        #  ╭╯ = ><>  ╭╮ = ~(‾▿‾)~ ╰╯  = ˁ˚ᴥ˚ˀ
        puts "><>  ╭╯\n\n"
        puts "~(‾▿‾)~  ╭╮\n\n"
        puts "<:======  ╰╮\n\n"
        puts "ˁ˚ᴥ˚ˀ  ╰╯\n\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Back", 1
            menu.choice "View Escape Menu", 2
        end
        system('clear')
        if choice == 1
            self.desk
        elsif choice == 2
            EscapeTheRoom.escape_menu
        end
    end
    def desk_center
        prompt = TTY::Prompt.new
        if self.machine_on #true
            put "Descrition of opened drawer\n"
            if !EscapeTheRoom.has_item?("Journal")
                choice = prompt.select('Choose an option') do |menu|
                    menu.choice "View Journal", 1
                    menu.choice "Back"
                end
                system('clear')
                if choice == 1
                    self.desk_journal
                elsif choice == 2
                    self.desk
                end
            else
                puts "Description of opened drawer WITHOUT Journal\n"
                choice = prompt.select('Choose an option') do |menu|
                    menu.choice "Back", 1
                end
                system('clear')
                if choice == 1
                    self.desk
                end
            end
        else ## false
            puts "The drawer is locked tight and has no noticable keyhole."
            self.desk
        end
    end
    def desk_left_top
        prompt = TTY::Prompt.new
        puts "Description of Left Top Drawer\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Back", 1
        end
        system('clear')
        if choice == 1
            self.desk
        end
    end
    def desk_left_bottom
        prompt = TTY::Prompt.new
        puts "Description of Left Bottom Drawer\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Back", 1
        end
        system('clear')
        if choice == 1
            self.desk
        end
    end
    def desk_right_top
        prompt = TTY::Prompt.new
        puts "Description of Right Top Drawer\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Back", 1
        end
        system('clear')
        if choice == 1
            self.desk
        end
    end
    def desk_right_bottom
        prompt = TTY::Prompt.new
        puts "Description of Right Bottom Drawer\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Back", 1
        end
        system('clear')
        if choice == 1
            self.desk
        end
    end
    def desk_journal
        prompt = TTY::Prompt.new
        puts "Description of the Journal\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Browse Cover", 1
            menu.choice "Browse Journal Entries", 2
            menu.choice "View Back Cover", 3
            menu.choice "Back", 4
        end
        system('clear')
        if choice == 1
            EscapeTheRoom.view_journal_cover
        elsif choice == 2
            puts "You flip through the journal for any signs of helpful information. Everything contained within the journal just seems like the ramblings of a mad man.\n"
            self.desk_journal
        elsif choice == 3
            puts "The back cover of the journal is covered in many water ring stains as if it's regularly used as a coaster.\n"
            self.desk_journal
        elsif choice == 4
            system('clear')
            self.desk_center
        end
    end

end