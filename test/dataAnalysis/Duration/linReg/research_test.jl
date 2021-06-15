#test passed

@testset "research.jl" begin
    

    data_surv = CSO.dataset("cso_raw")
    data_trudeau = CSO.dataset("Montreal-Trudeau_15min_precipitations")
    data = innerjoin(data_surv, data_trudeau, on=:Date)
    dropmissing!(data, :Duration)

    topredict = "Duration"

    train, test = train_test_year(data, 2020)

    result = CR_linreg(topredict, [:d15min, :d45min, :d1h, :d6h, :d24h], train, test)
    varnames = result[1, :Variables]
    RMSD = result[1, :RMSD]

    #The RMSD is well derived
    @test RMSD == linreg("Duration", varnames, train, test)

    #The df is well sorted
    @test RMSD == minimum(result.RMSD)

    #The best set of variables found stepwise corresponds to the best set of the CR_linreg
    @test countmap(varnames) == countmap(stepRMSD_linreg(topredict, [:d45min, :d15min, :d1h, :d6h, :d24h], [], train, test, false))

end