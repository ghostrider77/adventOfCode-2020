
convert_to_int_vector(line) = map(x -> parse(Int64, x), split(line, ","))


function play_game(numbers, nr_turns)
    cache = Dict(number => ix for (ix, number) in enumerate(numbers[1:end-1]))
    last_spoken_number = last(numbers)
    ix = length(numbers)
    while ix < nr_turns
        if haskey(cache, last_spoken_number)
            next_number = ix - cache[last_spoken_number]
            cache[last_spoken_number] = ix
            last_spoken_number = next_number
        else
            cache[last_spoken_number] = ix
            last_spoken_number = 0
        end
        ix += 1
    end
    last_spoken_number
end


function main()
    starting_numbers = convert_to_int_vector(readline("../resources/input_15.txt"))
    nr_turns = 30000000
    result = play_game(starting_numbers, nr_turns)
    println(result)
end


main()
