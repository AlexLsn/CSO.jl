"""
    CR_linreg(topredict::String, varnames::Vector{Symbol}, train::DataFrame, test::DataFrame)

Tests and ranks (RMSD) all possible set of variables fitting a linear regression.

# Arguments

- `topredict::String`: The name of the column of the dataframe of interest that is to be predicted.
- `varnames::Vector{Symbol}`: The explanatory variables to include in the comprehensive research.
- `train::DataFrame`: The dataset used to train the model.
- `test::DataFrame`: The dataset used to test the model.
"""
function CR_linreg(topredict::String, varnames::Vector{Symbol}, train::DataFrame, test::DataFrame)
    diagnostic = DataFrame(Variables = Array{Symbol}[], Deviance = Float64[], RMSD = Float64[])
    model_var = collect(combinations(varnames))

    for i in 1:length(model_var)
        vars = model_var[i]
        model = lm(Term(Symbol(topredict)) ~ sum(Term.(vars)), train)
        predictions = convert(Vector{Float64}, GLM.predict(model, test))
        RMSD = rmsd(predictions, test[:, Symbol(topredict)])
        push!(diagnostic, [model_var[i], deviance(model), RMSD])
    end

    sort!(diagnostic, [:RMSD, :Deviance])
end

"""
    stepRMSD_linreg(topredict::String, varnames::Vector{Symbol}, initial_list::Vector{Symbol}, train::DataFrame, test::DataFrame, verbose::Bool=true)

Selects the best set of explanatory variables after performing a forward feature selection with linear regression selecting on the RMSD.


# Arguments

- `topredict::String`: The name of the column of the dataframe of interest that is to be predicted.
- `varnames::Vector{Symbol}`: The explanatory variables to include in the regression.
- `initial_list::T where T<:Vector{Any}`: list of features to start with.
- `train::DataFrame`: The dataset used to train the model.
- `test::DataFrame`: The dataset used to test the model.
- `verbose::Bool=true`: whether to print the sequence of inclusions and exclusions. Default = true.
"""

function stepRMSD_linreg(topredict::String, varnames::Vector{Symbol}, initial_list::T where T<:Vector{Any}, train::DataFrame, test::DataFrame, verbose::Bool=true)
    included = initial_list
    while true
        changed=false
        
        # forward step
        excluded = setdiff(varnames, included)
        new_RMSD = DataFrame(var = [excluded[i] for i in 1:length(excluded)])
        vec_RMSD = [] #Will store the RMSD scores to then add them to the new_RMSD df
        for i=1:length(excluded)
            concat = vcat(included,excluded[i]) #concatenates included and one variable from excluded
            model = lm(Term(Symbol(topredict)) ~ sum(Term.(concat)), train)
            predictions = convert(Vector{Float64},GLM.predict(model, test))
            RMSD = rmsd(predictions, test[:, Symbol(topredict)])
            push!(vec_RMSD, RMSD)
        end
        new_RMSD.RMSD = vec_RMSD

        best_RMSD = minimum(new_RMSD.RMSD)
        
        if included != []
            model = lm(Term(Symbol(topredict)) ~ sum(Term.(included)), train)
            predictions = convert(Vector{Float64},GLM.predict(model, test))
            RMSD = rmsd(predictions, test[:, Symbol(topredict)])
            ex_RMSD = RMSD
        else
            ex_RMSD = 10^10
        end
        if  best_RMSD < ex_RMSD
            best_feature = new_RMSD[new_RMSD.RMSD .== best_RMSD,:var][1] #[1] is to extract a Symbol and not a Vector
            push!(included, best_feature)
            changed=true
            if verbose
                println("Add $(best_feature) with RMSD $(best_RMSD)")
            end
        end
        
        if changed == false
            println("RMSD: $(ex_RMSD)")
            return included
            break
        end
    end
    return included
end