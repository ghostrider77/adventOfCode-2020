
function read_instructions(lines)
    instructions = Tuple{AbstractString, Int64}[]
    for line in lines
        op, value = split(line)
        push!(instructions, (op, parse(Int64, value)))
    end
    instructions
end


function find_possibly_corrupted_lines(instructions)
    indices = Int64[]
    for (ix, (op, _)) in enumerate(instructions)
        if op == "jmp" || op == "nop"
            push!(indices, ix)
        end
    end
    indices
end


function execute_correct_program(instructions)
    indices = find_possibly_corrupted_lines(instructions)
    for ix in indices
        modified_instructions = copy(instructions)
        op, k = modified_instructions[ix]
        if op == "jmp"
            modified_instructions[ix] = ("nop", k)
        elseif op == "nop"
            modified_instructions[ix] = ("jmp", k)
        end
        accumulator = run_program(modified_instructions)
        if accumulator !== nothing
            return accumulator
        end
    end
    return nothing
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

        if ix > n
            return accumulator
        end
    end
    nothing
end


function main()
    lines = readlines("../resources/input_08.txt")
    instructions = read_instructions(lines)
    result = execute_correct_program(instructions)
    println(result)
end


main()
