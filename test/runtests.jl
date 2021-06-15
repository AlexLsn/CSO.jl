using CSO
using Test

using DataFrames, CSV, Pipe, Dates, Random, StatsBase, Plots, MLBase, GLM, GLMNet, Combinatorics


@testset "CSO.jl" begin
    include("dataAnalysis_test.jl")
    include("dataProcessing_test.jl")
end
