@testset "research_log.jl" begin

    data_surv = CSO.dataset("cso_raw")
    data_trudeau = CSO.dataset("Montreal-Trudeau_15min_precipitations")
    data = innerjoin(data_surv, data_trudeau, on=:Date)
    dropmissing!(data, :Duration)
    addColOverflow!(data, "Duration", "Overflow", 5)
    overflowOnly!(data, "Overflow")

    topredict = "Duration"

    train, test = train_test_year(data, 2020)

    result = CR_gammaReg_log(topredict, [:d15min, :d45min, :d1h, :d6h], train, test)
    varnames = result[1, :Variables]
    RMSD = result[1, :RMSD]
    variables = stepRMSD_gammaReg_log(topredict, [:d45min, :d15min, :d1h, :d6h], [], train, test, false)

    #The RMSD is well derived
    @test RMSD == gammaReg_log("Duration", varnames, train, test)

    #The df is well sorted
    @test RMSD == minimum(result.RMSD)

    #The higher RMSD of the CR_gammaReg_log corresponds to the higher found stepwise
    @test RMSD == gammaReg_log("Duration", variables, train, test)

end