# CoffeePOS Documentation - Josh Stephenson T1A3

Github repository : https://github.com/Verbingnoun/CoffeePOS

## Software Development Plan

Develop a statement of purpose and scope for your application. It must include:

- describe at a high level what the application will do
- identify the problem it will solve and explain why you are developing it
- identify the target audience
- explain how a member of the target audience will use it

My app will function as a very basic point of sale(pos) system for a coffee shop. The user, whom will be the person selling the coffee, will be able to create a coffee order with parameters for how the customer would like their coffee, check their current inventory and check on a customers loyalty program. If time allows, I would like to create a sales function as well, where each coffee sold will be recorded by size so at the conclusion of the day the user can see their coffee revenue.

The reason I am developing this app is to provide a zero cost basic solution for POS for a coffee shop. There are many POS systems out there but they can be extremely expensive. My app will be completely free to whomever wants to use it and will be very user friendly.

This app is obviously targetted towards small coffee shop owners as this will be a free and easy way to manage the selling of coffee, tracking inventory and the implimentation of a loyalty program built into the application and potentially sales functionality if time allows.

The entire program will run through terminal with the user interacting through text based prompts. I have designed it to be operated by any user regardless of coding experience. The user simply needs to read on screen and input what they would like to do. For example, enter '1' to create an order from the main menu or enter '2' to access the inventory. The most important function of the app is creating the coffee order and this is done by prompting the user for each parameter for making a coffee ie. Type? Size? Milk? Sugar? At the end of the propmts the entire order will be displayed to screen and if the order is correct, data will be collected and stored from the order and the user will be returned to the main menu for the next function to be executed.



## Develop a list of features that will be included in the application. It must include:

- at least THREE features
- describe each feature

### Feature 1 - Create Coffee Order

 After the user navigates from the main menu to the coffee order menu, the terminal will clear and the user will be prompted for what type of coffee, if they want milk or sugar and the size and finally if they have a loyalty number Once these values are given they are stored in an instance variable(@type, @size, @milk, @sugar, @loyalty). The end of the order the user will be prompted to check the order and if it's correct the @loyalty variable will be checked against a csv file containing loyalty numbers and increment a hash by 1 if it's less than 5 and gives out a free coffee if it's 5. @type variable will check another csv file and tick up an array to track how many of each size of coffee were sold. Input errors are largely handled by if statements in the code but I do have a rescue in place if the size variable is not large/medium/small and gets the user to create the order again.

 ### Feature 2 - Read/Edit inventory

 Same as above, once the user navigates to this menu the terminal will clear and the current inventory is displayed to screen. All inventory items will be displayed as a key/value pair in a hash The user will then be prompted to enter either 1 to add to inventory, 2 to subtract from inventory and 3 toreturn to main menu. Methods are written to take input from user and either add or subtract that number from the hash value. If the user inputs an invalid value for either item or quantity when editing the inventory a rescue condition will prompt the user to try again.

 ### Feature 3 - Check loyalty

 As above, once user navigates to loyalty menu from main menu, terminal will clear and user will be prompted to enter a number, which will be checked against a csv file containing a hash. The hash value will be output to screen to the customer can be informed of their progress to a free coffee. Input errors by the user will result in the loyalty number not being found. Thankfully no special error handling was needed in this feature due to the limited user input.

## Develop a diagram which describes the control flow of your application. Your diagram must:

- show the workflow/logic and/or integration of the features in your application for each feature.
- utilise a recognised format or set of conventions for a control flow diagram, such as UML.

Control Flow Diagram :

<img src="resources/Coffee_shop_controlflow.png"
     alt="Markdown Monster icon">






## Develop an implementation plan which:
- outlines how each feature will be implemented and a checklist of tasks for each feature
- prioritise the implementation of different features, or checklist items within a feature
- provide a deadline, duration or other time indicator for each feature or checklist/checklist-item

Utilise a suitable project management platform to track this implementation plan

> Your checklists for each feature should have at least 5 items.

Link to trello board : https://trello.com/b/8hV9P9gw/coffeepos

## Design help documentation which includes a set of instructions which accurately describe how to use and install the application.

You must include:
- steps to install the application
- any dependencies required by the application to operate
- any system/hardware requirements

