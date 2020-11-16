cd("C:/Users/rmsms/OneDrive/freshrimpsushi/dynamics_simulation") # 움짤을 만든 경로로 변경

@time using Plots
@time using Distributions
@time using Random
@time using LinearAlgebra

N0 = 500 # 초기 인구수
d = 0.04 # 사망률
max_iteration = 180 # 시뮬레이션 기간
gaussian2 = MvNormal([0.0; 0.0], 0.04I) # 2차원 정규분포

Random.seed!(0)
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

    coordinate = coordinate[(rand(N) .> d),:]

    N = size(coordinate, 1)
    push!(time_evolution, N)
    coordinate = coordinate + rand(gaussian2, N)'
  end
  gif(anim, "malthusian_growth_simulation2.gif", fps = 18)
end
