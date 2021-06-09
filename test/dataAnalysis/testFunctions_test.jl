"""
    train_test_year(...)

Creates a test dataset containing the chosen years, and a train dataset with the other years.
"""
function train_test_year end

"""
    train_test_year(df::DataFrame, testYears::Vector{Int64})

Creates a test dataset containing all chosen years, and a train dataset with the other years.

Column "Date" must be of type Dates.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `testYears::Vector{Int64}`: A vector containing the years to include in the test dataset.
"""
function train_test_year(df::DataFrame, testYears::Vector{Int64})
    test = copy(df)
    todelete = []
    for j in 1:nrow(test)
        i=1
        while i <= length(testYears)
            if Dates.year(test[j, :Date]) .== testYears[i]
                break
            else
                i = i + 1
            end
        end
        if i > length(testYears)
            push!(todelete, j)
        end
    end
    todelete = unique(todelete)

    deleterows!(test, todelete)
    trainids = setdiff(1:nrow(df), eachrow(test))
    train = df[trainids, :]
    return train, test
end


"""
    train_test_year(df::DataFrame, testYears::Int64)

Creates a test dataset containing all chosen years, and a train dataset with the other years.

Column "Date" must be of type Dates.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `testYears::Int64`: The year to include in the test dataset.
"""
function train_test_year(df::DataFrame, testYear::Int64)
    test = copy(df)
    filter!(row -> Dates.year(row.Date).== testYear, test)
    trainids = setdiff(1:nrow(df), eachrow(test))
    train = df[trainids, :]
    return train, test
end