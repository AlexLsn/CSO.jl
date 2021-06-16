"""
    deleteAnomalies!(df::DataFrame, ColOverflow::String, ColPct::String, threshold::Float64)

Deletes rows with precipitations under a certain threshold but with overflow.

Data provided must not contain any missing values for overflows' duration or occurrence.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColOverflow::String`: The name of the column of `df` containing the binary vector of overflows.
- `ColPct::String`: The name of the column of `df` that allows to know if it has rained or not during the time division used.
- `threshold::Float64`: The precipitation threshold under which an anomalie is considered.
"""
function deleteAnomalies!(df::DataFrame, ColOverflow::String, ColPct::String, threshold::Float64)
    filter!([Symbol(ColOverflow), Symbol(ColPct)] => (x, y) -> (x == 1 && y > threshold) || (x == 0), df)
end