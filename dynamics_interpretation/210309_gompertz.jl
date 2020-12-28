cd(@__DIR__) # 파일 저장 경로

@time using Plots
@time using DifferentialEquations

#---
end_time = 30.

function logistic_growth!(du,u,p,t)
  N = u[1]
  r, K = p
  du[1] = dN = r/K*N*(K-N)
end
u0 = [1.0]
p = [0.5, 100.]

tspan = (0.,end_time)
prob = ODEProblem(logistic_growth!,u0,tspan,p)
sol1 = solve(prob; saveat=(0.0:0.1:end_time))


function gompertz_growth!(du,u,p,t)
  N = u[1]
  r, α = p
  du[1] = dN = r*exp(-α*t)*N
end
u0 = [1.0]
p = [1., 0.217]

tspan = (0.,end_time)
prob = ODEProblem(gompertz_growth!,u0,tspan,p)
sol2 = solve(prob; saveat=(0.0:0.1:end_time))


compare = plot(sol1,vars=(0,1),
  linestyle = :dash,  color = :black,
  size = (400,300), label = "logistic", legend=:bottomright)

plot!(compare, sol2,vars=(0,1),
  linestyle = :solid,  color = :red,
  size = (400,300), label = "gompertz", legend=:bottomright)

png(compare, "gompertz.png")