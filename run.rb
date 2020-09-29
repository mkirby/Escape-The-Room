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

def main_menu
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
        # puts "on your way to signup"
        #to sign up method
        #User.sign_up
    end
end

main_menu