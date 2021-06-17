"""
    RForest(model::RandomForestClassifier, topredict::String, varnames::Vector{Symbol}, train::DataFrame, test::DataFrame, predictions::Bool=false, RMSD::Bool=true)

    Returns the predictions or the RMSD derived from the model in argument.

# Arguments

- `model::DecisionTreeClassifier`: The decision tree model to be used.
- `topredict::String`: The name of the column of the dataframe of interest that is to be predicted.
- `varnames::Vector{Symbol}`: The explanatory variables to include in the comprehensive research.
- `train::DataFrame`: The dataset used to train the model.
- `test::DataFrame`: The dataset used to test the model.
- `predictions::Bool=false`: Whether to return the predictions vector or not. Default = false.
- `RMSD::Bool=true`: Whether to return the RMSD or not. Default = true.
"""

function RForest(model::RandomForestClassifier, topredict::String, varnames::Vector{Symbol}, train::DataFrame, test::DataFrame, predictions::Bool=false, RMSD::Bool=true)
    Xtrain = Matrix(train[:,varnames])
    ytrain = train[:, Symbol(topredict)]
    Xtest = Matrix(test[:,varnames])

    DecisionTree.fit!(model, Xtrain, ytrain)
    predictions_RF = DecisionTree.predict(model, Xtest)

    if RMSD
        return rmsd(predictions_RF, test[:, Symbol(topredict)])
    end
    
    if predictions
        return predictions_RF
    end
end