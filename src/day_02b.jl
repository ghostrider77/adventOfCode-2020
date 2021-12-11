
struct Policy
    p1::Int64
    p2::Int64
    letter::Char
    password::String
end


function readdata(line)
    interval, letter, passwd = replace(line, ":" => "") |> split
    a, b = map(x -> parse(Int64, x), split(interval, "-"))
    Policy(a, b, only(letter), passwd)
end


function is_valid(record)
    pwd = record.password
    xor(getindex(pwd, record.p1) == record.letter, getindex(pwd, record.p2) == record.letter)
end


function main()
    lines = readlines("../resources/input_02.txt")
    records = map(readdata, lines)
    result = foldl((acc, record) -> is_valid(record) ? acc + 1 : acc, records; init=0)
    println(result)
end


main()