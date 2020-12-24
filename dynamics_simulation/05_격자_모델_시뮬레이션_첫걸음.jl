cd(@__DIR__) # 파일 저장 경로

@time using Plots
@time using Random

colormap_SI = [colorant"#EEEEEE", colorant"#111111"]
row_size = 5
column_size = 5
Random.seed!(3);

stage_lattice = rand(['S'], row_size, row_size)
stage_lattice[rand(1:row_size), rand(1:column_size)] = 'I'; stage_lattice
figure = heatmap(reverse(stage_lattice,dims=1), color=colormap_SI,
  xaxis=false,yaxis=false,axis=nothing, size = [400,400], legend = false)
png(figure, "lattice_tutorial.png"); figure
