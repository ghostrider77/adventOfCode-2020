
function calc_seat_id(pass)
    digits = map(c -> c == 'F' || c == 'L' ? '0' : '1', pass)
    row = parse(Int64, digits[1:7]; base = 2)
    column = parse(Int64, digits[8:end]; base = 2)
    row * 8  + column
end


function calc_highest_id(boarding_passes)
    function update(acc, pass)
        id = calc_seat_id(pass)
        id > acc ? id : acc
    end

    foldl(update, boarding_passes; init = 0)
end


function main()
    lines = readlines("../resources/input_05.txt")
    result = calc_highest_id(lines)
    println(result)
end


main()
