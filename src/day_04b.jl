
function readPassports(lines)
    passports = Dict{AbstractString, AbstractString}[]
    item = Dict{AbstractString, AbstractString}()
    for line in lines
        if isempty(line)
            push!(passports, item)
            item = Dict{AbstractString, AbstractString}()
        else
            keys = Dict(map(x -> split(x, ":"), split(line)))
            merge!(item, keys)
        end
    end
    push!(passports, item)
    passports
end


function count_valid_passports(passports)
    function valid_year(str, lower_bound, upper_bound)
        year = tryparse(Int64, str)
        length(str) == 4 && year !==nothing && lower_bound <= year <= upper_bound
    end

    valid_byr(str) = valid_year(str, 1920, 2002)

    valid_iyr(str) = valid_year(str, 2010, 2020)

    valid_eyr(str) = valid_year(str, 2020, 2030)

    valid_pid(str) = length(str) == 9 && tryparse(Int64, str) !== nothing

    valid_ecl(str) = str in Set(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])

    valid_hcl(str) = startswith(str, "#") && tryparse(Int64, str[2:end], base = 16) !== nothing

    function valid_hgt(str)
        if endswith(str, "in")
            n = tryparse(Int64, str[1:end-2])
            n !== nothing && 59 <= n <= 76
        elseif endswith(str, "cm")
            n = tryparse(Int64, str[1:end-2])
            n !== nothing && 150 <= n <= 193
        else
            false
        end
    end

    validators = Dict("byr" => valid_byr, "iyr" => valid_iyr, "eyr" => valid_eyr, "hgt" => valid_hgt,
                      "hcl" => valid_hcl, "ecl" => valid_ecl, "pid" => valid_pid)
    cnt = 0
    for passport in passports
        if keys(validators) ⊆ keys(passport) && all(is_valid(passport[k]) for (k, is_valid) in pairs(validators))
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
