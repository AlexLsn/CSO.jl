"""
    logreg(topredict::String, varnames::Vector{Symbol}, train::DataFrame, test::DataFrame, Fscore::Bool=true)

Performs a logistic regression on selected variables.

# Arguments

- `topredict::String`: The name of the column of the dataframe of interest that is to be predicted.
- `varnames::Vector{Symbol}`: The explanatory variables to include in the regression.
- `train::DataFrame`: The dataset used to train the model.
- `test::DataFrame`: The dataset used to test the model.
- `Fscore::Bool=true`: If true, returns the F1 score of the model. If false, returns the vector of predictions. Default = true.

"""
function logreg(topredict::String, varnames::Vector{Symbol}, train::DataFrame, test::DataFrame, Fscore::Bool=true)
    threshold = collect(0.1:.01:.6)
    
    model = glm(Term(Symbol(topredict)) ~ sum(Term.(varnames)), train, Bernoulli(), LogitLink())
    Ŷ = convert(Vector{Float64}, GLM.predict(model, test))
    r = MLBase.roc(test[:, Symbol(topredict)], Ŷ, threshold)
    
    Fscore ? (return maximum(f1score.(r))) : return Ŷ
end