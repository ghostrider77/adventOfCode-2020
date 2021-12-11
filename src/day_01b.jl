
function solve_2sum(xs, target, target_ix)
    negative_target_indices = Dict{Int64, Int64}()
    for (ix, item) in enumerate(xs[target_ix+1:end])
        if haskey(negative_target_indices, item)
            jy = negative_target_indices[item]
            return [jy, ix + target_ix, target_ix]
        end

        push!(negative_target_indices, Pair(target - item, ix + target_ix))
    end
end


function solve_3sum_problem(xs)
    for (ix, item) in enumerate(xs)
        indices = solve_2sum(xs, -item + 2020, ix)
        if indices !== nothing
            return prod(map(k -> xs[k], indices))
        end
    end
end


function main()
    lines = readlines("../resources/input_01.txt")
    xs = map(line -> parse(Int, line), lines)
    result = solve_3sum_problem(xs)
    println(result)
end


main()
