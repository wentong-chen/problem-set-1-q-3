#HW2 Problem 4
#Minhao Yan my497, Wentong Chen wc422

#1. Recast the problem as an unconstrained utility maximization problem
#Plug the budget constraint back to the utility function
#u(c1) = (κ*c1^((η-1)/η)+(1-κ)*((w-p1*c1)/p2)^((η-1)/η))^(η/(η-1))

#2. Solve this utility maximization problem
Pkg.add("Optim")
using Optim

function utility_maximizer(κ, η, p1, p2, w, initial_guess, solver)
    u(c1)=-((κ*c1^((η-1)/η)+(1-κ)*((w-p1*c1)/p2)^((η-1)/η)))^(η/(η-1))
    results = optimize(u,initial_guess)
    c1_min=Optim.minimizer(results)[1]
    c2_min= (w-p1*c1_min)/p2
    u_max=-Optim.minimum(results)
    println("c1= $c1_min")
    println("c2= $c2_min")
    println("u_max= $u_max")
    return [c1_min c2_min u_max]
    return results
end

#3.Solve analytically
κ=.5
η=3
w=50
p1=2
p2=3
initial_guess=0.0
Result_ana = utility_maximizer(κ, η, p1, p2, w, initial_guess, Newton())

#Solve numerically
u1(c1)=κ*c1^((η-1)/η)+(1-κ)*((w-p1*c1)/p2)^((η-1)/η)
function g!(storage, x)
    storage[1]=-(η/(η-1))*u1(x[1])^(1/(η-1))*(κ*((η-1)/η)*x[1]^(-1/η)+(1-κ)*((η-1)/η)*((w-p1*x[1])/p2)^(-1/η)*(-p1/p2))
    storage[2] = 0.0
end
function utility_maximizer_num(κ, η, p1, p2, w, initial_guess, solver)
    x=initial_guess
    u(c1)=0.0*x[2]-((κ*c1^((η-1)/η)+(1-κ)*((w-p1*c1)/p2)^((η-1)/η)))^(η/(η-1))
    results = optimize(u, g!, initial_guess)
    c1_min=Optim.minimizer(results)[1]
    c2_min= (w-p1*c1_min)/p2
    u_max=-Optim.minimum(results)
    println("c1= $c1_min")
    println("c2= $c2_min")
    println("u_max= $u_max")
    return [c1_min c2_min u_max]
    return results
end

κ=.5
η=3
w=50
p1=2
p2=3
initial_guess=0.0
Return_num = utility_maximizer_num(κ, η, p1, p2, w, initial_guess, Newton())
