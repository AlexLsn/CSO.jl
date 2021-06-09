@testset "anomalies.jl" begin
    

    data_surv = CSO.dataset("cso_raw")
    data_trudeau = CSO.dataset("Montreal-Trudeau_15min_precipitations")
    data = join(data_surv, data_trudeau, on=:Date)

    @test "deleteAnomalies!(df, ColOverflow, ColPct)"
        transformedDF = deleteAnomalies!(df = data, ColOverflow = "Surverse", ColPct = "d24h")
        testDF = filter([:Surverse, :d24h] => (x, y) -> (x == 1 && y == 0), transformedDF)

        #There is no day with overflow and without precipitation in the DF
        @test nrow(testDF) == 0

        #Ancient DF has been changed
        @test data == transformedDF
    end
end