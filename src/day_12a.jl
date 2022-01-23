
struct Ship
    direction::Char
    x::Int64
    y::Int64
end


function parse_instructions(lines)
    instructions = NamedTuple{(:action, :value), Tuple{Char, Int64}}[]
    for line in lines
        a = line[1]
        v = parse(Int64, line[2:end])
        push!(instructions, (action=a, value=v))
    end
    instructions
end


function direction_to_deg(direction)
    if direction == 'N'
        90
    elseif direction == 'W'
        180
    elseif direction == 'S'
        270
    elseif direction == 'E'
        0
    end
end


function deg_to_direction(degree)
    if degree == 0
        'E'
    elseif degree == 90
        'N'
    elseif degree == 180
        'W'
    elseif degree == 270
        'S'
    end
end


function turn(ship, value)
    deg = direction_to_deg(ship.direction)
    deg = mod(deg + value, 360)
    Ship(deg_to_direction(deg), ship.x, ship.y)
end


function move(ship, instruction)
    if instruction.action == 'N'
        Ship(ship.direction, ship.x, ship.y + instruction.value)
    elseif instruction.action == 'S'
        Ship(ship.direction, ship.x, ship.y - instruction.value)
    elseif instruction.action == 'E'
        Ship(ship.direction, ship.x + instruction.value, ship.y)
    elseif instruction.action == 'W'
        Ship(ship.direction, ship.x - instruction.value, ship.y)
    elseif instruction.action == 'L'
        turn(ship, instruction.value)
    elseif instruction.action == 'R'
        turn(ship, -instruction.value)
    elseif instruction.action == 'F'
        move(ship, (action=ship.direction, value=instruction.value))
    end
end


function navigate(instructions)
    initial = Ship('E', 0, 0)
    ship = foldl(move, instructions; init=initial)
    abs(ship.x - initial.x) + abs(ship.y - initial.y)
end


function main()
    lines = readlines("../resources/input_12.txt")
    instructions = parse_instructions(lines)
    result = navigate(instructions)
    println(result)
end


main()
