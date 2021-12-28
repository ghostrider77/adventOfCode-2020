
function calc_seat_id(pass)
    digits = map(c -> c == 'F' || c == 'L' ? '0' : '1', pass)
    row = parse(Int64, digits[1:7]; base = 2)
    column = parse(Int64, digits[8:end]; base = 2)
    row * 8  + column
end


function seat_ids_on_list(boarding_passes)
    ids = Set{Int64}()
    for pass in boarding_passes
        push!(ids, calc_seat_id(pass))
    end
    ids
end


function find_missing_id(boarding_passes)
    existing_ids = seat_ids_on_list(boarding_passes)
    for row in 1:126, column in 0:7
        seat_id = row * 8 + column
        if seat_id ∉ existing_ids && (seat_id - 1) ∈ existing_ids && (seat_id + 1) ∈ existing_ids
            return seat_id
        end
    end
end


function main()
    lines = readlines("../resources/input_05.txt")
    result = find_missing_id(lines)
    println(result)
end


main()
