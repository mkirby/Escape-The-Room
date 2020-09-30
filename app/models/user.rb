require "tty-prompt"

class User < ActiveRecord::Base
    has_many :characters

    def self.main_menu
        prompt = TTY::Prompt.new
        system("clear")
        welcome = prompt.select("Enter your log in credentials or create an account") do |menu|
            menu.choice "Log In"
            menu.choice "Sign Up"
        end
        if welcome == "Log In"
            system("clear")
            User.log_in
        elsif welcome == "Sign Up"
            system("clear")
            User.sign_up
        end
    end

    def self.sign_up
        prompt = TTY::Prompt.new
        username = prompt.ask("Choose a Username")
        password = prompt.mask("Choose a Password")
        user = User.create(username: username, password: password)
        puts 'User Created'
        sleep 2
        $logged_in_user = User.find_by username: username, password: password
        system("clear")
        User.user_menu
    end

    def self.log_in
        prompt = TTY::Prompt.new
        username = prompt.ask("Enter Your Username")
        password = prompt.mask("Enter Your Password")
        if User.find_by username: username, password: password
            #if username/ password match match
            $logged_in_user = User.find_by username: username, password: password
            system("clear")
            User.user_menu
            
        else
            #if username/ password don't match
            system("clear")
            choice = prompt.select('Username/Password not found.') do |menu|
            menu.choice "Retry Log In"
            menu.choice "Sign Up"
            end
            if choice == "Retry Log In"
                system("clear")
                User.log_in
            elsif choice == "Sign Up"
                system("clear")
                User.sign_up
            end
        end
    end

    def self.log_out
        $logged_in_user = nil
        User.main_menu
        system("clear")
    end

    def self.user_menu
        prompt = TTY::Prompt.new
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Start New Game"
            menu.choice "View Characters"
            menu.choice "Log Out"
        end
        if choice == "Start New Game"
            $logged_in_user.create_character
        elsif choice == "View Characters"
            if $logged_in_user.has_a_character?
                system("clear")
                User.characters_menu
            else
                puts "You have no characters! Start a new game!"
                sleep 2
                system("clear")
                User.user_menu
            end
        elsif choice == "Log Out"
            User.log_out
        end
    end

    def has_a_character?
        $logged_in_user.characters.count > 0
    end

    def create_character
        prompt = TTY::Prompt.new
        name = prompt.ask('What would you like to name your character?')
        character = Character.create(name: name, user_id: self.id)
        #this is the original start location
        #make sure this initialize matches whatever we call the first escape location
        escape = Escape.create(where_am_i: "Cage")
        record = Record.create(character_id: character.id, escape_id: escape.id)
        puts "#{character.name} Successfully Created"
        sleep 1
        #NEED
        #send to game beginning
        puts "You wake up in a cage... coming soon"
    end

    def self.characters_menu
        prompt = TTY::Prompt.new
        $logged_in_user.characters.reload.each do |character|
            puts character.name
        end
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Select a Character"
            menu.choice "Back"
        end
        if choice == "Select a Character"
            system("clear")
            User.select_character_menu
        elsif choice == "Back"
            system("clear")
            User.user_menu
        end
    end

    def self.select_character_menu
        prompt = TTY::Prompt.new
        character_name = $logged_in_user.characters.reload.map do |character|
            character.name
        end
        choice = prompt.select('Choose a character', character_name)

        choice2 = prompt.select('') do |menu|
            menu.choice "Continue Game"
            menu.choice "Rename Character"
            menu.choice "Delete Character"
            menu.choice "Back"
        end

        if choice2 == "Continue Game"
            #NEED
            #verify location and load into that location
            #Escape.where_am_i_load_that_location
            puts "loads character's where am i... coming soon"
        elsif choice2 == "Rename Character"
            new_name = prompt.ask('What would you like to name your character?')
            character = Character.find_by name: choice
            character.update(name: new_name)
            User.characters_menu
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
                if $logged_in_user.has_a_character?
                    User.characters_menu
                else
                    puts "You have no characters left. Start a new game."
                    User.user_menu
                end
            elsif confirm == "no"
                system("clear")
                User.select_character_menu
            end
        elsif choice2 == "Back"
            User.characters_menu
        end

    end

end