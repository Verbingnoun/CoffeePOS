require './classes/coffee.rb'

# sales = [ {small: 0}, {medium: 0} {large: 0} ]

# small = 2
# medium = 3
# large = 4

puts "Welcome to CoffeePOS!"

def mainMenu
    puts "\e[H\e[2J"
    puts "-----------------------------------------------"
    puts "1.New Order   2.Inventory  3.Loyalty Program"
    puts "Enter the number of the option you would like"
    puts "-----------------------------------------------"
    action = gets.chomp.downcase 
    if action == "1"
        order = Coffee.new
        order.coffeeOrder
    elsif action == "2"
        # inventory = Inventory.new
    elsif action == "3"
        # loyalty = Loyalty.new
    else
        puts "Please enter 1, 2 or 3"
        mainMenu
    end
end

mainMenu