require 'csv'
inventory = []
loyalty = []
prices = {small: 2, medium: 3, large: 4}
sales = {small: 0, medium: 0, large: 0}

def coffeeOrder
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
            loyalty = gets.chomp.to_i
            puts "#{size} #{type} with #{milk} and #{sugar}"
            puts "Is this order correct?"
            response = gets.chomp.downcase
            if response == "yes"
                removeCup
                mainMenu
            else
                coffeeOrder
            end
    
        end

def removeCup
    #Find cups in inventory
    result = inventory.find {|item| "cups" == item[:name] }
    #remove 1 cup
    result[:qty] = result[:qty] - 1
end

def checkLoyalty
    result = loyalty.find do |number|
        if  loyalty ==  number[:loyalty_number]
            number[:qty] + 1
             if number[:qty] == 5
                puts "Free 5th Coffee"
                number[:qty] = 0
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

def mainMenu
    puts "\e[H\e[2J"
    puts "-----------------------------------------------"
    puts "1. New Order   2. Inventory  3. Loyalty Program   4. End of day"
    puts "Enter the number of the option you would like"
    puts "-----------------------------------------------"
    action = gets.chomp.downcase 
    if action == "1"
        coffeeOrder
    elsif action == "2"
        # inventory = Inventory.new
    elsif action == "3"
        # loyalty = Loyalty.new
    elsif action == "4"
        # end_of_day = Eod.new
    else
        puts "Please enter 1, 2, 3 or 4"
        mainMenu
    end
end

mainMenu




# #Find cups in inventory
# result = inventory.find {|item| "cups" == item[:name] }

# #remove 1 cup
# result[:qty] = result[:qty] - 1

# #write inventory array to inventory.csv
# CSV.open('./csv/inventory.csv', "w") do |csv|
#     inventory.each do |item|
#         csv << [item[:name], item[:qty]]
#     end

# end