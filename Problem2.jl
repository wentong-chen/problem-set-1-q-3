#Minhao Yan my497 Wentong Chen wc422
#1. Generate array of random numbers named x
x = rand(Float64, (20000,20000))

#2. Column by Column
exp_column = zeros((20000,20000))
function exp_cols(x)
    for i in 1:20000
        exp_column[:,i] = exp.(x[:,i])
    end
    return exp_column
end

#3. Row by Row
exp_row = zeros((20000,20000))
function exp_rows(x)
    for i in 1:20000
        exp_row[i,:] = exp.(x[i,:])
    end
    return exp_row
end

#4.Calculate time
@time exp_cols(x)
#23.460586 seconds (523.19 k allocations: 5.984 GiB, 4.02% gc time)
@time exp_rows(x)
#320.930191 seconds (273.41 k allocations: 5.970 GiB, 0.56% gc time)

#5. The columnn by column one is much faster.

#6. Exponentiate the full array
@time exp_full = exp.(x)
#55.045882 seconds (314.79 k allocations: 2.996 GiB, 0.01% gc time)
#Overall, the column by column method is the fastest, then the overall one,
#the slowest is the row by row method.
