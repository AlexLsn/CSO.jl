"""
    addColOverflow!(df::DataFrame, ColDuration::String, NewCol::String, ColNum::Int64)

Adds a column of 0's and 1's indicating the absence or presence of overflow using overflows' duration.

Data provided must not contain any missing values for overflows' duration.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColDuration::String`: The name of the column of `df` containing the duration of overflows.
- `NewCol::String`: The name of the new column of `df` that will contain the 0's and 1's.
- `ColNum::Int64`: The column number of `NewCol`.
"""
function addColOverflow!(df::DataFrame, ColDuration::String, NewCol::String, ColNum::Int64)
    insertcols!(df, ColNum, Symbol(NewCol) => Int.(df[:, Symbol(ColDuration)] .> 0.0))
end

"""
    countOverflow(df::DataFrame, ColOverflow::String, Print::Bool=true)

Returns the number of non-overflows, of overflows, and the percentage of overflows.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColOverflow::String`: The name of the column of `df` containing the binary vector of overflows.
- `Print::Bool=true`: Whether the number of non-overflows, overflows and percentage of overflows are printed or not. Default = true.
"""
function countOverflow(df::DataFrame, ColOverflow::String, Print::Bool=true)
    NO = countmap(df[:, Symbol(ColOverflow)])[0]
    O = countmap(df[:, Symbol(ColOverflow)])[1]
    Per = O/(NO + O)
    
    if Print
        println("The number of non-overflows equals $(NO), the number of overflows equals $O, the percentage of overflows equals around $(round(Per, digits=2)) %.")
    end
    
    return NO, O, Per 
end