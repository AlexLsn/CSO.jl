module CSO

using DataFrames, CSV, Dates, StatsBase, MLBase, GLM, Combinatorics, DecisionTree

include("dataProcessing.jl")
include("dataAnalysis.jl")
include("data.jl")


export

    #Selection of overflows'causes
    causedBy, causedBy!,
    
    #Selection of sites
    selectSite, selectSite!,
    
    #Selection and filtering of specific data
    pctOnly, pctOnly!, 
    overflowOnly, overflowOnly!,

    #delete anomalies
    deleteAnomalies!,

    #Overflow pre-processing
    addColOverflow!, countOverflow,

    #Taking into account the rain of the previous day
    addColRainYday!,

    #test by year
    train_test_year,

    #Prediction of overflows' occurrence
    logreg, 
    CR_logreg, 
    stepF1_logreg,

    #Prediction of overflows' duration
    pred_mean, 
    DTree, 
    linreg, CR_linreg, stepRMSD_linreg
    
end