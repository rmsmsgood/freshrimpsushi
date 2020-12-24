cd(@__DIR__) # 파일 저장 경로

@time using Plots
@time using Random
@time using Distributions
@time using LinearAlgebra

N0 = 10 # 초기 인구수
gaussian2 = MvNormal([0.0; 0.0], 0.02I) # 2차원 정규분포

Random.seed!(0);
coordinate = rand(gaussian2, N0)'

p = plot(coordinate[:,1], coordinate[:,2], seriestype = :scatter,
  markercolor = RGB(1.,94/255,0.), markeralpha = 0.4, markerstrokewidth	= 0.1,
  aspect_ratio = 1, size = [400,400],
  xaxis=true,yaxis=true,axis=nothing, legend = false)
png(p, "agent_tutorial.png"); p
