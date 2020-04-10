using Queryverse, VegaDatasets, IndexedTables,  Clustering,  Plots,  RDatasets

#load cars dataset from VegaDatasets
cars= dataset("cars")
#cars |> Voyager

#@show cars |> @filter(_.Origin=="USA")

#cars |> @filter(_.Origin=="USA") |> FileIO.save("C:/Users/jaqua/Documents/Github Repositories/JuliaDataScienceLearning/IntroToQueryVerse/us_cars.csv")
filename= "C:/Users/jaqua/Documents/Github Repositories/JuliaDataScienceLearning/IntroToQueryVerse/us_cars.csv"
 load("C:/Users/jaqua/Documents/Github Repositories/JuliaDataScienceLearning/IntroToQueryVerse/us_cars.csv") |> @vlplot(:point,x=:Miles_per_Gallon, y=:Weight_in_lbs, color="Cylinders:n" )
f = load(filename)
eu_cars="C:/Users/jaqua/Documents/Github Repositories/JuliaDataScienceLearning/IntroToQueryVerse/eu_cars.csv"
 #@show load(filename) |> DataFrame

 #@show load(filename) |> table |> DataFrame

 #f |> DataFrame |> @vlplot(:point,x=:Horsepower,y=:Acceleration)

#cars |> @filter(_.Origin=="Europe") |>  @tee(FileIO.save(eu_cars))  |> @vlplot(:point,x=:Acceleration,y=:Horsepower) |> FileIO.save("fig1.png")

#@show 1:8 |> @filter(_%2==0) |> @orderby_descending(_) |> collect

myD = Dict(:a=>4,:b=>2,:c=>8)
#@show myD |> @filter(_[2]>3) |> Dict

#@show 1:10 |> @map(_=>_^2) |> Dict

#@show cars |> @orderby(_.Origin) |> @thenby(_.Year) |> @thenby_descending(_.Horsepower)

# @show cars |> @groupby(_.Origin) |> @map(_[3])

#@show cars |> @groupby(_.Origin) |> @map({Origin=_.key,Count=length(_)})
iris = dataset("datasets", "iris")
carsdf = cars |> DataFrame
 features = collect(Matrix(carsdf[:,4:6]))
 features =  collect(Matrix(iris[:, 1:4])')
result = kmeans(features,3)

scatter(carsdf.Displacement, carsdf.Horsepower, marker_z=result.assignments,
        color=:lightrainbow, legend=false)
