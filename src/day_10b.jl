
function find_number_of_assemblies(adapters)
    adapters = Set(adapters)
    push!(adapters, 0)
    device = maximum(adapters) + 3
    push!(adapters, device)

    assemblies = zeros(Int64, device + 1)
    assemblies[1] = 1
    assemblies[2] = 1 in adapters ? 1 : 0
    t = 0
    if 2 in adapters
        t += assemblies[1]
    end
    if 1 in adapters
        t += assemblies[2]
    end
    assemblies[3] = t

    for n in 3:device
        foreach(k -> begin
                        if n - k in adapters
                            assemblies[n + 1] += assemblies[n - k + 1]
                        end
                    end, 1:3)
    end
    assemblies[device + 1]
end


function main()
    adapters = map(x -> parse(Int64, x), readlines("../resources/input_10.txt"))
    result = find_number_of_assemblies(adapters)
    println(result)
end


main()
