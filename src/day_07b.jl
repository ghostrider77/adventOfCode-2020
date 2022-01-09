
function parse_input(lines)
    function parse_bag_content(content)
        if content == "no other bags."
            []
        elseif !occursin(",", content)
            words = split(content)
            child_bag = join(words[2:3], " ")
            amount = parse(Int64, words[1])
            [(child_bag, amount)]
        else
            map(x -> begin
                    words = split(x)
                    amount = parse(Int64, words[1])
                    node = join(words[2:3], " ")
                    (node, amount)
                    end, split(content, ", "))
        end
    end

    mapping = Dict{AbstractString, Set{Tuple{AbstractString, Int64}}}()
    for line in lines
        first_part, second_part = split(line, " contain ")
        parent_bag = join(split(first_part)[1:2], " ")
        children = parse_bag_content(second_part)
        for child in children
            vals = get(mapping, parent_bag, Set{Tuple{AbstractString, Int64}}())
            push!(vals, child)
            mapping[parent_bag] = vals
        end
    end
    mapping
end


function nr_inner_bags(mapping, start_bag)
    children = get(mapping, start_bag, Set())
    foldl((acc, (child, amount)) -> acc + amount + amount * nr_inner_bags(mapping, child), children; init=0)
end


function main()
    lines = readlines("../resources/input_07.txt")
    children = parse_input(lines)
    result = nr_inner_bags(children, "shiny gold")
    println(result)
end


main()
