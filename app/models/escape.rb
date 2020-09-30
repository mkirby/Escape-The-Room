class Escape < ActiveRecord::Base
    has_many :records
    has_many :items, through: :records
    has_many :characters, through: :records

    def self.intro
        prompt = TTY::Prompt.new
        system('clear')
        puts "Everything is black..."
        sleep 3
        puts "\nYour head feels clouded as if your thoughts swim through a fog. You try to open your eyes but your vision swims with pulsing, painful light."
        sleep 7
        system('clear')
        puts "You begin to open your eyes..."
        sleep 3
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
        Escape.cage
    end
end