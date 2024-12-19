-- Function to count word frequencies in a text file
function countWordFrequencies(filename)
    local counter = {}
    local file = io.open(filename, "r") -- open file for reading
    
    if not file then
        print("Failed to open the file.")
        return nil
    end

    -- Read each line of the file
    for line in file:lines() do
        -- Process each word in the line
        for word in line:gmatch("%w+") do
            word = word:lower() -- convert to lowercase to normalize
            if counter[word] then
                counter[word] = counter[word] + 1
            else
                counter[word] = 1
            end
        end
    end

    file:close()
    return counter
end

-- Function to sort and display the word frequencies
function displaySortedFrequencies(frequencies)
    local sortedWords = {}
    for word, count in pairs(frequencies) do
        table.insert(sortedWords, {word = word, count = count})
    end
    
    -- Sort words by frequency in descending order
    table.sort(sortedWords, function(a, b) return a.count > b.count end)
    
    print("Word frequencies sorted by count:")
    for _, entry in ipairs(sortedWords) do
        print(entry.word .. ": " .. entry.count)
    end
end

-- Main program
print("Enter the filename:")
local filename = io.read()
local frequencies = countWordFrequencies(filename)
if frequencies then
    displaySortedFrequencies(frequencies)
end
