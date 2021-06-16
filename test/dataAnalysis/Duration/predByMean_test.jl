@testset "predByMean.jl" begin

    data = CSO.dataset("cso_raw")
    dropmissing!(data, :Duration)
    train, test = train_test_year(data, 2020)
    topredict = "Duration"

    Mean = mean(train[:, Symbol(topredict)])
    predictions = [Mean for i in 1:nrow(test)]

    RMSD = pred_mean(topredict, train, test)

    #The RMSD is well derived
    @test RMSD == rmsd(predictions, test.Duration)

end
