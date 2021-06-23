#test passed

@testset "loreg_research.jl" begin

    data_surv = DataFrame(CSV.File("C:\\Users\\Alexandrine\\cso_raw.csv"))
    data_trudeau = DataFrame(CSV.File("C:\\Users\\Alexandrine\\Montreal-Trudeau_15min_precipitations.csv"))
    data = innerjoin(data_surv, data_trudeau, on=:Date)
    dropmissing!(data, :Duration)
    addColOverflow!(data, "Duration", "Surverse", 3)

    topredict = "Surverse"

    train, test = train_test_year(data, 2020)
    

    result = CR_logreg(topredict, [:d15min, :d45min, :d1h, :d24h], train, test)
    varnames = result[1, :Model]
    F1 = result[1, :F₁]
    variables = stepF1_logreg(topredict, [:d15min, :d45min, :d1h, :d24h], [], train, test, false)


    #The F1 score is well derived
    @test F1 == logreg("Surverse", varnames, train, test)

    #The df is well sorted
    @test F1 == maximum(result.F₁)

    #The higher F1 score of the CR_logreg corresponds to the higher found stepwise
    @test F1 == logreg("Surverse", variables, train, test)

end