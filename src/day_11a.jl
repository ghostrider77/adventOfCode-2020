
function get_neighbours(layout, ix, jy)
    nr_rows, nr_cols = size(layout)
    neighbours = Char[]
    for dx in -1:1, dy in -1:1
        if dx != 0 || dy != 0
            x = ix + dx
            y = jy + dy
            if 1 <= x <= nr_rows && 1 <= y <= nr_cols
                push!(neighbours, layout[x, y])
            end
        end
    end
    neighbours
end


function single_step(layout)
    updated = Array{Char, 2}(undef, size(layout))
    nr_changed = 0
    for jy in 1:size(layout, 2)
        for ix in 1:size(layout, 1)
            item = layout[ix, jy]
            if item == '.'
                updated[ix, jy] = '.'
            else
                neighbours = get_neighbours(layout, ix, jy)
                if item == 'L' && all(neighbour != '#' for neighbour in neighbours)
                    updated[ix, jy] = '#'
                    nr_changed += 1
                elseif item == '#' && count(n -> n == '#', neighbours) >= 4
                    updated[ix, jy] = 'L'
                    nr_changed += 1
                else
                    updated[ix, jy] = item
                end
            end
        end
    end
    updated, nr_changed
end


function seating_system(seat_layout)
    while true
        seat_layout, nr_changed_seats = single_step(seat_layout)
        if nr_changed_seats == 0
            return count(x -> x == '#', seat_layout)
        end
    end
end


function main()
    lines = readlines("../resources/input_11.txt")
    seat_layout = permutedims(hcat(map(collect, lines)...))
    result = seating_system(seat_layout)
    println(result)
end


main()
