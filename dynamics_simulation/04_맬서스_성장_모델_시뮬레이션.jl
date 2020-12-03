cd("C:/Users/rmsms/OneDrive/freshrimpsushi/dynamics_simulation") # 움짤을 만든 경로로 변경

@time using Plots
@time using Distributions
@time using Random
@time using LinearAlgebra
@time using DifferentialEquations

#---

function malthusian_growth!(du,u,p,t)
  N = u[1]
  r = p
  du[1] = dN = r*N
end

u0 = [50.0]
p = 2.65

tspan = (0.,1.8)
prob = ODEProblem(malthusian_growth!,u0,tspan,p)
sol = solve(prob; saveat=(0.0:0.1:1.8))

compare = plot(sol,vars=(0,1),
  linestyle = :dash,  color = :black,
  size = (400,300), label = "Theoretical", legend=:topleft)

#---

N0 = 50 # 초기 인구수
b = 0.05 # 번식률
d = 0.02 # 사망률
max_iteration = 180 # 시뮬레이션 기간
gaussian2 = MvNormal([0.0; 0.0], 0.03I) # 2차원 정규분포

Random.seed!(0)
time_evolution = [] # 인구수를 기록하기 위한
let
  coordinate = rand(gaussian2, N0)'
  N = N0

  anim = @animate for t = (0:max_iteration)/100
    row2 = @layout [a{0.6h}; b]
    figure = plot(size = [300,500], layout = row2)

    plot!(figure[1], coordinate[:,1], coordinate[:,2], seriestype = :scatter,
      markercolor = RGB(1.,94/255,0.), markeralpha = 0.4, markerstrokewidth	= 0.1,
      aspect_ratio = 1, title = "t = $t",
      xaxis=true,yaxis=true,axis=nothing, legend = false)
      xlims!(figure[1], -10.,10.)
      ylims!(figure[1], -10.,10.)

    replicated = (rand(N) .< b) # 번식 판정
    new_coordinate = coordinate[replicated,:]
    coordinate = coordinate[rand(N) .> d,:] # 사망 판정
    coordinate = cat(coordinate, new_coordinate, dims = 1);

    N = size(coordinate, 1)
    push!(time_evolution, N)
    coordinate = coordinate + rand(gaussian2, N)'

    if t < 0.9
      plot!(figure[2], sol,vars=(0,1),
        linestyle = :dash,  color = :black,
        label = "Theoretical", legend=:bottomright)
    else
      plot!(figure[2], sol,vars=(0,1),
        linestyle = :dash,  color = :black,
        label = "Theoretical", legend=:topleft)
    end
    plot!(figure[2], 0.0:0.01:t, time_evolution,
      color = RGB(1.,94/255,0.), linewidth = 2, label = "Simulation",
      yscale = :log10, yticks = 10 .^(1:4))
    ylims!(figure[2], 0.,min(time_evolution[end]*2,10000.))
  end
  gif(anim, "malthusian_growth_integration1.gif", fps = 18)
end

#---

function malthusian_growth!(du,u,p,t)
  N = u[1]
  r = p
  du[1] = dN = r*N
end

u0 = [50.0]
p = -1

tspan = (0.,1.8)
prob = ODEProblem(malthusian_growth!,u0,tspan,p)
sol = solve(prob; saveat=(0.0:0.1:1.8))

compare = plot(sol,vars=(0,1),
  linestyle = :dash,  color = :black,
  size = (400,300), label = "Theoretical", legend=:topleft)


#---

N0 = 50 # 초기 인구수
b = 0.04 # 번식률
d = 0.05 # 사망률
max_iteration = 180 # 시뮬레이션 기간
gaussian2 = MvNormal([0.0; 0.0], 0.03I) # 2차원 정규분포

