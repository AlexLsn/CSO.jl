#test passed

@testset "dataSelection.jl" begin
    data_surv = CSO.dataset("cso_raw")
    data_trudeau = CSO.dataset("Montreal-Trudeau_15min_precipitations")
    data = innerjoin(data_surv, data_trudeau, on=:Date)

    dropmissing!(data, :Duration)
    addColOverflow!(data, "Duration", "Surverse", 3)

    @testset "pctOnly(df, ColPct)" begin
        newDF = pctOnly(data, "d24h")

        #Only rows where precipitations are positive are kept
        @test sum(newDF.d24h) == sum(data.d24h)

        #Ancient DF has not been changed
        @test nrow(data) != nrow(newDF)
    end


    @testset "pctOnly!(df, ColPct)" begin
        n = sum(data.d24h)
        transformedDF = pctOnly!(data, "d24h")

        #Only rows where precipitations are positive are kept
        @test sum(transformedDF.d24h) == n

        #Ancient DF has been changed
        @test nrow(data) == nrow(transformedDF)
    end


    @testset "overflowOnly(df, ColOverflow)" begin
        data = data
        n = sum(data.Surverse)
        newDF = overflowOnly(data, "Surverse")

        #Only rows where precipitations are positive are kept
        @test sum(newDF.Surverse) == n

        #Ancient DF has not been changed
        @test nrow(data) != nrow(newDF)
    end    
    
    
    @testset "overflowOnly!(df, ColOverflow)" begin
        data = data
        n = sum(data.Surverse)
        transformedDF = overflowOnly!(data, "Surverse")

        #Only rows where precipitations are positive are kept
        @test sum(transformedDF.Surverse) == n

        #Ancient DF has been changed
        @test nrow(data) == nrow(transformedDF)
    end

end