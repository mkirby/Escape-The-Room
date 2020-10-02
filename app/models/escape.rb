require 'pry'
require "pastel"
class Escape < ActiveRecord::Base
    has_many :records
    has_many :items, through: :records
    has_many :characters, through: :records

    def where_am_i_load_that_location
        location = self.where_am_i
        system("clear")
        if location == "Pool Table"
            #not made yet
            self.middle_of_room
        elsif location == "Shelves"
            self.shelves
        elsif location == "Surgical Table"
            #not made yet
            self.middle_of_room
        elsif location == "Machine"
            self.machine
        elsif location == "Bookcase"
            ##not made yet
            self.middle_of_room
        elsif location == "Desk"
            self.desk
        elsif location == "Safe"
            self.safe
        elsif location == "Door Up The Stairs"
            self.door
        elsif location == "Middle of Room"
            self.middle_of_room
        elsif location == "Cage"
            self.cage
        elsif location == "Examine Desk Top"
            self.desk_top
        elsif location == "Examine Center Drawer"
            self.desk_center
        elsif location == "Viewing Journal"
            self.desk_journal
        # elsif location == "Examine Left Top Drawer"
        #     self.desk_left_top
        # elsif location == "Examine Right Top Drawer"
        #     self.desk_right_top
        end
    end

    def intro
        prompt = TTY::Prompt.new
        system('clear')
        puts "Everything is black...\n\n"
        prompt.keypress("Continue", keys: [:space, :return])
        system('clear')
        puts "Your head feels clouded as if your thoughts swim through a fog. You try to open your eyes but your vision swims with pulsing, painful light.\n\n"
        prompt.keypress("Continue", keys: [:space, :return])
        system('clear')
        puts "You begin to open your eyes...\n\n"
        prompt.keypress("Continue", keys: [:space, :return])
        system('clear')
        puts "\nYou feel the coldness of a cement floor beneath your body, as your eyes adjust to the yellow glow of overhead lights."
        puts "\nYou find yourself laying in a floor to ceiling cage with just enough floor space to lay down."
        puts "\nThe sound of footsteps on the floor above draws your attention to the room outside your cage."
        puts "\nYour cage is located in the corner of a partially finished basement with no windows to the outside world."
        puts "\nAn iron bar door with a brass lock keeps you from escaping."
        puts "\nThere is a pool table hastily pushed into the corner off to your right and a surgical table sitting prominently in middle of the room."
        puts "\nA broken cue stick rack has dropped several cue sticks that have rolled across the floor."
        puts "\nA towering machine with two conical spires looms on the far wall between a large wooden desk and a dusty bookcase."
        puts "\nA metal door is closed at the top of a wooden staircase."
        puts "\nYou can see the front of a small safe next to the desk protruding out of the wall from under the staircase."
        puts "\nA long row of rusty metal shelves is filled with jars, surgical supplies, and an overflow of dusty items that can aptly be called 'junk'."
        puts "\nAt the end of those shelves, hanging from a hook a few feet away from the bars of your cage, dangles a ring of brass keys.\n\n"
        prompt.keypress("Press Space Or Enter To Try To Escape...", keys: [:space, :return])
        system("clear")
        self.cage
    end
    def knockout_intro
        prompt = TTY::Prompt.new
        puts "Your vision is blurry as you come to. You sit up to find yourself LOCKED BACK IN THE CAGE!\n\n"
        prompt.keypress("Begin Your Escape Again", keys: [:space, :return])
        system('clear')
        self.cage
    end
    def cage
        prompt = TTY::Prompt.new
        self.update(where_am_i: "Cage")
        puts "You lean against the bars and decide what to do.\n\n"
        choice = prompt.select('Choose An Option') do |menu|
            menu.choice "Yell For Help"
            menu.choice "Reach For Cue Stick"
            menu.choice "Reach For Keys"
            menu.choice "View Escape Menu"
        end
        system("clear")
        if choice == "Yell For Help"
            self.cage_yell
        elsif choice == "Reach For Cue Stick"
            self.cage_reach_cue
        elsif choice == "Reach For Keys"
            self.cage_reach_keys
        elsif choice == "View Escape Menu"
            EscapeTheRoom.escape_menu
        end
    end
    def cage_yell
        prompt = TTY::Prompt.new
        puts "You yell and scream for help and a crazy looking disheveled older man runs down the stairs towards your cage.\n\n"
        ##NEED a good exposition
        puts "Extensive Exposition by your captor better known as DR. FRANKENSTEIN.\n\n"
        puts "The basement slowly fills with toxic gases and the last thought you remember was sheer terror.\n\n"
        prompt.keypress("Press Space Or Enter To Wake Up", keys: [:space, :return])
        system("clear")
        puts "You have splitting headache and you fear that you'll never escape this room.\n\n"
        puts "You health has been affected: -3"
        EscapeTheRoom.change_health(-3)
        puts "You terror has risen: +2\n\n"
        EscapeTheRoom.change_terror(2)
        self.knockout_intro
    end
    def cage_reach_cue
        prompt = TTY::Prompt.new
        puts "You just manage to get a finger on a cue stick and roll it towards your cage.\n\n"
        EscapeTheRoom.add_character_item("Cue Stick")
        choice = prompt.select('You now have a cue stick, what would you like to do with it?') do |menu|
            menu.choice "Reach For The Keys With The Cue Stick", 1
        end
        system('clear')
        if choice == 1
            puts "You reach for the keys with the cue stick. It takes all your concentration to line up the cue stick with the keyring.\n\n"
            puts "Miraculously you get the key ring to slide down the cue stick!!\n\n"
            puts "You pull the cue stick back into the cage and grab the keys! FREEDOM!!!\n\n"
            EscapeTheRoom.add_character_item("Ring of Keys")
            choice2 = prompt.select('You now have the ring of keys, what would you like to do with it?') do |menu|
                menu.choice "Unlock The Cage", 1
            end
            if choice2 == 1
                puts "The cage lock clicks open and you're one step closer to escape.\n\n"
                system('clear')
                self.middle_of_room
            end
        end
    end
    def cage_reach_keys
        prompt = TTY::Prompt.new
        bugs = ["spider", "centipede", "cricket", "roach", "earwig"]
        bug = bugs.sample
        puts "You extend your arms and reach out for the keys. Your fingertips are so close you can feel the chill from the metal.\n\n"
        puts "With all your focus on extending your arm out, you barely notice the large #{bug} drop down on your shoulder.\n\n"
        puts "Before you can react, it crawls onto your neck and down your back. You shake out your shirt but can't the #{bug}.\n\n"
        EscapeTheRoom.change_terror(3)
        puts "You terror has risen: +3\n\n"
        prompt.keypress("Try Something Else", keys: [:space, :return])
        system("clear")
        self.cage
    end

    def middle_of_room
        prompt = TTY::Prompt.new
        self.update(where_am_i: "Middle of Room")
        puts "You're currently standing in the middle of the basement thinking about the escape plan.\n\n"
        choice = prompt.select('Where Would You Like To Investigate?', per_page: 9) do |menu|
            menu.choice "Pool Table"
            menu.choice "Shelves"
            menu.choice "Surgical Table"
            menu.choice "Machine"
            menu.choice "Bookcase"
            menu.choice "Desk"
            menu.choice "Safe"
            menu.choice "Door Up The Stairs"
            menu.choice "Escape Menu"
        end
        system("clear")
        if choice != "Escape Menu"
            self.update(where_am_i: "#{choice}")
            if choice == "Pool Table" || choice == "Surgical Table" || choice == "Bookcase"
                self.update(where_am_i: "Middle of Room")
                puts "The #{choice} blinks from existance as if it didn't exist yet!\n\n"
                self.middle_of_room
            elsif choice == "Shelves"
                self.shelves
            elsif choice == "Machine"
                self.machine
            elsif choice == "Desk"
                self.desk
            elsif choice == "Safe"
                self.safe
            elsif choice == "Door Up The Stairs"
                self.door
            end
        elsif choice == "Escape Menu"
            EscapeTheRoom.escape_menu
        end
    end

    def machine
        prompt = TTY::Prompt.new
        self.reload.machine_on
        if machine_on == true
            puts "You're standing in front of the machine as it buzzes and crackles with sparks of electricity.\n\nIt's full of life.\n\n"
            choice = prompt.select('Where would you like to investigate?') do |menu|
                menu.choice "Turn Off The Machine"
                menu.choice "Return To The Middle Of The Room"
                menu.choice "Escape Menu"
            end
            system("clear")
            if choice == "Turn Off The Machine"
                EscapeTheRoom.change_machine_powered_on_status_to(false)
                self.machine
            elsif choice == "Return To The Middle Of The Room"
                self.middle_of_room
            elsif choice == "Escape Menu"
                EscapeTheRoom.escape_menu
            end
        elsif machine_on == false
            puts "You're standing in front of the quiet machine with two conical spires and a dimly illuminated keypad asking for an access code.\n\n'What could this thing possibly be for??'\n\n"
            choice = prompt.select('Where would you like to investigate?') do |menu|
                menu.choice "Enter Access Code"
                menu.choice "Return To The Middle Of The Room"
                menu.choice "Escape Menu"
            end
            system("clear")
            if choice == "Enter Access Code"
                self.machine_access_code
            elsif choice == "Return To The Middle Of The Room"
                self.middle_of_room
            elsif choice == "Escape Menu"
                EscapeTheRoom.escape_menu
            end
        else
            puts "machine_on not updating correctly - find error"
        end
    end
    def machine_access_code
        prompt = TTY::Prompt.new
        puts "The machine has four buttons and it looks like it takes 3 inputs"
        choices = ["╭╯\n", "╰╮\n","╭╮\n","╰╯\n"]
        choice1 = prompt.select("Enter the first symbol", choices)
        choice2 = prompt.select("Enter the second symbol", choices)
        choice3 = prompt.select("Enter the third symbol", choices)
        enter_code = choice1 + choice2 + choice3
        system('clear')
        if enter_code  == "╭╯\n╭╮\n╰╯\n"
            self.machine_correct_code
        else 
            self.machine_incorrect_code
        end
    end
    def machine_correct_code
        prompt = TTY::Prompt.new
        EscapeTheRoom.change_machine_powered_on_status_to(true)
        puts "'ACCESS GRANTED'"
        sleep 0.5
        print "."
        sleep 0.5
        print "."
        sleep 0.5
        print ".\n\n"
        sleep 0.5
        puts "As the machine grumbles on you think you hear an audible click from the desk to your left before the sparks of electricity coming off the machine's spires draw your attention.\n\n"
        prompt.keypress("Return to the Machine", keys: [:space, :return])
        system("clear")
        self.machine
    end
    def machine_incorrect_code
        prompt = TTY::Prompt.new
        EscapeTheRoom.change_machine_powered_on_status_to(false)
        puts "'ACCESS DENIED!'\n\n"
        puts "An electric shock zaps you.\n\n"
        EscapeTheRoom.change_health(-1)
        puts "Your health has been affected: -1\n\n"
        prompt.keypress("Return to the Machine", keys: [:space, :return])
        system("clear")
        self.machine
    end
    
    def shelves
        prompt = TTY::Prompt.new
        puts "A long row of rusty metal shelves is filled with jars, surgical supplies, and an overflow of dusty items that can aptly be called 'junk'.\n\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Examine Top Shelf", 1
            menu.choice "Examine Middle Shelf", 2
            menu.choice "Examine Bottom Shelf", 3
            menu.choice "Examine Under the Shelves", 4
            menu.choice "Return To The Middle Of The Room", 5
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

    def safe
        prompt = TTY::Prompt.new
        puts "You are standing in front of the combination locked safe\n\nprotuding from under the staircase\n" ####### NEEDED
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Find out what's inside the safe"
            menu.choice "Return to the middle of the room"
            menu.choice "View Escape Menu"
        end
        system('clear')
        if choice == "Find out what's inside the safe"
            self.safe_code
        elsif choice == "Return to the middle of the room"
            self.middle_of_room
        elsif choice == "View Escape Menu"
            EscapeTheRoom.escape_menu
        end
    end
    def safe_code
        prompt = TTY::Prompt.new
        if !EscapeTheRoom.has_item?("Key")
            puts "You place your fingers on the dial and spin to reset the code."
            choice1 = prompt.ask('The first number you spin the dial to:')
            choice2 = prompt.ask('The second number you spin the dial to:')
            choice3 = prompt.ask ('The third number you spin the dial to')
            combination = choice1 + choice2 + choice3
            if combination == "031118"
                puts "You grab the door of the safe and pull...\n\n"
                sleep 1
                puts "You feel the door swing open and you look inside...\n\n"
                sleep 2
                puts "A SHINY KEY!\n\n"
                sleep 1
                puts "You grab the key and towards the door at the top of the staircase with hope..."
                EscapeTheRoom.add_character_item("Key")
                prompt.keypress("Press space or enter to go back", keys: [:space, :return])
                system("clear")
                self.safe
            else
                puts "You grab the door of the safe and pull...\n\n"
                sleep 1
                puts "Nothing.\n\nYou think, 'I wonder what the combination could be'"
                prompt.keypress("Press space or enter to go back", keys: [:space, :return])
                system("clear")
                self.safe
            end
        else EscapeTheRoom.has_item?("Key")
            puts "The safe is open and you have the key!\n\nThere is nothing else in here"
            prompt.keypress("Press space or enter to go back", keys: [:space, :return])
            system("clear")
            self.safe
        end
    end

    def desk
        prompt = TTY::Prompt.new
        puts "You are standing in front of a metal desk.\n\nThere are three drawers.\n\nTwo large drawers on the left and right, and a smaller one in the center.\n\n 'Hmmm, I wonder what could be in these drawers?'\n\n"
        self.update(where_am_i: "Desk")
        choice = prompt.select('Choose an option', per_page: 8) do |menu|
            menu.choice "Examine Desk Top\n", 1
            menu.choice "Examine Center Drawer\n", 2
            menu.choice "Examine Left Top Drawer\n", 3
            #menu.choice "Examine Left Bottom Drawer\n", 4
            menu.choice "Examine Right Top Drawer\n", 5
            #menu.choice "Examine Right Bottom Drawer\n", 6
            menu.choice "Return to the middle of the room\n", 7
            menu.choice "View Escape Menu", 8
        end
        system('clear')
        if choice == 1
            self.update(where_am_i: "Examine Desk Top")
            self.desk_top
        elsif choice == 2
            self.update(where_am_i: "Examine Center Drawer") ### ADD TO WHEREAMILOADTHATLOCATION METHOD
            self.desk_center #locked to start
        elsif choice == 3
            # self.update(where_am_i: "Examine Left Top Drawer")
            self.desk_left_top
        #elsif choice == 4
            #self.desk_left_bottom
        elsif choice == 5
            # self.update(where_am_i: "Examine Right Top Drawer")
            self.desk_right_top
        #elsif choice == 6
            #self.desk_right_bottom
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
            puts "You see that the center drawer is slightly open.\n\n"
            if !EscapeTheRoom.has_item?("Journal")
                puts "You pull open the center drawer.\n\nYou quickly rummage through the drawer and\n\nyou find a journal laying under sheets of paper.\n\n"
                choice = prompt.select('Choose an option\n\n') do |menu|
                    menu.choice "View Journal", 1
                    menu.choice "Back", 2
                end
                system('clear')
                if choice == 1
                    self.update(where_am_i: "Viewing Journal")
                    self.desk_journal
                elsif choice == 2
                    self.desk
                end
            else
                puts "You pull open the center drawer.\n\nThere's nothing left in here, you have the Journal in your inventory.\n\n"
                choice = prompt.select('Choose an option\n\n') do |menu|
                    menu.choice "Back", 1
                end
                system('clear')
                if choice == 1
                    self.desk
                end
            end
        else ## false
            puts "You try to pull the center drawer\n\n"
            puts "The drawer is locked tight and has no noticable keyhole.\n\n"
            prompt.keypress("Press to return", keys: [:space, :return])
            system("clear")
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
    # def desk_left_bottom
    #     prompt = TTY::Prompt.new
    #     puts "Description of Left Bottom Drawer\n"
    #     choice = prompt.select('Choose an option') do |menu|
    #         menu.choice "Back", 1
    #     end
    #     system('clear')
    #     if choice == 1
    #         self.desk
    #     end
    # end
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
    # def desk_right_bottom
    #     prompt = TTY::Prompt.new
    #     puts "Description of Right Bottom Drawer\n"
    #     choice = prompt.select('Choose an option') do |menu|
    #         menu.choice "Back", 1
    #     end
    #     system('clear')
    #     if choice == 1
    #         self.desk
    #     end
    # end
    def desk_journal
        prompt = TTY::Prompt.new
        puts "You grab the journal. It looks really worn and old.\n\nAs if it has been used for many years.\n\n\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Browse Cover", 1
            menu.choice "Browse Journal Entries", 2
            menu.choice "Browse Back Cover", 3
            menu.choice "Back", 4
        end
        system('clear')
        if choice == 1
            EscapeTheRoom.view_journal_cover
        elsif choice == 2
            puts "You flip through the journal for any signs of helpful information.\n\nEverything contained within the journal just seems like the ramblings of a mad man.\n\n"
            prompt.keypress("Press to return", keys: [:space, :return])
            system("clear")
            self.desk_journal
        elsif choice == 3
            puts "The back cover of the journal is covered in many water ring stains\n\nas if it's regularly used as a coaster.\n\n"
            prompt.keypress("Press to return", keys: [:space, :return])
            system("clear")
            self.desk_journal
        elsif choice == 4
            system('clear')
            self.update(where_am_i: "Examine Center Drawer")
            self.desk_center
        end
    end

    def door
        prompt = TTY::Prompt.new
        if !EscapeTheRoom.has_item?("Key")
            puts "You're standing at the top of the staircase and infront of you is a sturdy metal door.\n\n"
            choice = prompt.select('Choose an option') do |menu|
                menu.choice "Examine Door", 1
                menu.choice "Bang on Door", 2
                menu.choice "Back", 3
            end
            system('clear')
            if choice == 1
                system('clear')
                puts "There are no visible gaps between the door and it's hinges. A small shiny key hole sits below the door handle. None of the keys on the ring fit in this lock.\n\n"
                self.door
            elsif choice == 2
                system('clear')
                puts "You bang on the door repeatedly over and over and your pleas for mercy go unanswered. Suddenly electricity flows through every inch of your body and you faint...\n\n"
                self.knockout_intro
            elsif choice == 3
                self.middle_of_room
            end
        else #this means they have the key
            puts "The shiny key felt heavy in your hand as you slowly ascended the stairs. All you can hope is that you can make it out to the street. Everything after right now is luck.\n\n"
            choice = prompt.select('Choose an option') do |menu|
                menu.choice "Quietly Unlock Door", 1
                menu.choice "Wait I Forgot Something", 2
            end
            system('clear')
            if choice == 1
                #unlock door - Go to CONGRADULATIONS YOU ESCAPED!
                puts "You open the door from the basement and YOU ESCAPED!\n\n"
                sleep 5
                EscapeTheRoom.thanks_for_playing
            elsif choice == 2
                self.middle_of_room
            end
        end
    end
end