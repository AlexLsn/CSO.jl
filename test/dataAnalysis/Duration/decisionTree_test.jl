@testset "decisionTree.jl" begin

    data_surv = CSO.dataset("cso_raw")
    data_trudeau = CSO.dataset("Montreal-Trudeau_15min_precipitations")
    data = innerjoin(data_surv, data_trudeau, on=:Date)
    dropmissing!(data, :Duration)
    train, test = train_test_year(data, 2020)

    varnames = [:d15min, :d1h, :d6h]
    Xtrain = Matrix(train[:,varnames])
    ytrain = train.Duration
    Xtest = Matrix(test[:,varnames])
    model = DecisionTreeClassifier(max_depth=2)

    tree = DecisionTree.fit!(model, Xtrain, ytrain)
    predictions = DecisionTree.predict(tree, Xtest)

    RMSD = rmsd(predictions, test.Duration)

    #The RMSD is well derived
    @test RMSD ≈ DTree(model, "Duration", varnames, train, test)

    #Predictions are well derived
    @test predictions ≈ DTree(model, "Duration", varnames, train, test, false, true, false)

    #The tree is well built
    @test tree == DTree(model, "Duration", varnames, train, test, true, false, false)

end