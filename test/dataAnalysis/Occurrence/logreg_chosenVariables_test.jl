#test passed

@testset "logreg_chosenVariables.jl" begin

    data_surv = DataFrame(CSV.File("C:\\Users\\Alexandrine\\cso_raw.csv"))
    data_trudeau = DataFrame(CSV.File("C:\\Users\\Alexandrine\\Montreal-Trudeau_15min_precipitations.csv"))
    data= innerjoin(data_surv, data_trudeau, on=:Date)
    dropmissing!(data, :Duration)
    addColOverflow!(data, "Duration", "Surverse", 3)

    varnames = [:d15min, :d1h]
    topredict = "Surverse"

    train, test = train_test_year(data, 2020)
    
    threshold = collect(0.1:.01:.6)
    model = glm(Term(Symbol(topredict)) ~ sum(Term.(varnames)), train, Bernoulli(), LogitLink())
    predictions = convert(Vector{Float64}, GLM.predict(model, test))
    r = MLBase.roc(test[:, Symbol(topredict)], predictions, threshold)
    F1 = maximum(f1score.(r))

    #The F1score is well derived
    @test F1 == logreg("Surverse", [:d15min, :d1h], train, test)

    #Predictions are well derived
    @test predictions == logreg("Surverse", [:d15min, :d1h], train, test, false)

end

