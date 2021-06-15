#test passed

@testset "causeSelection.jl" begin
    data = DataFrame(CSV.File("C:\\Users\\Alexandrine\\cso_raw.csv"))
    cause = "P"
    causes = ["P", "U"]
    colCause = "Code"



    @testset "causedBy!(df, ColCause, cause)" begin
        transformedDF = causedBy!(data, colCause, cause)
        selectedCause = transformedDF[:, Symbol(colCause)]
        newCause = unique(map(x -> ismissing(x) ||  x == cause, transformedDF[:, Symbol("Code")]))


        #Df contains only the selected cause
        @test length(newCause) == 1 && newCause[1] == 1
            
        #Ancient DF has been changed
        @test nrow(data) == nrow(transformedDF)
    end



    @testset "causedBy!(df, ColCause, causes)" begin
        data = DataFrame(CSV.File("C:\\Users\\Alexandrine\\cso_raw.csv"))

        transformedDF = causedBy!(data, colCause, causes)
        newCauses = unique(map(x -> ismissing(x) ||  x in causes, transformedDF[:, Symbol("Code")]))

        #Df contains only the selected causes
        @test length(newCauses) == 1 && newCauses[1] == 1
            
        #Ancient DF has been changed
        @test nrow(data) == nrow(transformedDF)
    end  



    @testset "causedBy(df, ColCause, cause)" begin
        data = DataFrame(CSV.File("C:\\Users\\Alexandrine\\cso_raw.csv"))
        newDF = causedBy(data, colCause, cause)
        selectedCause = newDF[:, Symbol(colCause)]
        newCause = unique(map(x -> ismissing(x) ||  x == cause, newDF[:, Symbol("Code")]))

        #Df contains only the selected cause
        @test length(newCause) == 1 && newCause[1] == 1
            
        #Ancient DF has been changed
        @test nrow(data) != nrow(newDF)
    end


    
    @testset "causedBy(df, ColCause, causes)" begin
        data = DataFrame(CSV.File("C:\\Users\\Alexandrine\\cso_raw.csv"))
        newDF = causedBy(data, colCause, causes)
        newCauses = unique(map(x -> ismissing(x) ||  x in causes, newDF[:, Symbol("Code")]))

        #Df contains only the selected causes
        @test length(newCauses) == 1 && newCauses[1] == 1
            
        #Ancient DF has been changed
        @test nrow(data) != nrow(newDF)
    end 

end