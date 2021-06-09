"""
    CR_logreg(topredict::String, varnames::Vector{Symbol}, train::DataFrame, test::DataFrame)

Tests and ranks (F1 score) all possible set of variables fitting a logistic regression.

# Arguments

- `topredict::String`: The name of the column of the dataframe of interest that is to be predicted.
- `varnames::Vector{Symbol}`: The explanatory variables to include in the comprehensive research.
- `train::DataFrame`: The dataset used to train the model.
- `test::DataFrame`: The dataset used to test the model.
"""
function CR_logreg(topredict::String, varnames::Vector{Symbol}, train::DataFrame, test::DataFrame)
    diagnostic = DataFrame(Model = Array{Symbol}[], Deviance = Float64[], F₁ = Float64[], k = Int64[])
    threshold = collect(0.1:.01:.6)
    model_var = collect(combinations(varnames))

    for i in 1:length(model_var)
        vars = model_var[i]
        model = glm(Term(Symbol(topredict)) ~ sum(Term.(vars)), train, Bernoulli(), LogitLink())
        Ŷ = convert(Vector{Float64}, GLM.predict(model, test))
        r = MLBase.roc(test[:, Symbol(topredict)], Ŷ, threshold)
        push!(diagnostic, [model_var[i], -deviance(model), maximum(f1score.(r)), length(vars)])
    end

    sort!(diagnostic, [:F₁, :Deviance], rev=true)
end



"""
    stepF1_logreg(topredict::String, varnames::Vector{Symbol}, initial_list::Vector{Symbol}, train::DataFrame, test::DataFrame, verbose::Bool=true)

Performs a forward feature selection with logistic regression selecting on the F1 score.

# Arguments

- `topredict::String`: The name of the column of the dataframe of interest that is to be predicted.
- `varnames::Vector{Symbol}`: The explanatory variables to include in the regression.
- `initial_list::T where T<:Vector{Any}`: List of features to start with.
- `train::DataFrame`: The dataset used to train the model.
- `test::DataFrame`: The dataset used to test the model.
- `verbose::Bool=true`: whether to print the sequence of inclusions and exclusions. Default = true.
"""

function stepF1_logreg(topredict::String, varnames::Vector{Symbol}, initial_list::T where T<:Vector{Any}, train::DataFrame, test::DataFrame, verbose::Bool=true)
    included = initial_list
    while true
        changed=false
        
        # forward step
        excluded = setdiff(varnames, included)
        new_F1 = DataFrame(var = [excluded[i] for i in 1:length(excluded)])
        vec_F1 = [] #Will store the F1 scores to then add them to the new_F1 df
        for i=1:length(excluded)
            concat = vcat(included,excluded[i]) #concatenates included and one variable from excluded
            model = glm(Term(Symbol(topredict)) ~ sum(Term.(concat)), train, Bernoulli(), LogitLink())
            predictions = convert(Vector{Float64}, GLM.predict(model, test))
            threshold = collect(0.1:.01:.6)
            r = MLBase.roc(test[:, Symbol(topredict)], predictions, threshold)
            F1 = maximum(f1score.(r))
            push!(vec_F1, F1)
        end
        new_F1.F1score = vec_F1

        best_F1 = maximum(new_F1.F1score)
        
        if included != []
            model = glm(Term(Symbol(topredict)) ~ sum(Term.(included)), train, Bernoulli(), LogitLink())
            predictions = convert(Vector{Float64},GLM.predict(model, test))
            threshold = collect(0.1:.01:.6)
            r = MLBase.roc(test[:, Symbol(topredict)], predictions, threshold)
            ex_F1 = maximum(f1score.(r))
        else
            ex_F1 = 0
        end
        if  best_F1 > ex_F1
            best_feature = new_F1[new_F1.F1score .== best_F1,:var][1] #[1] is to extract a Symbol and not a Vector
            push!(included, best_feature)
            changed=true
            if verbose
                println("Add $(best_feature) with F1 $(best_F1)")
            end
        end
        
        if changed == false
            println("F1 score: $(ex_F1)")
            return included
            break
        end
    end
    return included
end