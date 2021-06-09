@testset "processOverflow.jl" begin
    data = CSO.dataset("cso_raw")
    dropmissing!(data, :Duration)

    @test "addColOverflow!(df, ColDuration, NewCol, ColNum)"
        transformedDF = addColOverflow!(df = data, ColDuration = "Duration", NewCol = "Surverse", ColNum = 3)

        #New column contains only 0's and 1'
        @test unique(transformedDF.Duration) in [0, 1, [0,1]]

        #The number of 1 equals the number of positive durations
        @test count(transformedDF[:, :Duration] .> 0.0) == sum(transformedDF.Surverse)

        #Ancient DF has been changed
        @test data == transformedDF
    end


    @test "countOverflow(df, ColOverflow, Print=true)"
        DF = addColOverflow!(data, "Duration", "Surverse", 3)
        result = countOverflow(df = DF, ColOverflow = "Surverse", Print=true)
        NO = result[1]
        O = result[2]
        perc = result[3]

        #Numbers are well derived
        @test (NO = nrow(DF) - sum(DF.Surverse)) && O = sum(DF.Surverse) && perc = (O/(NO + O))*100

    end

end