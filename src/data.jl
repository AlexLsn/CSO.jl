"""
    dataset(name::String)::DataFrame

Load the dataset associated with `name`.
"""
function dataset(name::String)::DataFrame

    filename = joinpath(dirname(@__FILE__), "..", "data", string(name, ".csv"))
    if isfile(filename)
        return DataFrame(CSV.File(filename))
    end
    error("There is no dataset with the name '$name'")
end