
function get_first_visible_neighbours(layout, ix, jy)
    on_grid(x, y) = 1 <= x <= nr_rows && 1 <= y <= nr_cols

    nr_rows, nr_cols = size(layout)
    rays = [
        map(x -> layout[x, jy], (ix-1):-1:1),
        map(((x, y),) -> layout[x, y], filter(((x, y),) -> on_grid(x, y), map(dx -> (ix - dx, jy + dx), 1:nr_rows))),
        map(y -> layout[ix, y], (jy+1:nr_cols)),
        map(((x, y),) -> layout[x, y], filter(((x, y),) -> on_grid(x, y), map(dx -> (ix + dx, jy + dx), 1:nr_rows))),
        map(x -> layout[x, jy], (ix+1:nr_rows)),
        map(((x, y),) -> layout[x, y], filter(((x, y),) -> on_grid(x, y), map(dx -> (ix + dx, jy - dx), 1:nr_rows))),
        map(y -> layout[ix, y], (jy-1):-1:1),
        map(((x, y),) -> layout[x, y], filter(((x, y),) -> on_grid(x, y), map(dx -> (ix - dx, jy - dx), 1:nr_rows)))
    ]

    function find(itr)
        for item in itr
            if item == 'L' || item == '#'
                return item
            end
        end
        '.'
    end

    map(find, rays)
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
                neighbours = get_first_visible_neighbours(layout, ix, jy)
                if item == 'L' && all(neighbour != '#' for neighbour in neighbours)
                    updated[ix, jy] = '#'
                    nr_changed += 1
                elseif item == '#' && count(n -> n == '#', neighbours) >= 5
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
