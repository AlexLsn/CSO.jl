using DecisionTree

data_surv = CSO.dataset("cso_raw")
data_trudeau = CSO.dataset("Montreal-Trudeau_15min_precipitations")

#model = DecisionTreeClassifier(max_depth=2)
DTree(model::DecisionTreeClassifier, topredict::String, varnames::Vector{Symbol}, train:    :DataFrame, test::DataFrame, printTree::Bool=false, predictions::Bool=false, RMSD::Bool=true)