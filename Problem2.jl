x = rand(Float64, (2,2))
exp_column = zeros((2,2))
function exp_cols(x)
    i=1
    while i<=20000
        cols = exp.(x[:,i])
        exp_column[:,i] = cols
        i = i+1
    end
end
