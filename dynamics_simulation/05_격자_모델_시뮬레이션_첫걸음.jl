cd("C:/Users/rmsms/OneDrive/freshrimpsushi/dynamics_simulation")

@time using Plots
@time using Random

Random.seed!(3)
row_size = 5
column_size = 5
stage_lattice = rand(['S'], row_size, row_size)
stage_lattice[rand(1:row_size), rand(1:column_size)] = 'I'; stage_lattice
stage_lattice[rand(1:row_size), rand(1:column_size)] = 'I'; stage_lattice
colormap_SI = [colorant"#EEEEEE", colorant"#111111"]
figure = heatmap(reverse(stage_lattice,dims=1), color=colormap_SI,
  xaxis=false,yaxis=false,axis=nothing, size = [400,400], legend = false)
png(figure, "05-1.png")
