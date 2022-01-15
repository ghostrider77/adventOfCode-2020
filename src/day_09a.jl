
function calc_pairwise_sums(array)
    sums = Dict{Tuple{Int64, Int64}, Int64}()
    for (ix, x) in enumerate(array)
        for (jy, y) in enumerate(array[ix+1:end])
            sums[(ix, jy + ix)] = x + y
        end
    end
    sums
end


function find_encoding_error(numbers, k)
    preamble = numbers[1:k]
    sums = calc_pairwise_sums(preamble)
    for (ix, elem) in enumerate(numbers[k+1:end])
        if elem ∉ values(sums)
            return elem
        end

        filter!((((i, _), _),) -> i != ix, sums)
        for (jy, y) in enumerate(preamble[2:end])
            sums[(ix + jy, ix + k)] = elem + y
        end

        push!(preamble, elem)
        deleteat!(preamble, 1)
    end
end



function main()
    numbers = map(x -> parse(Int64, x), readlines("../resources/input_09.txt"))
    k = 25
    result = find_encoding_error(numbers, k)
    println(result)
end


main()
