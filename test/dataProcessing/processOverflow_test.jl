#test passed

@testset "processOverflow.jl" begin

    data = DataFrame(CSV.File("C:\\Users\\Alexandrine\\cso_raw.csv"))
    dropmissing!(data, :Duration)

    @testset "addColOverflow!(df, ColDuration, NewCol, ColNum)" begin
        data = DataFrame(CSV.File("C:\\Users\\Alexandrine\\cso_raw.csv"))
        dropmissing!(data, :Duration)
        transformedDF = addColOverflow!(data, "Duration", "Surverse", 3)

        #New column contains only 0's and 1'
        @test unique(transformedDF.Surverse) in [0, 1, [0,1]]

        #The number of 1 equals the number of positive durations
        @test count(transformedDF[:, :Duration] .> 0.0) == sum(transformedDF.Surverse)

        #Ancient DF has been changed
        @test nrow(data) == nrow(transformedDF)
    end


    @testset "countOverflow(df, ColOverflow, Print=true)" begin
        data = DataFrame(CSV.File("C:\\Users\\Alexandrine\\cso_raw.csv"))
        dropmissing!(data, :Duration)
        DF = addColOverflow!(data, "Duration", "Surverse", 3)
        result = countOverflow(DF, "Surverse", false)
        NO = result[1]
        O = result[2]
        perc = result[3]

        #Numbers are well derived
        @test NO == (nrow(DF) - sum(DF.Surverse)) 
        @test O == sum(DF.Surverse) 
        @test perc == (O/(NO + O))

    end

end