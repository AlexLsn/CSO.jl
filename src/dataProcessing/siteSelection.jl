"""
    select_site!(df::DataFrame, Sites::Union{String, Vector{String}}, ColSite::String)

Filters the data to keep only the selected sites.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColSite::String`: The name of the column of `df` containing the sites.
- `Site::Union{String, Vector{String}}`: The names of the selected sites.
"""
function select_site!(df::DataFrame, Sites::Union{String, Vector{String}}, ColSite::String)
    filter!(Symbol(ColSite) => x -> x in Sites, df)
end


"""
    select_site(df::DataFrame, Sites::String, ColSite::Union{String, Vector{String}})

Creates a new dataframe containing only the data for the selected sites.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColSite::String`: The name of the column of `df` containing the sites.
- `Site::Union{String, Vector{String}}`: The names of the selected sites.
"""
function select_site(df::DataFrame, Sites::Union{String, Vector{String}}, ColSite::String)
    filter(Symbol(ColSite) => x -> x in Sites, df)
end