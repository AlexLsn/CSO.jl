"""
    DTree(model::DecisionTreeClassifier, topredict::String, varnames::Vector{Symbol}, train::DataFrame, test::DataFrame, printTree::Bool=false, predictions::Bool=false, RMSD::Bool=true)

Returns the tree, the predictions or the RMSD derived from the model in argument.

# Arguments

- `model::DecisionTreeClassifier`: The decision tree model to be used.
- `topredict::String`: The name of the column of the dataframe of interest that is to be predicted.
- `varnames::Vector{Symbol}`: The explanatory variables to include in the comprehensive research.
- `train::DataFrame`: The dataset used to train the model.
- `test::DataFrame`: The dataset used to test the model.
- `printTree::Bool=false`: Whether to return the tree or not. Default = false.
- `predictions::Bool=false`: Whether to return the predictions vector or not. Default = false.
- `RMSD::Bool=true`: Whether to return the RMSD or not. Default = true.
"""


function DTree(model::DecisionTreeClassifier, topredict::String, varnames::Vector{Symbol}, train::DataFrame, test::DataFrame, printTree::Bool=false, predictions::Bool=false, RMSD::Bool=true)
    Xtrain = Matrix(train[:,varnames])
    ytrain = train[:, Symbol(topredict)]
    Xtest = Matrix(test[:,varnames])

    tree = DecisionTree.fit!(model, Xtrain, ytrain)

    predictions_DT = DecisionTree.predict(tree, Xtest)
    
    if RMSD
        return rmsd(predictions_DT, test[:, Symbol(topredict)])
    end
    
    if predictions
        return predictions_DT
    end
    
    if printTree
        ptree = prune_tree(tree.root, .8)
        SEUIL_CAT1=0.9; SEUIL_CAT3=0.8
        return pretty_tree(ptree, SEUIL_CAT1, SEUIL_CAT3, varnames)
    end
end
