"""
    pctOnly(df::DataFrame, ColPct::String)

Creates a new dataframe without rows without precipitation.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColPct::String`: The name of the column of `df` that allows to know if it has rained or not during the time division used.
"""
function pctOnly(df::DataFrame, ColPct::String)
    filter(Symbol(ColPct) => x -> x > 0, df)
end

"""
    pctOnly!(df::DataFrame, ColPct::Symbol)

Deletes rows without precipitation.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColPct::String`: The name of the column of `df` that allows to know if it has rained or not during the time division used.
"""
function pctOnly!(df::DataFrame, ColPct::String)
    filter!(Symbol(ColPct) => x -> x > 0, df)
end


"""
    overflowOnly(df::DataFrame, ColOverflow::Strings)

Creates a new dataframe without rows without overflow.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColOverflow::String`: The name of the column of `df` containing the binary vector of overflows.
"""
function overflowOnly(df::DataFrame, ColOverflow::String)
    filter(Symbol(ColOverflow) => x -> x == 1, df)
end

"""
    overflowOnly!(df::DataFrame, ColOverflow::String)

Deletes rows without overflow.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColOverflow::String`: The name of the column of `df` containing the binary vector of overflows.
"""
function overflowOnly!(df::DataFrame, ColOverflow::String)
    filter!(Symbol(ColOverflow) => x -> x == 1, df)
end