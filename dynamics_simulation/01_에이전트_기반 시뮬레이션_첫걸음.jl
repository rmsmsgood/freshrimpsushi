cd("C:/Users/rmsms/OneDrive/freshrimpsushi/dynamics_simulation") # 결과를 저장할 경로

@time using Plots
@time using Distributions
@time using Random
@time using LinearAlgebra

N0 = 10 # 초기 인구수
gaussian2 = MvNormal([0.0; 0.0], 0.02I) # 2차원 정규분포

Random.seed!(0)
coordinate = rand(gaussian2, N0)'

p = plot(coordinate[:,1], coordinate[:,2], seriestype = :scatter,
  markercolor = RGB(1.,94/255,0.), markeralpha = 0.4, markerstrokewidth	= 0.1,
  aspect_ratio = 1, size = [400,400],
  xaxis=true,yaxis=true,axis=nothing, legend = false)
png(p, "에이전트 기반 모델 첫걸음.png"); p
