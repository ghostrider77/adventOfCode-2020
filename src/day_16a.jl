
convert_to_int_vector(line) = map(x -> parse(Int64, x), split(line, ","))


function read_data(lines)
    function read_interval(s)
        a, b = map(x -> parse(Int64, x), split(s, "-"))
        (a=a, b=b)
    end

    ranges = Dict{String, Set{NamedTuple{(:a, :b), Tuple{Int64, Int64}}}}()
    ix1, ix2 = findall(isempty, lines)
    for line in lines[1:ix1-1]
        label, rest = split(line, ": ")
        intervals = split(rest, " or ")
        ranges[label] = Set(map(read_interval, intervals))
    end

    tickets = Vector{Int64}[]
    for line in lines[ix2+2:end]
        push!(tickets, convert_to_int_vector(line))
    end

    (ranges, tickets)
end


function is_valid(x, ranges)
    item_in_intervals(item, intervals) = any(a <= item <= b for (a, b) in intervals)

    any(item_in_intervals(x, intervals) for intervals in values(ranges))
end


function invalid_nearby_tickets(tickets, ranges)
    invalid_values = Int64[]
    for ticket in tickets
        for x in ticket
            if !is_valid(x, ranges)
                push!(invalid_values, x)
            end
        end
    end
    sum(invalid_values)
end


function main()
    lines = readlines("../resources/input_16.txt")
    ranges, nearby_tickets = read_data(lines)
    result = invalid_nearby_tickets(nearby_tickets, ranges)
    println(result)
end


main()
