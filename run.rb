require 'pry'
require_relative './config/environment'
require "tty-prompt"
prompt = TTY::Prompt.new


system("clear")
Logo.run
puts "\n\n\nA SPOOKY - HORROR ADVENTURE APP WHERE YOU ESCAPE THE ROOM OR DIE!\n\n"
sleep 2

EscapeTheRoom.main_menu