class Escape < ActiveRecord::Base
    has_many :records
    has_many :items, through: :records
    has_many :characters, through: :records


    def cage
        prompt = TTY::Prompt.new

        puts "You are in small cage with just enough room to lay down.\n\nYou feel a bit dizzy and hear footsteps coming from upstairs.\n\nYou look to your right and there is a cue stick resting by the floor of the cage.\n\nTo your left you see a set of keys dangling on a keyrack just outside of the cage.\n\n\n"
        sleep 2
        choice = prompt.select('Choose an option') do |menu|
            menu.choice "Yell for help"
            menu.choice "Grab cue stick"
            menu.choice "Reach for keys"
        end
        system("clear")
        if choice == "Yell for help"
            ####NEED story of captors beating character up and decreasing health by 3
            puts "You yell for help and a man runs down the stairs towards your cage.\n\nHe opens your cage door...unfortunately he has a bat.\n\nThat's the last thing you see before being knocked out.\n\n\n"
            ##character.health =- 3
            sleep 3
            prompt.keypress("Press space or enter to try again", keys: [:space, :return])
            system("clear")
            self.cage  ##Sends back to start of cage story of waking up dizzy
        elsif choice == "Grab cue stick"
            ###Need story of character grabbing stick and add cue stick to character.items
            #puts "You now have a cue stick, what what you like to do with it?"
            choice2 = prompt.select('You now have a cue stick, what what you like to do with it?') do |menu|
                menu.choice "Rattle cage and scream for help"
                menu.choice "Reach for keys with cue stick"
            end
            if choice2 == "Rattle cage and scream for help"
                puts "You rattle the cage and yell for help\n\nA man runs down the stairs towards your cage.\n\nHe opens your cage door...unfortunately he has a bat.\n\nThat's the last thing you see before being knocked out.\n\n\n"
                ###character.health =-3
                sleep 3
                prompt.keypress("Press space or enter to try again", keys: [:space, :return])
                system("clear")
                self.cage ##Sends back to start of cage story waking up dizzy

            elsif choice2 == "Reach for keys with cue stick"
                puts "You reach for the keys with the cue stick\n\nMiraculously you are about to get the key ring to slide down\n\nthe cue stick!! You pull the cue stick back into the cage\n\nand grab the keys! FREEDOM!!!"
                ###character.item ADD key and cuestick
                sleep 3
                choice3 = prompt.select('You now have the keys, what what you like to do with it?') do |menu|
                    menu.choice "Unlock the cage"
                end
                if choice3 == "Unlock the cage"
                    ###method that moves outside of the cage
                    puts "leaving the cage need method!"
                end
            end
                
        elsif choice == "Reach for keys"
            ###Need story of character grabbing keys immediate and hurting arm decreasing health by 1
            puts "You extend your arms and reach out for the keys\n\nyour fingertips are so close you can feel the chill from the metal.\n\nAHHH!! A bat flies in and tries to perch on your extended arm!\n\nThat's the last thing you remember before fainting from fear\n\n\n"
            ###character.terror =+3
            sleep 3
            prompt.keypress("Press space or enter to try again", keys: [:space, :return])
            system("clear")
            self.cage ##Sends back to start of cage story waking up dizzy
        end
    end

    def cage_main_menu

    end

    def cage_yell_help

    end

    def cage_reach_for_keys

    end

    def cage_cue_stick

    end


end