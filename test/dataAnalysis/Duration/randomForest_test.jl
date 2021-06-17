@testset "randomForest.jl" begin

    data_surv = CSO.dataset("cso_raw")
    data_trudeau = CSO.dataset("Montreal-Trudeau_15min_precipitations")
    data = innerjoin(data_surv, data_trudeau, on=:Date)
    dropmissing!(data, :Duration)
    train, test = train_test_year(data, 2020)

    varnames = [:d15min, :d1h, :d6h]

    model = RandomForestClassifier(n_trees=20, max_depth = 3)

    #The RMSD is well derived
    @test typeof(RForest(model, "Duration", varnames, train, test)) == Float64

    #Predictions are well derived
    @test typeof(RForest(model, "Duration", varnames, train, test, true, false)) == Vector{Float64}

end