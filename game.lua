-- Define the dungeon map
local dungeon = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 1, 1, 0, 1, 1, 1, 0, 1},
    {1, 0, 1, 0, 0, 0, 1, 0, 0, 1},
    {1, 0, 1, 1, 0, 1, 1, 1, 0, 1},
    {1, 0, 0, 0, 0, 1, 0, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
}

-- Define player attributes
local player = {
    x = 2,
    y = 2,
    level = 1,
    experience = 0,
    health = 100,
    maxHealth = 100,
    attack = 10
}

-- Define enemy attributes
local goblin = {
    name = "Goblin",
    health = 20,
    attack = 5,
    experience = 20,
    x = 0,
    y = 0
}

-- Function to generate random position for goblin
local function generateRandomPosition()
    local x = math.random(2, #dungeon[1] - 1) -- Exclude the first and last column
    local y = math.random(2, #dungeon - 1)    -- Exclude the first and last row
    return x, y
end

-- Set goblin's initial position
goblin.x, goblin.y = generateRandomPosition()

-- Function to handle player attack
local function playerAttack()
    goblin.health = goblin.health - player.attack
    print("Player attacks " .. goblin.name .. "!")
    print(goblin.name .. " health: " .. goblin.health)
    if goblin.health <= 0 then
        print("You defeated the " .. goblin.name .. "!")
        player.experience = player.experience + goblin.experience
        print("You gained " .. goblin.experience .. " experience.")
        if player.experience >= player.level * 100 then
            player.level = player.level + 1
            player.maxHealth = player.maxHealth + 20
            player.attack = player.attack + 5
            player.health = player.maxHealth
            print("Level up! You are now level " .. player.level .. "!")
        end
        return true  -- Goblin defeated
    end
    return false  -- Battle continues
end

-- Function to handle goblin attack
local function goblinAttack()
    player.health = player.health - goblin.attack
    print(goblin.name .. " attacks!")
    print("Player health: " .. player.health)
    if player.health <= 0 then
        print("Game over!")
        return true  -- Player defeated
    end
    return false  -- Battle continues
end

-- Game loop
while true do
    -- Display the dungeon
    for y = 1, #dungeon do
        local row = ""
        for x = 1, #dungeon[y] do
            if x == player.x and y == player.y then
                row = row .. "@"
            elseif x == goblin.x and y == goblin.y and goblin.health > 0 then
                row = row .. "G" -- Display the goblin if it's still alive
            elseif dungeon[y][x] == 1 then
                row = row .. "#"
            else
                row = row .. "."
            end
        end
        print(row)
    end

    -- Enemy encounter
    if goblin.health <= 0 then
        print("You defeated the goblin!")
        print("Congratulations! You win!")
        break
    elseif player.x == goblin.x and player.y == goblin.y then
        print("You encountered a " .. goblin.name .. "!")
        while player.health > 0 and goblin.health > 0 do
            -- Ask player for action
            print("Do you want to (a)ttack or (r)un away?")
            local action = io.read()
            if action == "a" then
                if playerAttack() then
                    break
                end
                if goblinAttack() then
                    break
                end
            elseif action == "r" then
                print("You fled from the " .. goblin.name .. "!")
                break
            else
                print("Invalid input")
            end
        end
        if player.health <= 0 then
            print("Game over!")
            break
        end
    end

    -- Ask for player input
    print("Enter a direction (w/a/s/d) or 'q' to quit:")
    local input = io.read()

    -- Handle player input
    if input == "w" then
        if dungeon[player.y - 1][player.x] == 0 then
            player.y = player.y - 1
        end
    elseif input == "a" then
        if dungeon[player.y][player.x - 1] == 0 then
            player.x = player.x - 1
        end
    elseif input == "s" then
        if dungeon[player.y + 1][player.x] == 0 then
            player.y = player.y + 1
        end
    elseif input == "d" then
        if dungeon[player.y][player.x + 1] == 0 then
            player.x = player.x + 1
        end
    elseif input == "q" then
        print("Exiting the game...")
        break
    else
        print("Invalid input")
    end
end
