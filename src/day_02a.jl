
struct Policy
    mincount::Int64
    maxcount::Int64
    letter::Char
    password::String
end


function readdata(line)
    interval, letter, passwd = replace(line, ":" => "") |> split
    a, b = map(x -> parse(Int64, x), split(interval, "-"))
    Policy(a, b, only(letter), passwd)
end


function is_valid(record)
    cnt = count(c -> c == record.letter, record.password)
    record.mincount <= cnt <= record.maxcount
end


function main()
    lines = readlines("../resources/input_02.txt")
    records = map(readdata, lines)
    result = foldl((acc, record) -> is_valid(record) ? acc + 1 : acc, records; init=0)
    println(result)
end


main()
