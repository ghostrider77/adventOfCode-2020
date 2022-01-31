
abstract type Instruction end


struct Mask <: Instruction
    mask::AbstractString
end


struct Write <: Instruction
    address::Int64
    value::Int64
end


function read_data(lines)
    program = Instruction[]
    for line in lines
        first, v = split(line, " = ")
        if first == "mask"
            push!(program, Mask(v))
        else
            address = parse(Int64, first[5:end-1])
            value = parse(Int64, v)
            push!(program, Write(address, value))
        end
    end
    program
end


function initialization(program)
    memory = Dict{Int64, Int64}()
    mask = nothing
    for instruction in program
        if isa(instruction, Mask)
            mask = instruction.mask
        else
            s = bitstring(instruction.value)
            masked = join(map(((bit, m),) -> m == 'X' ? bit : m, zip(s[length(s)-35:end], mask)), "")
            masked_value = parse(Int64, masked; base=2)
            memory[instruction.address] = masked_value
        end
    end
    memory
end


function main()
    lines = readlines("../resources/input_14.txt")
    program = read_data(lines)
    memory = initialization(program)
    println(sum(values(memory)))
end


main()
