require 'pry'
require_relative './config/environment'
require "tty-prompt"


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
EscapeTheRoom.main_menu