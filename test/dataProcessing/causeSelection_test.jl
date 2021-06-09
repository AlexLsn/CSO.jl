@testset "causeSelection.jl" begin
    
    data = CSO.dataset("cso_raw")
    cause = "P"
    causes = ["P", "U"]
    colCause = "Code"



    @test "causedBy!(df, ColCause, cause)"
        transformedDF = causedBy!(data, colCause, cause)
        selectedCause = transformedDF[:, Symbol(colCause)]
        newCause = unique(map(x -> ismissing(x) ||  x == cause, newDF[:, Symbol("Code")]))


        #Df contains only the selected cause
        @test length(newCause) == 1 && newCause[1] == 1
            
        #Ancient DF has been changed
        @test data == transformedDF
    end



    @test "causedBy!(df, ColCause, causes)"
        transformedDF = causedBy!(data, colCause, causes)
        newCauses = unique(map(x -> ismissing(x) ||  x in causes, newDF[:, Symbol("Code")]))

        #Df contains only the selected causes
        @test length(newCauses) == 1 && newCauses[1] == 1
            
        #Ancient DF has been changed
        @test data != newDF
    end  



    @test "causedBy(df, ColCause, cause)"
        newdDF = causedBy!(data, colCause, cause)
        selectedCause = transformedDF[:, Symbol(colCause)]
        newCause = unique(map(x -> ismissing(x) ||  x == cause, newDF[:, Symbol("Code")]))

        #Df contains only the selected cause
        @test length(newCause) == 1 && newCause[1] == 1
            
        #Ancient DF has been changed
        @test data != newDF
    end


    
    @test "causedBy(df, ColCause, causes)"
        transformedDF = causedBy!(data, colCause, causes)
        newCauses = unique(map(x -> ismissing(x) ||  x in causes, newDF[:, Symbol("Code")]))

        #Df contains only the selected causes
        @test length(newCauses) == 1 && newCauses[1] == 1
            
        #Ancient DF has been changed
        @test data == transformedDF
    end 

end