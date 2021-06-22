"""
    selectSite!(df::DataFrame, Sites::Vector{String}, ColSite::String)

Filters the data to keep only the selected sites.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColSite::String`: The name of the column of `df` containing the sites.
- `Site::Vector{String}`: The names of the selected sites.
"""
function selectSite!(df::DataFrame, Sites::Vector{String}, ColSite::String)
    filter!(Symbol(ColSite) => x -> x in Sites, df)
end


"""
    selectSite(df::DataFrame, Sites::String, ColSite::Vector{String})

Creates a new dataframe containing only the data for the selected sites.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColSite::String`: The name of the column of `df` containing the sites.
- `Site::Vector{String}`: The names of the selected sites.
"""
function selectSite(df::DataFrame, Sites::Vector{String}, ColSite::String)
    filter(Symbol(ColSite) => x -> x in Sites, df)
end