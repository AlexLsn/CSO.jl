"""
    train_test_year(df::DataFrame, testYears::Union{Int64, Vector{Int64}})

Creates a test dataset containing all chosen years, and a train dataset with the other years.

Column "Date" must be of type Dates.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `testYears::Union{Int64, Vector{Int64}}`: The year (or a vector containing the years) to include in the test dataset.
"""

function train_test_year(df::DataFrame, testYears::Union{Int64, Vector{Int64}})
    test = filter(row -> Dates.year(row.Date) in testYears, df)
    years = unique(Dates.year.(df[:, :Date]))
    trainYears = setdiff(years, testYears)
    train = filter(row -> Dates.year(row.Date) in trainYears, df)
    return train, test
end