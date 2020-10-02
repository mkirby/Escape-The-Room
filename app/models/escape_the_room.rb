
class EscapeTheRoom
    #this is our CLI class with @session_user and @session_character
    #line 86 error
    #line 137 error
    
    # █▀▄▀█ ▄▀█ █ █▄░█   █▀▄▀█ █▀▀ █▄░█ █░█
    # █░▀░█ █▀█ █ █░▀█   █░▀░█ ██▄ █░▀█ █▄█


    def self.main_menu
        prompt = TTY::Prompt.new
        welcome = prompt.select("Enter your log in credentials or create an account") do |menu|
            menu.choice "Log In"
            menu.choice "Sign Up"
        end
        if welcome == "Log In"
            system("clear")
            EscapeTheRoom.log_in
        elsif welcome == "Sign Up"
            system("clear")
            EscapeTheRoom.sign_up
        end
    end

    def self.sign_up
        prompt = TTY::Prompt.new
        username = prompt.ask("Choose a Username")
        password = prompt.mask("Choose a Password")
        user = User.create(username: username, password: password)
        puts 'User Created'
        sleep 2
        @session_user = User.all.find_by(username: username, password: password)
        system("clear")
        EscapeTheRoom.user_menu
    end

    def self.log_in
        prompt = TTY::Prompt.new
        username = prompt.ask("Enter Your Username")
        password = prompt.mask("Enter Your Password")
        if User.find_by username: username, password: password
            #if username/ password match match
            @session_user = User.find_by username: username, password: password
            system("clear")
            EscapeTheRoom.user_menu
        else
            #if username/ password don't match
            system("clear")
            choice = prompt.select('Username/Password not found.') do |menu|
            menu.choice "Retry Log In"
            menu.choice "Sign Up"
            end
            if choice == "Retry Log In"
                system("clear")
                EscapeTheRoom.log_in
            elsif choice == "Sign Up"
                system("clear")
                EscapeTheRoom.sign_up
            end
        end
    end

    def self.log_out
        @session_user = nil
        system("clear")
        EscapeTheRoom.main_menu
    end


    # █░█ █▀ █▀▀ █▀█   █▀▄▀█ █▀▀ █▄░█ █░█
    # █▄█ ▄█ ██▄ █▀▄   █░▀░█ ██▄ █░▀█ █▄█


    def self.user_menu
        prompt = TTY::Prompt.new
        puts "Hello, #{@session_user.username}"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Start New Game"
            menu.choice "View Characters"
            menu.choice "Log Out"
        end
        if choice == "Start New Game"
            @session_character = @session_user.create_character
            @session_character.escapes.first.intro
        elsif choice == "View Characters"
            @session_user.has_a_character?
        elsif choice == "Log Out"
            EscapeTheRoom.log_out
        end
    end

    def self.characters_menu
        prompt = TTY::Prompt.new
        puts "#{@session_user.username}'s Characters:\n\n"
        characters = @session_user.characters.reload.collect { |character| character.name}
        characters.sort!
        characters.each do |character|
            puts character
        end
        choice = prompt.select("\nChoose an option") do |menu|
            menu.choice "Select a Character"
            menu.choice "Back"
        end
        if choice == "Select a Character"
            system("clear")
            EscapeTheRoom.select_character_menu
        elsif choice == "Back"
            system("clear")
            EscapeTheRoom.user_menu
        end
    end
    
    def self.select_character_menu
        prompt = TTY::Prompt.new
        character_name = @session_user.characters.reload.map do |character|
            character.name
        end
        choice = prompt.select("Choose a character", character_name.sort)
        choice2 = prompt.select('') do |menu|
            menu.choice "Continue Game"
            menu.choice "Rename Character"
            menu.choice "Delete Character"
            menu.choice "Back"
        end
        if choice2 == "Continue Game"
            @session_character = Character.find_by name: choice
            @session_character.escapes.first.where_am_i_load_that_location
        elsif choice2 == "Rename Character"
            new_name = prompt.ask('What would you like to name your character?')
            character = Character.find_by name: choice
            character.update(name: new_name)
            system("clear")
            EscapeTheRoom.characters_menu
        elsif choice2 == "Delete Character"
            confirm = prompt.select("Are you sure you want to delete #{choice}?") do |q|
                q.choice "yes"
                q.choice "no"
            end
            if confirm == "yes"
                character = Character.find_by name: choice
                escape = character.escapes[0]
                record = character.records
                puts "#{character.name} was swallowed into the abyss"
                sleep 2
                character.destroy
                escape.destroy
                record.destroy_all
                system("clear")
                @session_user.has_a_character?
            elsif confirm == "no"
                system("clear")
                EscapeTheRoom.characters_menu
            end
        elsif choice2 == "Back"
            system("clear")
            EscapeTheRoom.characters_menu
        end
    end

    
    # █▀▀ █▀ █▀▀ ▄▀█ █▀█ █▀▀   █▀▄▀█ █▀▀ █▄░█ █░█
    # ██▄ ▄█ █▄▄ █▀█ █▀▀ ██▄   █░▀░█ ██▄ █░▀█ █▄█


    def self.escape_menu
        prompt = TTY::Prompt.new
        choice = prompt.select("Escape Menu") do |menu|
            menu.choice "View Stats"
            menu.choice "View Inventory"
            menu.choice "Return to Game"
            menu.choice "Save & Quit"
        end
        if choice == "View Stats"
            @session_character.check_stats
            self.escape_menu
        elsif choice == "View Inventory"
            @session_character.view_inventory
            self.escape_menu
        elsif choice == "Return to Game"
            @session_character.escapes.first.where_am_i_load_that_location
        elsif choice == "Save & Quit"
            @session_character.save_quit
        end
    end


    # █ █▄░█   █▀▀ ▄▀█ █▀▄▀█ █▀▀   █░█ █▀▀ █░░ █▀█ █▀▀ █▀█ █▀
    # █ █░▀█   █▄█ █▀█ █░▀░█ ██▄   █▀█ ██▄ █▄▄ █▀▀ ██▄ █▀▄ ▄█


    def self.add_character_item(item_name)
        if !self.has_item?(item_name)
            item = Item.all.find_by name: item_name
            new_record = Record.create(character_id: @session_character.id, item_id: item.id, item_used?: false)
        else
            @session_character.items.find_by name: item_name
        end
    end

    def self.change_health(num)
        new_health = @session_character.health + num
        if new_health > 10
            @session_character.update(health: 10)
        elsif new_health <= 0
            EscapeTheRoom.dead
        else
            @session_character.update(health: new_health) 
        end
    end

    def self.change_terror(num)
        new_terror = @session_character.terror + num
        if new_terror >= 10
            EscapeTheRoom.insane
        elsif new_terror < 0
            @session_character.update(terror: 0)
        else
            @session_character.update(terror: new_terror) 
        end
    end

    def self.dead
        system('clear')
        puts "#{@session_character.name} has died."
        sleep 3
        EscapeTheRoom.user_menu
    end

    def self.insane
        system('clear')
        puts "#{@session_character.name} has gone insane."
        sleep 3
        EscapeTheRoom.user_menu
    end

    def self.has_item?(item_name)
        @session_character.items.map { |item| item.name == item_name}.include?(true)
    end

    def self.view_bible_passage
        pastel = Pastel.new
        prompt = TTY::Prompt.new
        puts "There are three separate highlights on this page\n\n"
        print "And the evening and the morning were the fifth day. And God said, Let the earth bring forth the living creature after his kind, cattle, and creeping thing, and beast of the earth after his kind: and it was so. And God made the beast of the earth after his kind, and cattle after their kind, and every thing that creepeth upon the earth after his kind: and God saw that it was good. And God said, Let us make man in our image, after our likeness: and let them have dominion over the "
        print pastel.red"fish"
        print " of the sea, and over the "
        print pastel.red"fowl"
        print " of the air, and over the "
        print pastel.red"cattle"
        puts ", and over all the earth, and over every creeping thing that creepeth upon the earth. So God created man in his own image, in the image of God created he him; male and female created he them. And God blessed them, and God said unto them, Be fruitful, and multiply, and replenish the earth, and subdue it: and have dominion over the fish of the sea, and over the fowl of the air, and over every living thing that moveth upon the earth. And God said, Behold, I have given you every herb bearing seed, which is upon the face of all the earth, and every tree, in the which is the fruit of a tree yielding seed; to you it shall be for meat.\n\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Take the Bible", 1
            menu.choice "Back", 2
        end
        system('clear')
        if choice == 1
            EscapeTheRoom.add_character_item("Bible")
            @session_character.escapes.first.shelves
        elsif choice == 2
            system('clear')
            @session_character.escapes.first.shelves_bible
        end
    end

    def self.view_journal_cover
        pastel = Pastel.new
        prompt = TTY::Prompt.new
        puts "Description of Journal cover\n\n"
        puts "You open the cover and notice a small inscription on the inside: "
        puts pastel.red"\nProperty of Dr. F\nDoB: 03/11/18\nLicense Number: BOES348562945\n"
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Take the Journal", 1
            menu.choice "Back", 2
        end
        system('clear')
        if choice == 1
            EscapeTheRoom.add_character_item("Journal")
            @session_character.escapes.first.desk
        elsif choice == 2
            system('clear')
            @session_character.escapes.first.desk_journal
        end
    end

    def self.change_machine_powered_on_status_to(boolean)
        @session_character.escapes.first.update(machine_on: boolean)
    end

    def self.has_zero_items?
        @session_character.items.count == 0
    end

    def self.thanks_for_playing
        prompt = TTY::Prompt.new
        puts "Thank you so much for playing our little cli game. Lots of hard work went into planning our escape story and puzzles. We hope you enjoyed it!\n\n"
        prompt.keypress("To Return To The Menu Press Enter", keys: [:space, :return])
        EscapeTheRoom.user_menu
    end
end