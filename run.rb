require 'pry'
require_relative './config/environment'
require "tty-prompt"

puts "
███████╗░██████╗░█████╗░░█████╗░██████╗░███████╗  ████████╗██╗░░██╗███████╗  ██████╗░░█████╗░░█████╗░███╗░░░███╗
██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔════╝  ╚══██╔══╝██║░░██║██╔════╝  ██╔══██╗██╔══██╗██╔══██╗████╗░████║
█████╗░░╚█████╗░██║░░╚═╝███████║██████╔╝█████╗░░  ░░░██║░░░███████║█████╗░░  ██████╔╝██║░░██║██║░░██║██╔████╔██║
██╔══╝░░░╚═══██╗██║░░██╗██╔══██║██╔═══╝░██╔══╝░░  ░░░██║░░░██╔══██║██╔══╝░░  ██╔══██╗██║░░██║██║░░██║██║╚██╔╝██║
███████╗██████╔╝╚█████╔╝██║░░██║██║░░░░░███████╗  ░░░██║░░░██║░░██║███████╗  ██║░░██║╚█████╔╝╚█████╔╝██║░╚═╝░██║
╚══════╝╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝░░░░░╚══════╝  ░░░╚═╝░░░╚═╝░░╚═╝╚══════╝  ╚═╝░░╚═╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝"

puts "\nA SPOOKY- HORROR ADVENTURE APP WHERE YOU ESCAPE THE ROOM OR DIE!\n\n\n"

puts "BEGIN"
gets.chomp

$logged_in_user = User.all.first
system("clear")
User.main_menu
