"""
    addColRainYday!(df::DataFrame, ColPct::String, NewCol::String, ColNum::Int64)

Adds a column of 0's and 1's indicating whether it has rained or not the previous day.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColPct::String`: The name of the column of `df` containing the total precipitation of a day.
- `NewCol::String`: The name of the new column of `df` that will contain the 0's and 1's.
- `ColNum::Int64`: The column number of `NewCol`.
- `reducedYear::Bool=true`: If true, the first day of the year is given a 0. Default = true.

# Implementation

This function uses the column indicating the total amount of rain for one day to determine if it has rained or not. 
One must be aware that it uses a daily partitioning. If reducedYear = true, then the first day of the year is not treated 
as the day following the last day of the previous year. For example, if the dataset contains data for May, June and July, the 
1st of May will automatically be given a 0 in the new column.

"""

function addColRainYday!(df::DataFrame, ColPct::String, NewCol::String, ColNum::Int64, reducedYear::Bool=true)
    hier = []
    if reducedYear
        for i in 1:nrow(df)
            if i==1
                push!(hier, 0)
            else
                if df[i-1,Symbol(ColPct)] .> 0 && year(df[i,:].Date) .== year(df[i-1,:].Date)
                    push!(hier, 1)
                else
                    push!(hier, 0)
                end
            end
        end
    else
        for i in 1:nrow(df)
            if i==1
                push!(hier, 0)
            else
                if df[i-1,Symbol(ColPct)] .> 0
                    push!(hier, 1)
                else
                    push!(hier, 0)
                end
            end
        end
    end
    insertcols!(df, ColNum, Symbol(NewCol) => hier)
end