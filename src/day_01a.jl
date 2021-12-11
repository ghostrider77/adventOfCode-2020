
function calc_solution(xs)
    s = Set{Int64}()
    for x in xs
        if x in s
            return x * (2020 - x)
        end
        push!(s, -x + 2020)
    end
end


function main()
    lines = readlines("../resources/input_01.txt")
    xs = map(line -> parse(Int, line), lines)
    result = calc_solution(xs)
    println(result)
end


main()
