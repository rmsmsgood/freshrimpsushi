cd(@__DIR__) # 파일 저장 경로

@time using Plots
@time using Random

colormap_SI = [colorant"#EEEEEE", colorant"#111111"]
row_size = 10
column_size = 10
β = 0.5 # 확산률
Random.seed!(0);

stage_lattice = rand(['S'], row_size, column_size)
stage_lattice[rand(1:row_size), rand(1:column_size)] = 'I'; stage_lattice
figure = heatmap(reverse(stage_lattice,dims=1), color=colormap_SI,
  xaxis=false,yaxis=false,axis=nothing, size = [400,400], legend = false)
png(figure, "06-01.png")

I_lattice = (stage_lattice .== 'I')
count_lattice =
  vcat(I_lattice[2:end, :], zeros(Int64, 1, column_size)) +
  vcat(zeros(Int64, 1, column_size), I_lattice[1:end-1, :]) +
  hcat(I_lattice[:, 2:end], zeros(Int64, row_size, 1)) +
  hcat(zeros(Int64, column_size, 1), I_lattice[:, 1:end-1])
probability_lattice = 1 .- (1-β).^count_lattice
hit_lattice = probability_lattice .> rand(row_size, column_size)
stage_lattice[hit_lattice] .= 'I'; stage_lattice
figure = heatmap(reverse(stage_lattice,dims=1), color=colormap_SI,
  xaxis=false,yaxis=false,axis=nothing, size = [400,400], legend = false)
png(figure, "06-02.png")

let
  Random.seed!(0);

  stage_lattice = rand(['S'], row_size, column_size)
  stage_lattice[rand(1:row_size), rand(1:column_size)] = 'I'; stage_lattice

  anim = @animate for t = 1:9
    figure = heatmap(reverse(stage_lattice,dims=1), color=colormap_SI,
      xaxis=false,yaxis=false,axis=nothing, size = [400,400], legend = false)

    I_lattice = (stage_lattice .== 'I')
    count_lattice =
      vcat(I_lattice[2:end, :], zeros(Int64, 1, column_size)) +
      vcat(zeros(Int64, 1, column_size), I_lattice[1:end-1, :]) +
      hcat(I_lattice[:, 2:end], zeros(Int64, row_size, 1)) +
      hcat(zeros(Int64, column_size, 1), I_lattice[:, 1:end-1])
    probability_lattice = 1 .- (1-β).^count_lattice
    hit_lattice = probability_lattice .> rand(row_size, column_size)
    stage_lattice[hit_lattice] .= 'I'; stage_lattice
    I_lattice = (stage_lattice .== 'I')
    end
  gif(anim, "SI_diffusion.gif", fps = 1)
end
