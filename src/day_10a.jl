
function find_joltage_differences(adapters)
    pushfirst!(adapters, 0)
    device = maximum(adapters) + 3
    push!(adapters, device)
    sort!(adapters)
    one = 0
    three = 0
    for (x, y) in zip(adapters, adapters[2:end])
        diff = y - x
        if diff == 1
            one += 1
        elseif diff == 3
            three += 1
        end
    end
    one * three
end


function main()
    adapters = map(x -> parse(Int64, x), readlines("../resources/input_10.txt"))
    result = find_joltage_differences(adapters)
    println(result)
end


main()
