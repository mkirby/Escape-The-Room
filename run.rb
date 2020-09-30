require 'pry'
require_relative './config/environment'
require "tty-prompt"
prompt = TTY::Prompt.new

#Logo.run

puts "\n\n\nA SPOOKY - HORROR ADVENTURE APP WHERE YOU ESCAPE THE ROOM OR DIE!\n\n\n"
sleep 1
prompt.keypress("Press space or enter to begin", keys: [:space, :return])

$logged_in_user = nil
$current_character = nil
system("clear")
User.main_menu
