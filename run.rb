require 'pry'
require_relative './config/environment'
require "tty-prompt"

class EscapeTheRoom
    attr_accessor :session_user, :session_character

    def initialize(session_user, session_character = nil)
        @session_user = session_user
        @session_character = session_character
    end

    def self.run
        prompt = TTY::Prompt.new
        system("clear")
        puts "[LOGO HERE]"
        #Logo.run
        puts "\n\n\nA SPOOKY - HORROR ADVENTURE APP WHERE YOU ESCAPE THE ROOM OR DIE!"
        sleep 1
        prompt.keypress("Press space or enter to begin", keys: [:space, :return])

        #to be removed once changed in other User methods
        $logged_in_user = nil
        $current_character = nil

        system("clear")
        User.main_menu
    end
end

EscapeTheRoom.run