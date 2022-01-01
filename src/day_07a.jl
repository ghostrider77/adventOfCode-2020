
function parse_input(lines)
    function parse_bag_content(content)
        if content == "no other bags."
            []
        elseif !occursin(",", content)
            child_bag = join(split(content)[2:3], " ")
            [child_bag]
        else
            map(x -> join(split(x)[2:3], " "), split(content, ", "))
        end
    end

    parents = Dict{AbstractString, Set{AbstractString}}()
    for line in lines
        first_part, second_part = split(line, " contain ")
        parent_bag = join(split(first_part)[1:2], " ")
        children = parse_bag_content(second_part)
        for child_bag in children
            vals = get(parents, child_bag, Set{AbstractString}())
            push!(vals, parent_bag)
            parents[child_bag] = vals
        end
    end
    parents
end


function find_possible_outer_bags(parent_bags, start_bag)
    visited_bags = Set{AbstractString}()
    current_bags = Set([start_bag])
    while !isempty(current_bags)
        new_parents = Set{AbstractString}()
        for bag in current_bags
            parents = get(parent_bags, bag, Set())
            for parent in parents
                if parent ∉ visited_bags
                    push!(new_parents, parent)
                end
            end
        end
        current_bags = new_parents
        union!(visited_bags, new_parents)
    end
    visited_bags
end


function main()
    lines = readlines("../resources/input_07.txt")
    parents = parse_input(lines)
    result = find_possible_outer_bags(parents, "shiny gold")
    println(length(result))
end


main()
