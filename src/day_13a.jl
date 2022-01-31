
function read_bus_ids(line)
    buses = Int64[]
    for id in split(line, ",")
        if id != "x"
            push!(buses, parse(Int64, id))
        end
    end
    buses
end


function waiting_time(departure, buses)
    min_wt = typemax(Int64)
    min_bus_id = nothing
    for bus_id in buses
        remainder = departure % bus_id
        if remainder == 0
            return 0
        end
        wt = bus_id - remainder
        if wt < min_wt
            min_wt = wt
            min_bus_id = bus_id
        end
    end
    min_wt * min_bus_id
end


function main()
    lines = readlines("../resources/input_13.txt")
    departure = parse(Int64, lines[1])
    buses = read_bus_ids(lines[2])
    result = waiting_time(departure, buses)
    println(result)
end


main()
