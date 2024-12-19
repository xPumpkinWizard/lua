-- Define a simple function to display story sections and get user choices
function getChoice(prompt, choices)
    print(prompt)
    local input
    while true do
        input = io.read()
        for _, choice in ipairs(choices) do
            if input == choice then
                return input
            end
        end
        print("Invalid choice. Please try again.")
    end
end

-- Start the adventure
print("Welcome to the Tiny Adventure!")

local firstChoice = getChoice(
    "You are in a dark forest. To your left is a small cabin, to your right is a creepy pathway. Do you go to the 'cabin' or follow the 'pathway'?",
    {"cabin", "pathway"}
)

if firstChoice == "cabin" then
    local cabinChoice = getChoice(
        "You approach the cabin and see it's slightly open. Do you 'enter' or 'leave'?",
        {"enter", "leave"}
    )

    if cabinChoice == "enter" then
        print("Inside, you find a treasure chest! Congratulations, you've found the treasure!")
    else
        print("You decide not to risk it and head back. Safe, but maybe next time you'll be braver!")
    end
else
    local pathChoice = getChoice(
        "You follow the creepy pathway and reach a river. Do you 'swim' across or 'return'?",
        {"swim", "return"}
    )

    if pathChoice == "swim" then
        print("You bravely swim across the river and find a bag of gold coins on the other side!")
    else
        print("Scared of what might be in the river, you decide to return. Maybe another adventure awaits another day!")
    end
end

print("Thanks for playing!")
