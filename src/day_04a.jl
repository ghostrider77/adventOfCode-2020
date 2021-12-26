
function readPassports(lines)
    passports = Set{AbstractString}[]
    item = Set{AbstractString}()
    for line in lines
        if isempty(line)
            push!(passports, item)
            item = Set{AbstractString}()
        else
            keys = Set(map(x -> split(x, ":")[1], split(line)))
            union!(item, keys)
        end
    end
    push!(passports, item)
    passports
end


function count_valid_passports(passports)
    required_fields = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
    cnt = 0
    for passport in passports
        if required_fields ⊆ passport
            cnt += 1
        end
    end
    cnt
end


function main()
    lines = readlines("../resources/input_04.txt")
    passports = readPassports(lines)
    result = count_valid_passports(passports)
    println(result)
end


main()