Random.seed!(0)
time_evolution = [] # 인구수를 기록하기 위한
let
  coordinate = rand(gaussian2, N0)'
  N = N0

  anim = @animate for t = (0:max_iteration)/100
    row2 = @layout [a{0.6h}; b]
    figure = plot(size = [300,500], layout = row2)

    plot!(figure[1], coordinate[:,1], coordinate[:,2], seriestype = :scatter,
      markercolor = RGB(1.,94/255,0.), markeralpha = 0.4, markerstrokewidth	= 0.1,
      aspect_ratio = 1, title = "t = $t",
      xaxis=true,yaxis=true,axis=nothing, legend = false)
      xlims!(figure[1], -10.,10.)
      ylims!(figure[1], -10.,10.)

    replicated = (rand(N) .< b) # 번식 판정
    new_coordinate = coordinate[replicated,:]
    coordinate = coordinate[rand(N) .> d,:] # 사망 판정
    coordinate = cat(coordinate, new_coordinate, dims = 1);

    N = size(coordinate, 1)
    push!(time_evolution, N)
    coordinate = coordinate + rand(gaussian2, N)'


    plot!(figure[2], sol,vars=(0,1),
      linestyle = :dash,  color = :black,
      label = "Theoretical", legend=:topright)
    plot!(figure[2], 0.0:0.01:t, time_evolution,
      color = RGB(1.,94/255,0.), linewidth = 2, label = "Simulation",
      yscale = :log10, yticks = 10 .^(1:4))
    ylims!(figure[2], 0., 50.)
  end
  gif(anim, "malthusian_growth_integration2.gif", fps = 18)
end


#---

function malthusian_growth!(du,u,p,t)
  N = u[1]
  r = p
  du[1] = dN = r*N
end

u0 = [50.0]
p = 0

tspan = (0.,3.)
prob = ODEProblem(malthusian_growth!,u0,tspan,p)
sol = solve(prob; saveat=(0.0:0.1:3.0))

compare = plot(sol,vars=(0,1),
  linestyle = :dash,  color = :black,
  size = (400,300), label = "Theoretical", legend=:topleft)


#---

N0 = 50 # 초기 인구수
b = 0.05 # 번식률
d = 0.05 # 사망률
max_iteration = 300 # 시뮬레이션 기간
gaussian2 = MvNormal([0.0; 0.0], 0.03I) # 2차원 정규분포

Random.seed!(0)
time_evolution = [] # 인구수를 기록하기 위한
let
  coordinate = rand(gaussian2, N0)'
  N = N0

  anim = @animate for t = (0:max_iteration)/100
    row2 = @layout [a{0.6h}; b]
    figure = plot(size = [300,500], layout = row2)

    plot!(figure[1], coordinate[:,1], coordinate[:,2], seriestype = :scatter,
      markercolor = RGB(1.,94/255,0.), markeralpha = 0.4, markerstrokewidth	= 0.1,
      aspect_ratio = 1, title = "t = $t",
      xaxis=true,yaxis=true,axis=nothing, legend = false)
      xlims!(figure[1], -10.,10.)
      ylims!(figure[1], -10.,10.)

    replicated = (rand(N) .< b) # 번식 판정
    new_coordinate = coordinate[replicated,:]
    coordinate = coordinate[rand(N) .> d,:] # 사망 판정
    coordinate = cat(coordinate, new_coordinate, dims = 1);

    N = size(coordinate, 1)
    push!(time_evolution, N)
    coordinate = coordinate + rand(gaussian2, N)'


    plot!(figure[2], sol,vars=(0,1),
      linestyle = :dash,  color = :black,
      label = "Theoretical", legend=:topleft)
    plot!(figure[2], 0.0:0.01:t, time_evolution,
      color = RGB(1.,94/255,0.), linewidth = 2, label = "Simulation",
      yscale = :log10, yticks = 10 .^(1:4))
    ylims!(figure[2], 0., 100.)
  end
  gif(anim, "malthusian_growth_integration3.gif", fps = 18)
end
