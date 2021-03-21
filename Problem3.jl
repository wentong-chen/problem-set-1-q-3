#HW2 Problem 3
#Minhao Yan my497, Wentong Chen wc422

#Firm's Profit Function
function profit(η,c1,c2,q)
    profit1=sum(q)^(-1/η)*q[1]-c1*q[1] # Firm 1's profit
    profit2=sum(q)^(-1/η)*q[2]-c2*q[2] # Firm 2's profit
    profit=[profit1; profit2]
    return profit
end

#Function that solves q_prime
function q_prime(η,c1,c2,q)
    q_prime11=(-1/η)*sum(q)^(-1/η-1)-(1/η)*sum(q)^(-1/η-1)+(1/η^2+1/η)*q[1]*sum(q)^(-1/η-2)-c1
    q_prime12=(-1/η)*sum(q)^(-1/η-1)+(1/η^2+1/η)*sum(q)^(-1/η-2)*q[1]
    q_prime21=(-1/η)*sum(q)^(-1/η-1)+(1/η^2+1/η)*sum(q)^(-1/η-2)*q[2]
    q_prime22=(-1/η)*sum(q)^(-1/η-1)-(1/η)*sum(q)^(-1/η-1)+(1/η^2+1/η)*q[2]*sum(q)^(-1/η-2)-c2
    q_prime_m=[q_prime11 q_prime12; q_prime21 q_prime22]
    return q_prime_m
end

#Newton's method
function cournot_newton(η,c1,c2,initial_guess,tolerance)
    diff=[Inf; Inf]
    q_old=initial_guess
    q=[1e10;1e10]

    while abs.(diff)>tolerance
        q = q_old - transpose(transpose(profit(η,c1,c2,q_old))*inv(q_prime(η,c1,c2,q_old)))
        diff= q- q_old
        q_old= q
    end
 #  Print out final output
 println("The solution is $q.")
end

#   Parameters and Inputs
η=1.6
c1=0.15
c2=0.2
initial_guess=[20;20]
tolerance=[1e-5;1e-5]

#   Optimization
q_opt=cournot_newton(η,c1,c2,initial_guess,tolerance)
