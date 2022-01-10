
function read_instructions(lines)
    instructions = Tuple{AbstractString, Int64}[]
    for line in lines
        op, value = split(line)
        push!(instructions, (op, parse(Int64, value)))
    end
    instructions
end


function run_program(instructions)
    n = length(instructions)
    visited = falses(n)
    ix = 1
    accumulator = 0
    while !visited[ix]
        (op, k) = instructions[ix]
        visited[ix] = true
        if op == "nop"
            ix += 1
        elseif op == "acc"
            accumulator += k
            ix += 1
        elseif op == "jmp"
            ix += k
        end
    end
    accumulator
end


function main()
    lines = readlines("../resources/input_08.txt")
    instructions = read_instructions(lines)
    result = run_program(instructions)
    println(result)
end


main()
