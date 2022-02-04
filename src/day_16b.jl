
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

    own_ticket = convert_to_int_vector(lines[ix1+2])

    tickets = Vector{Int64}[]
    for line in lines[ix2+2:end]
        push!(tickets, convert_to_int_vector(line))
    end

    (ranges, own_ticket, tickets)
end


item_in_intervals(item, intervals) = any(a <= item <= b for (a, b) in intervals)


is_valid(x, ranges) = any(item_in_intervals(x, intervals) for intervals in values(ranges))


function collect_suitable_labels(ranges, column)
    suitable_labels = []
    for (label, intervals) in pairs(ranges)
        if all(item_in_intervals(x, intervals) for x in column)
            push!(suitable_labels, label)
        end
    end
    suitable_labels
end


function find_unique_assignments(labels)
    result = Array{String}(undef, length(labels))
    ix = findfirst(lst -> length(lst) == 1, labels)
    while ix !== nothing
        label = only(labels[ix])
        result[ix] = label
        labels = [filter(x -> x != label, lst) for lst in labels]
        ix = findfirst(lst -> length(lst) == 1, labels)
    end
    result
end


function departure_product(own_ticket, tickets, ranges)
    is_ticket_valid(ticket) = all(is_valid(x, ranges) for x in ticket)

    valid_tickets = permutedims(hcat(filter(is_ticket_valid, tickets)...))
    label_assignments = Vector{String}[]
    for column in eachcol(valid_tickets)
        labels = collect_suitable_labels(ranges, column)
        push!(label_assignments, labels)
    end

    unique_assignments = find_unique_assignments(label_assignments)
    prod(number for (label, number) in zip(unique_assignments, own_ticket) if startswith(label, "departure"))
end


function main()
    lines = readlines("../resources/input_16.txt")
    ranges, own_ticket, nearby_tickets = read_data(lines)
    result = departure_product(own_ticket, nearby_tickets, ranges)
    println(result)
end


main()
