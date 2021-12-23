
function sledge_down(trees)
    is_tree(i, j) = trees[i, j] == '#'

    x, y = 1, 1
    cnt = 0
    nr_rows, nr_cols = size(trees)
    while x <= nr_rows
        if is_tree(x, y)
            cnt += 1
        end
        x += 1
        y = ((y + 2) % nr_cols) + 1
    end
    cnt
end


function main()
    lines = readlines("../resources/input_03.txt")
    trees = permutedims(hcat(map(collect, lines)...))
    result = sledge_down(trees)
    println(result)
end


main()
