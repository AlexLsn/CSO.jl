"""
    deleteAnomalies!(df::DataFrame, ColOverflow::String, ColPct::String)

Deletes rows without precipitation but with overflow.

Data provided must not contain any missing values for overflows' duration or occurrence.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColOverflow::String`: The name of the column of `df` containing the binary vector of overflows.
- `ColPct::String`: The name of the column of `df` that allows to know if it has rained or not during the time division used.
"""
function deleteAnomalies!(df::DataFrame, ColOverflow::String, ColPct::String)
    filter!([Symbol(ColOverflow), Symbol(ColPct)] => (x, y) -> (x == 1 && y > 0) || (x == 0), df)
end