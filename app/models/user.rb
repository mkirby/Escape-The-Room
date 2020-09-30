require "tty-prompt"

class User < ActiveRecord::Base
    has_many :characters

    def has_a_character?
        if self.characters.count > 0
            system("clear")
            EscapeTheRoom.characters_menu
        else
            system("clear")
            puts "You have no characters. Start a new game."
            EscapeTheRoom.user_menu
        end
    end

    def create_character
        prompt = TTY::Prompt.new
        name = prompt.ask('What would you like to name your character?')
        character = Character.create(name: name, user_id: self.id)
        #this is the original start location
        #make sure this initialize matches whatever we call the first escape location
        escape = Escape.create(where_am_i: "Cage")
        record = Record.create(character_id: character.id, escape_id: escape.id)
        system("clear")
        puts "#{character.name} Successfully Created"
        character
    end
end