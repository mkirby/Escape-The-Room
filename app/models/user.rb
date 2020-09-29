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
        # NEED
        'need to make logged in menu'
        #user.logged_in_menu
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

end