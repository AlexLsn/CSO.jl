@testset "chosenVariables_log.jl" begin

    data_surv = CSO.dataset("cso_raw")
    data_trudeau = CSO.dataset("Montreal-Trudeau_15min_precipitations")
    data = innerjoin(data_surv, data_trudeau, on=:Date)
    dropmissing!(data, :Duration)
    addColOverflow!(data, "Duration", "Overflow", 5)
    overflowOnly!(data, "Overflow")
    varnames = [:d15min, :d2h]
    topredict = "Duration"

    train, test = train_test_year(data, 2020)

    model = glm(Term(Symbol(topredict)) ~ sum(Term.(varnames)), train, Gamma(), LogLink())
    predictions = convert(Vector{Float64}, GLM.predict(model, test))

    RMSD = rmsd(predictions, test[:, Symbol(topredict)])

    #The RMSD is well derived
    @test RMSD == gammaReg_log("Duration", [:d15min, :d2h], train, test)

    #Predictions are well derived
    @test predictions == gammaReg_log("Duration", [:d15min, :d2h], train, test, false)

end
