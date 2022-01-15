
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


function calc_encryption_weakness(numbers, n)
    start = 1
    stop = 1
    s = numbers[1]
    while s != n
        if s < n
            stop += 1
            s += numbers[stop]
        elseif s > n
            s -= numbers[start]
            start += 1
        end
    end

    contiguous_array = numbers[start:stop]
    maximum(contiguous_array) + minimum(contiguous_array)
end


function main()
    numbers = map(x -> parse(Int64, x), readlines("../resources/input_09.txt"))
    k = 25
    n = find_encoding_error(numbers, k)
    result = calc_encryption_weakness(numbers, n)
    println(result)
end


main()
