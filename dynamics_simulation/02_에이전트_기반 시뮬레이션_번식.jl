cd(@__DIR__) # 파일 저장 경로

@time using Plots
@time using Random
@time using Distributions
@time using LinearAlgebra

N0 = 5 # 초기 인구수
b = 0.05 # 번식률
max_iteration = 180 # 시뮬레이션 기간
gaussian2 = MvNormal([0.0; 0.0], 0.02I) # 2차원 정규분포

Random.seed!(2);
time_evolution = [] # 인구수를 기록하기 위한 스택
let
  coordinate = rand(gaussian2, N0)'
  N = N0

  anim = @animate for t = (0:max_iteration)/100
    plot(coordinate[:,1], coordinate[:,2], seriestype = :scatter,
      markercolor = RGB(1.,94/255,0.), markeralpha = 0.4, markerstrokewidth	= 0.1,
      title = "t = $t", aspect_ratio = 1, size = [400,400],
      xaxis=true,yaxis=true,axis=nothing, legend = false)
      xlims!(-10.,10.)
      ylims!(-10.,10.)

    replicated = (rand(N) .< b)
    new_coordinate = coordinate[replicated,:]
    coordinate = cat(coordinate, new_coordinate, dims = 1)

    N = size(coordinate, 1)
    push!(time_evolution, N)
    coordinate = coordinate + rand(gaussian2, N)'
  end
  gif(anim, "malthusian_growth_simulation.gif", fps = 18)
end
