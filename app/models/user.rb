require "tty-prompt"

class User < ActiveRecord::Base
    has_many :characters

    def self.main_menu
        prompt = TTY::Prompt.new
        system("clear")
        welcome = prompt.select("") do |menu|
            menu.choice "Sign Up"
            menu.choice "Log In"
        end
        if welcome == "Log In"
            # puts "on your way to login"
            #to log in method
            #User.log_in
        elsif welcome == "Sign Up"
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
        puts 'need to make logged in menu'
        #user.logged_in_menu
    end
end