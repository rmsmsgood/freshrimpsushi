cd(@__DIR__) # 파일 저장 경로

@time using Plots
@time using Random
@time using DifferentialEquations

row_size = 20
column_size = 20
β = 0.1 # 번식률
γ = 0.1 # 사망률

#---
K = row_size*column_size

function logistic_growth!(du,u,p,t)
  N = u[1]
  r = p
  du[1] = dN = r/K*N*(K-N)
end

u0 = [1.0]
p = 0.8

tspan = (0.,18)
prob = ODEProblem(logistic_growth!,u0,tspan,p)
sol = solve(prob; saveat=(0.0:0.1:18))

compare = plot(sol,vars=(0,1),
  linestyle = :dash,  color = :black,
  size = (400,300), label = "Theoretical", legend=:topleft)


#---
max_iteration = 180

Random.seed!(0);
time_evolution = Int64[]

stage_lattice = zeros(Int64, row_size, column_size)
stage_lattice[rand(1:row_size), rand(1:column_size)] = 1

let colormap_SI = cgrad([colorant"#EEEEEE", colorant"#111111"])
  anim1 = @animate for t = (0:max_iteration)/10
    heatmap(reverse(stage_lattice,dims=1), color=colormap_SI,
      xaxis=false,yaxis=false,axis=nothing, size = [400,400], legend = false)

    I_lattice = (stage_lattice .== 1)
    count_lattice =
      vcat(I_lattice[2:end, :], zeros(Int64, 1, column_size)) +
      vcat(zeros(Int64, 1, column_size), I_lattice[1:end-1, :]) +
      hcat(I_lattice[:, 2:end], zeros(Int64, row_size, 1)) +
      hcat(zeros(Int64, column_size, 1), I_lattice[:, 1:end-1])
    probability_lattice = 1 .- (1-β).^count_lattice
    hit_lattice = probability_lattice .> rand(row_size, column_size)
    stage_lattice[hit_lattice] .= 1
    if sum(stage_lattice) ≥ row_size*column_size
      colormap_SI = cgrad([colorant"#111111", colorant"#EEEEEE"])
    end

    push!(time_evolution, sum(stage_lattice))
  end; gif(anim1, "logistic_growth_lattice.gif", fps = 12)
end

anim2 = @animate for t = 1:max_iteration
  compare = plot(sol,vars=(0,1),
    linestyle = :dash,  color = :black,
    label = "Theoretical", legend=:bottomright)
  plot!(compare, 0.1:0.1:(t/10), time_evolution[1:t],
    color = colorant"#111111", linewidth = 2, label = "Simulation",
    size = [400, 300])
end; gif(anim2, "logistic_growth_time_evolution.gif", fps = 12)
