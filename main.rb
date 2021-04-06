require 'csv'

inventory = []
loyalty = []
prices = {small: 2, medium: 3, large: 4}
sales = {small: 0, medium: 0, large: 0}

def coffeeOrder(inventory, loyalty)
    puts "\e[H\e[2J"
    puts "What type of coffee?"
    type = gets.chomp.downcase
    puts "What size?"
    size = gets.chomp.downcase
    puts "Milk?"
    milk = gets.chomp.downcase
    puts "Sugar?"
    sugar = gets.chomp.downcase
    puts "Enter loyalty card number if available"
    loyalty_num = gets.chomp.to_i
    puts "#{size} #{type} with #{milk} and #{sugar}"
    puts "Is this order correct?"
        response = gets.chomp.downcase
            if response == "yes"
                removeCup(inventory)
                checkLoyalty(loyalty, loyalty_num)
                mainMenu(inventory, loyalty)
            else
                coffeeOrder
            end
    
end

def removeCup(array)
    #Find cups
    result = array.find {|item| "cups" == item[:name] }
    #remove 1 cup
    result[:qty] = result[:qty] - 1
end

def checkLoyalty(array, loyalty)
    result = array.each do |item|
        if  loyalty ==  item[:loyalty_number]
            result[:qty] + 1
             if result[:qty] == 5
                puts "Free 5th Coffee"
                sleep 5
                result[:qty] = 0
            end
        end
    end
end

def displayInventory(array, loyalty)
    puts "\e[H\e[2J"
    array.each do |line|
        puts "You have #{line[:qty]} units of #{line[:name]}"
    end
    puts "--------------------------------------"
    puts "         Options"
    puts "1. Edit Inventory 2. Exit"
    puts "--------------------------------------"
    input = gets.chomp
    if input == "1"
        #Execute edit method
    elsif input == "2"
        mainMenu(array, loyalty)
    end
end

def displayLoyalty(inventory,loyalty)
    puts "\e[H\e[2J"
    puts "Enter loyalty number"
    result = gets.chomp.to_i
    loyalty.each do |item|
    end
end

def endofDay
    #  write inventory array to inventory.csv
    CSV.open('./csv/inventory.csv', "w") do |csv|
         inventory.each do |item|
        csv << [item[:name], item[:qty]]
        end
    end
end

#open inventory.csv and save to array
CSV.open("./csv/inventory.csv") do |csv|
    csv.each do |line| 
        inventory.push({name: line[0], qty: line[1].to_i})
    end
end

#open loyalty.csv and save to array
CSV.open("./csv/loyalty.csv") do |csv|
    csv.each do |line|
        loyalty.push({loyalty_number: line[0], qty: line[1].to_i})
    end
end


puts "Welcome to CoffeePOS!"

def mainMenu(inventory, loyalty)
    puts "\e[H\e[2J"
    puts "-----------------------------------------------------------------"
    puts "1. New Order   2. Inventory  3. Loyalty Program   4. End of day"
    puts "Enter the number of the option you would like"
    puts "-----------------------------------------------------------------"
    action = gets.chomp.downcase 
    if action == "1"
        coffeeOrder(inventory, loyalty)
    elsif action == "2"
        displayInventory(inventory,loyalty)
    elsif action == "3"
    elsif action == "4"
    else
        puts "Please enter 1, 2, 3 or 4"
        mainMenu
    end
end

mainMenu(inventory, loyalty)




# #Find cups in inventory
# result = inventory.find {|item| "cups" == item[:name] }

# #remove 1 cup
# result[:qty] = result[:qty] - 1

# #write inventory array to inventory.csv
# CSV.open('./csv/inventory.csv', "w") do |csv|
#     inventory.each do |item|
#         csv << [item[:name], item[:qty]]
#     end
