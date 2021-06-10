module CSO

using DataFrames, Pipe, Dates, Random, StatsBase, Plots, MLBase, GLM, GLMNet, Combinatorics

include("dataProcessing.jl")
include("dataAnalysis.jl")


export

    #Selection of overflows'causes
    causeSelection, causeSelection!,
    
    #Selection of sites
    siteSelection, siteSelection!,

    #Selection and filtering of specific data
    pctOnly, pctOnly!, 
    overflowOnly, overflowOnly!,

    #delete anomalies
    #deleteAnomalies!,

    #Overflow pre-processing
    addColOverflow!, countOverflow,

    #test by year
    train_test_year,

    #Prediction of overflows' occurrence
    logreg, 
    CR_logreg, 
    stepF1_logreg

    #Prediction of overflows' duration
    predByMean, 
    decisionTree, 
    linreg, 
    CR_linreg, 
    stepRMSD_linreg


end
