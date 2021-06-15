"""
    pred_mean(topredict::String, train::DataFrame, test::DataFrame)

Derives the RMSD between the test dataset and the mean of the train dataset.

# Arguments

- `topredict::String`: The name of the column of the dataframe of interest that is to be predicted.
- `train::DataFrame`: The dataset used to derive the mean.
- `test::DataFrame`: The dataset used to test the model.
"""

function pred_mean(topredict::String, train::DataFrame, test::DataFrame)
    predictions = Float64[]
    for i in 1:nrow(test)
        push!(predictions, mean(train[:, Symbol(topredict)]))
    end
    RMSD = rmsd(predictions, test[:, Symbol(topredict)])
    return RMSD
end