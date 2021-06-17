using CSO
using Test

using DataFrames, CSV, Dates, StatsBase, Plots, MLBase, GLM, Combinatorics, DecisionTree


@testset "CSO.jl" begin
    include("dataAnalysis_test.jl")
    include("dataProcessing_test.jl")
end
