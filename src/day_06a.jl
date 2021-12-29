
function read_groups(lines)
    groups = []
    current_group = []
    for line in lines
        if isempty(line)
            push!(groups, current_group)
            current_group = []
        else
            push!(current_group, line)
        end
    end
    push!(groups, current_group)
    groups
end


function calc_group_sum(groups)
    s = 0
    for group in groups
        s += length(Set(question for person in group for question in person))
    end
    s
end


function main()
    lines = readlines("../resources/input_06.txt")
    groups = read_groups(lines)
    result = calc_group_sum(groups)
    println(result)
end


main()
