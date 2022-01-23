
struct Ship
    x::Int64
    y::Int64
    waypoint::NamedTuple{(:rx, :ry), Tuple{Int64, Int64}}
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


function rotate_waypoint(ship, value)
    deg = value < 0 ? value + 360 : value
    if deg == 0
        ship
    elseif deg == 90
        Ship(ship.x, ship.y, (rx=-ship.waypoint.ry, ry=ship.waypoint.rx))
    elseif deg == 180
        Ship(ship.x, ship.y, (rx=-ship.waypoint.rx, ry=-ship.waypoint.ry))
    elseif deg == 270
        Ship(ship.x, ship.y, (rx=ship.waypoint.ry, ry=-ship.waypoint.rx))
    end
end


function move(ship, instruction)
    if instruction.action == 'N'
        Ship(ship.x, ship.y, (rx=ship.waypoint.rx, ry=ship.waypoint.ry + instruction.value))
    elseif instruction.action == 'S'
        Ship(ship.x, ship.y, (rx=ship.waypoint.rx, ry=ship.waypoint.ry - instruction.value))
    elseif instruction.action == 'E'
        Ship(ship.x, ship.y, (rx=ship.waypoint.rx + instruction.value, ry=ship.waypoint.ry))
    elseif instruction.action == 'W'
        Ship(ship.x, ship.y, (rx=ship.waypoint.rx - instruction.value, ry=ship.waypoint.ry))
    elseif instruction.action == 'L'
        rotate_waypoint(ship, instruction.value)
    elseif instruction.action == 'R'
        rotate_waypoint(ship, -instruction.value)
    elseif instruction.action == 'F'
        x = ship.x + instruction.value * ship.waypoint.rx
        y = ship.y + instruction.value * ship.waypoint.ry
        Ship(x, y, (rx=ship.waypoint.rx, ry=ship.waypoint.ry))
    end
end


function navigate(instructions)
    initial = Ship(0, 0, (rx=10, ry=1))
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
