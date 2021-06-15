#test passed

@testset "anomalies.jl" begin
    
    data_surv = CSO.dataset("cso_raw")
    data_trudeau = CSO.dataset("Montreal-Trudeau_15min_precipitations")
    data = innerjoin(data_surv, data_trudeau, on=:Date)

    dropmissing!(data, :Duration)
    addColOverflow!(data, "Duration", "Surverse", 3)
    
    transformedDF = deleteAnomalies!(data, "Surverse", "d24h")
    testDF = filter([:Surverse, :d24h] => (x, y) -> (x == 1 && y == 0), transformedDF)

    #There is no day with overflow and without precipitation in the DF
    @test nrow(testDF) == 0

    #Ancient DF has been changed
    @test nrow(data) == nrow(transformedDF)

end