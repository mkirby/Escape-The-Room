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
            system("clear")
            ## NEED
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
            menu.choice "Create New Character"
            menu.choice "View Characters"
            menu.choice "Log Out"
        end
        if choice == "Create New Character"
            ## NEED
            ####create new character method 
        elsif choice == "View Characters"
            system("clear")
            User.characters_menu
        elsif choice == "Log Out"
            User.log_out
        end
    end

    def self.characters_menu
        prompt = TTY::Prompt.new
        $logged_in_user.characters.each do |character|
            puts character.name
        end
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Select a Character"
            menu.choice "Back"
        end
        if choice == "Select a Character"
            ## NEED to create select character method
        elsif choice == "Back"
            User.user_menu
        end
    end

    ##delete character

end