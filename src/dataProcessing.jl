
using DataFrames


"""
    select_site!(df::DataFrame, Site::String, ColSite::String)

Filters the data to keep only the selected site.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColSite::String`: The name of the column of `df` containing the sites.
- `Site::String`: The name of the selected site.
"""
function select_site!(df::DataFrame, Site::String, ColSite::String)
    filter!(Symbol(ColSite) => x -> x == Site, df)
end


"""
    select_site(df::DataFrame, Site::String, ColSite::String)

Creates a new dataframe containing only the data for the selected site.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColSite::String`: The name of the column of `df` containing the sites.
- `Site::String`: The name of the selected site.
"""
function select_site(df::DataFrame, Site::String, ColSite::String)
    filter(Symbol(ColSite) => x -> x == Site, df)
end