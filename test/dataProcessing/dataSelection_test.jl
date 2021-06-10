@testset "dataSelection.jl" begin
    data_surv = CSO.dataset("cso_raw")
    data_trudeau = CSO.dataset("Montreal-Trudeau_15min_precipitations")
    data = join(data_surv, data_trudeau, on=:Date)


    @test "pctOnly(df, ColPct)"
        newDF = pctOnly(df = data, ColPct = "d24h")

        #Only rows where precipitations are positive are kept
        @test sum(newDF.d24h) == sum(data.d24h)

        #Ancient DF has not been changed
        @test data != newDF
    end


    @test "pctOnly!(df, ColPct)"
        n = sum(data.d24h)
        transformedDF = pctOnly!(df = data, ColPct = "d24h")

        #Only rows where precipitations are positive are kept
        @test sum(transformedDF.d24h) == n

        #Ancient DF has been changed
        @test data == transformedDF
    end


    @test "overflowOnly(df, ColOverflow)"
        data = data
        n = sum(data.Surverse)
        newDF = overflowOnly(df = data, ColOverflow = "Surverse")

        #Only rows where precipitations are positive are kept
        @test sum(newDF.Surverse) == n

        #Ancient DF has not been changed
        @test data != newDF
    end    
    
    
    @test "overflowOnly!(df, ColOverflow)"
        data = data
        n = sum(data.Surverse)
        transformedDF = overflowOnly!(df = data, ColOverflow = "Surverse")

        #Only rows where precipitations are positive are kept
        @test sum(transformedDF.Surverse) == n

        #Ancient DF has been changed
        @test data == transformedDF
    end

end