class EscapeTheRoom
    #this is our CLI class with @session_user and @session_character
    
    
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
            #NEED
            #@session_character into game
            puts "You wake up in a cage... coming soon"
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
            #NEED
            #verify location and load into that location
            #Escape.where_am_i_load_that_location
            puts "loads character's where am i... coming soon"
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

    def escape_menu
        prompt = TTY::Prompt.new
        choice = prompt.select("Escape Menu") do |menu|
            menu.choice "View Stats"
            menu.choice "View Inventory"
            menu.choice "Save & Quit"
        end
        if choice == "View Stats"
            @session_character.check_stats
        elsif choice == "View Inventory"
            @session_character.view_inventory
        elsif choice == "Save & Quit"
            @session_character.save_quit
        end
    end

    

end