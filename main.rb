require 'csv'

inventory = []
loyalty = []
prices = {small: 2, medium: 3, large: 4}
sales_hash = {small: 0, medium: 0, large: 0}

def coffeeOrder(inventory, loyalty, sales_hash)
    order_hash = {}
    loop do
        puts "\e[H\e[2J"
        puts "What type of coffee?"
        order_hash[:type] = gets.chomp.downcase
        puts "\e[H\e[2J"
        puts "What size? large/medium/small"
        order_hash[:size] = gets.chomp.downcase
        puts "\e[H\e[2J"
        puts "Milk? full cream/lactose free/soy/no"
        order_hash[:milk] = gets.chomp.downcase
        puts "\e[H\e[2J"
        puts "Sugar? yes/no"
        order_hash[:sugar] = gets.chomp.downcase
        puts "\e[H\e[2J"
        puts "Enter loyalty card number if available, else type no"
        order_hash[:loyalty_num] = gets.chomp
        puts "\e[H\e[2J"
        puts "#{order_hash[:size]} #{order_hash[:type]}, #{order_hash[:milk]} milk and loyalty number #{order_hash[:loyalty_num]}"
        puts "Is this order correct? yes/no/main-menu"
        response = gets.chomp.downcase
        if response == "yes"
            addToSales(order_hash[:size], sales_hash)
            updated_inventory = removeCup(inventory)
            # if order_hash[:sugar] == "yes"
            #     updated_inventory = removeSugar(inventory)
            checkLoyalty(loyalty, order_hash[:loyalty_num])
            return updated_inventory
        elsif response == "main-menu"
            return inventory
        end
    end
end

def editInventory(inventory)
    puts "\e[H\e[2J"
    puts "What item would you like to edit? milk/beans/cups/sugar"
    input = gets.chomp
    result = inventory.find { |item| input == item[:name]}
    puts "\e[H\e[2J"
    puts "What is the new quantities of the selected product?"
    input = gets.chomp.to_i
    result[:qty] = input
    puts "\e[H\e[2J"
    puts "#{result[:qty]} units of #{result[:name]}"
    puts "Item successfully edited"
    puts "Press enter to continue"
    gets
    return inventory
end

def addToSales(size, sales_hash)
    sales_hash[size.to_sym] = sales_hash[size.to_sym] + 1
    p sales_hash
    gets
end

def RemoveInventory(array, product)
end


def removeCup(array)
    # Find cups
    result = array.find { |item| "cups" == item[:name] }
    # remove 1 cup
    result[:qty] = result[:qty] - 1
    return array
end

# def removeSugar(array)
#     if order_hash[:sugar] == true
#         # Find cups
#         result = array.find { |item| "sugar" == item[:name] }
#         # remove 1 cup
#         result[:qty] = result[:qty] - 1
#         return array
#     end
# end

# def removeMilk(array)
#     #Find cups
#     result = array.find {|item| "milk" == item[:name] }
#     #remove 1 cup
#     result[:qty] = result[:qty] - 1
#     return array
# end

# def removeBeans(array)
#     #Find cups
#     result = array.find {|item| "beans" == item[:name] }
#     #remove 1 cup
#     result[:qty] = result[:qty] - 1
#     return array
# end




def checkLoyalty(array, loyalty_num)
    array.each do |item|
        if loyalty_num == item[:loyalty_number] and item[:qty] == 5
            puts "\e[H\e[2J"
            puts "Loyalty number found"
            puts "Free Coffee! Congratulations"
            item[:qty] = 0
            puts "Press enter to continue"
            gets
        elsif loyalty_num == item[:loyalty_number] and item[:qty] != 5
            item[:qty] += 1
            puts "\e[H\e[2J"
            puts "Loyalty number found"
            puts "#{5 - item[:qty]} more orders till next free coffee"
            puts "Press enter to continue"
            gets
            
        else 
            next
        end
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


user_exit = false
until user_exit
    puts "\e[H\e[2J"
    puts "-----------------------------------------------------------------"
    puts "1. New Order   2. Inventory  3. Loyalty Program  4. End of day"
    puts "Enter the number of the option you would like"
    puts "-----------------------------------------------------------------"
    action = gets.chomp.downcase 
    if action == "1"
        inventory = coffeeOrder(inventory, loyalty, sales_hash)
    elsif action == "2"
        inventory_exit = false
        puts "\e[H\e[2J"
        puts "--------------------------------------"
        puts "         Options"
        puts "1. Edit Inventory 2. Main Menu"
        puts "--------------------------------------"
        inventory.each do |line|
            puts "You have #{line[:qty]} units of #{line[:name]}"
        end
        
       
        input = gets.chomp
        if input == "1"
            editInventory(inventory)
        end
    elsif action == "3"
        puts "\e[H\e[2J"
        puts "Create or check loyalty number? check/create"
        # response = gets.chomp
        response = gets.chomp
        if response == "check"
            puts "\e[H\e[2J"
            puts "Enter loyalty number"
            response = gets.chomp
            loyalty.each do |line|
                if response == line[:loyalty_number]
                    puts "\e[H\e[2J"
                    puts "Loyalty number found"
                    puts "#{5 - line[:qty]} more orders till next free coffee"
                    puts "Press enter to continue"
                    gets
                    return
                end
            end
        elsif response == "create"
            # puts "Please enter desired loyalty number"
            new_loyalty_number = false
            until new_loyalty_number
                random_num = Random.new()
                random_num = random_num.rand(10000).to_s
                # response = gets.chomp
                # (1..100).find          { |i| i % 5 == 0 && i % 7 == 0 }   #=> 35
                if loyalty.find { |element| element[:loyalty_number] == random_num }
                    puts "Number is taken"
                else
                    loyalty.push({loyalty_number: random_num, qty: 0})
                    puts "\e[H\e[2J"
                    puts "New loyalty number created"
                    puts "Your number is #{random_num}"
                    new_loyalty_number = true
                end
            end
            puts "Press enter to continue"
            gets
        end
    elsif action == "4"
        user_exit = true
    else
        puts "Please enter 1, 2, 3 or 4"
    end
end




# #Find cups in inventory
# result = inventory.find {|item| "cups" == item[:name] }

# #remove 1 cup
# result[:qty] = result[:qty] - 1

# #write inventory array to inventory.csv
# CSV.open('./csv/inventory.csv', "w") do |csv|
#     inventory.each do |item|
#         csv << [item[:name], item[:qty]]
#     end