cd(@__DIR__)

@time using Plots
@time using DifferentialEquations

function lotka_volterra_prey_pradator!(du,u,p,t)
    x, y = u
    a, b, c, d = p
    du[1] = dx = a*x - b*y*x
    du[2] = dy = c*x*y - d*y
end
u0 = [0.9, 0.9]
p = [2/3, 4/3, 1., 1.]
end_time = 20.

tspan = (0.,end_time)
prob = ODEProblem(lotka_volterra_prey_pradator!,u0,tspan,p)
sol0 = solve(prob; saveat=(0.0:0.01:end_time))

time_evolution = plot(sol0, vars=(0,1),
  linestyle = :solid,  color = :red,
  size = (400,300), legend=:bottomright, label = "prey");
plot!(time_evolution, sol0,vars=(0,2),
  linestyle = :solid,  color = :blue,
  size = (400,300), legend=:bottomright, label = "predator")
png(time_evolution, "lotka_volterra_prey_pradator.png")

Δt = 50
end_time = 50.
tspan = (0.,end_time)

senario = 400
J = 0.1:0.1:0.5
sol_ = []
for k in 1:senario
    u0 = [1.0rand()*cos(2π*rand())+1.,0.5rand()*sin(2π*rand())+0.5]
    prob = ODEProblem(lotka_volterra_prey_pradator!,u0,tspan,p)
    push!(sol_, solve(prob; saveat=(0.0:0.01:end_time)))
end

anim = @animate for t = 100:10:4950
    print('|')
    frame = plot();
    for j in 1:5
        u0 = [1.,J[j]]
        prob = ODEProblem(lotka_volterra_prey_pradator!,u0,tspan,p)
        frame = plot!(frame, solve(prob; saveat=(0.0:0.01:9)), vars=(1,2),
                        label = :none, color = colorant"#AAAAAA", linestyle = :solid)
    end
    for k in 1:senario
        frame = plot!(frame, sol_[k][t:(t+Δt)], vars=(1,2),
                    label = :none, color = :black, linealpha = (1:(1+Δt))/Δt)
    end
    frame = plot!(frame,
            size = (450,300), xlims = (0,3), ylims = (0,2), aspect_ratio=:equal,
            xlab = "prey", ylab = "predator")
end
gif(anim, "lotka_volterra_preypredator.gif")
