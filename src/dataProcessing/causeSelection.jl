"""
    causedBy!(...)

Filters the data by keeping only those corresponding to the selected causes of overflows, includes missing.
"""
function causedBy! end


"""
    causedBy!(df::DataFrame, ColCause::String, causes::Vector{String})

Filters the data by keeping only those corresponding to the selected causes of overflows, includes missing.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColCause::String`: The name of the column of `df` containing the cause of overflows.
- `causes::Vector{String}`: The names of the causes of overflows to be kept in `df`.
"""
function causedBy!(df::DataFrame, ColCause::String, causes::Vector{String})
    todelete = []
    for j in 1:nrow(df)
        i=1
        while i <= length(causes)
            if ismissing(df[j, Symbol(ColCause)]) || contains.(causes[i], df[j, Symbol(ColCause)])
                break
            else
                i = i + 1
            end
        end
        if i > length(causes)
            push!(todelete, j)
        end
    end
    deleterows!(df, todelete)
end


"""
    causedBy!(df::DataFrame, ColCause::String, cause::String)

Filters the data by keeping only those corresponding to the selected cause of overflows, includes missing.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColCause::String`: The name of the column of `df` containing the cause of overflows.
- `cause::String`: The names of the cause of overflows to be kept in `df`.
"""
function causedBy!(df::DataFrame, ColCause::String, cause::String)
    filter!(Symbol(ColCause) => x -> ismissing(x) || (x == cause), df)
end




"""
    causedBy!(...)

Creates a new dataframe with only data corresponding to the selected causes of overflows, includes missing.
"""
function causedBy end


"""
    causedBy(df::DataFrame, ColCause::String, causes::Vector{String})

Creates a new dataframe with only data corresponding to the selected causes of overflows, includes missing.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColCause::String`: The name of the column of `df` containing the cause of overflows.
- `causes::Vector{String}`: The names of the causes of overflows to be kept in the new dataframe.
"""
function causedBy(df::DataFrame, ColCause::String, causes::Vector{String})
    todelete = []
    C = copy(df)
    for j in 1:nrow(C)
        i=1
        while i <= length(causes)
            if ismissing(C[j, Symbol(ColCause)]) || contains.(causes[i], C[j, Symbol(ColCause)])
                break
            else
                i = i + 1
            end
        end
        if i > length(causes)
            push!(todelete, j)
        end
    end
    todelete = unique(todelete)
    deleterows!(C, todelete)
end


"""
    causedBy(df::DataFrame, ColCause::String, cause::String)

Creates a new dataframe with only data corresponding to the selected cause of overflows, includes missing.

# Arguments

- `df::DataFrame`: The dataframe containing the data.
- `ColCause::String`: The name of the column of `df` containing the cause of overflows.
- `cause::String`: The names of the causes of overflows to be kept in the new dataframe.
"""
function causedBy(df::DataFrame, ColCause::String, cause::String)
    filter(Symbol(ColCause) => x ->  ismissing(x) || (x == cause), df)
end