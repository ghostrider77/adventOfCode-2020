
function sledge_down(trees, dx, dy)
    is_tree(i, j) = trees[i, j] == '#'

    x, y = 1, 1
    cnt = 0
    nr_rows, nr_cols = size(trees)
    while x <= nr_rows
        if is_tree(x, y)
            cnt += 1
        end
        x += dx
        y = ((y + dy - 1) % nr_cols) + 1
    end
    cnt
end


function tree_product(trees)
    slopes = [(1, 1), (1, 3), (1, 5), (1, 7), (2, 1)]
    prod(map(((dx, dy),) -> sledge_down(trees, dx, dy), slopes))
end


function main()
    lines = readlines("../resources/input_03.txt")
    trees = permutedims(hcat(map(collect, lines)...))
    result = tree_product(trees)
    println(result)
end


main()
