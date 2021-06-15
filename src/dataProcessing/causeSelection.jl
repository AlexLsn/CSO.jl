"""
    causedBy!(df::DataFrame, ColCause::String, causes::Union{String, Vector{String}})

Filters the data by keeping only those corresponding to the selected causes of overflows, includes missing.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColCause::String`: The name of the column of `df` containing the cause of overflows.
- `causes::Union{String, Vector{String}}`: The names of the causes of overflows to be kept in `df`.
"""
function causedBy!(df::DataFrame, ColCause::String, causes::Union{String, Vector{String}})
    filter!(Symbol(ColCause) => x -> ismissing(x) || (x in causes), df)
end



"""
    causedBy(df::DataFrame, ColCause::String, causes::Union{String, Vector{String}})

Creates a new dataframe with only data corresponding to the selected causes of overflows, includes missing.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColCause::String`: The name of the column of `df` containing the cause of overflows.
- `causes::Union{String, Vector{String}}`: The names of the causes of overflows to be kept in the new dataframe.
"""
function causedBy(df::DataFrame, ColCause::String, causes::Union{String, Vector{String}})
    filter(Symbol(ColCause) => x ->  ismissing(x) || (x in causes), df)
end
