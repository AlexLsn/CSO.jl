@testset "causeSelection.jl" begin
    
    data = CSO.dataset("cso_raw")
    cause = "P"
    causes = ["P", "U"]
    colCause = "Code"



    @test "causedBy!(df, ColCause, cause)"
        transformedDF = causedBy!(df = data, ColCause = colCause, cause = cause)
        selectedCause = transformedDF[:, Symbol(colCause)]
        newCause = unique(map(x -> ismissing(x) ||  x == cause, newDF[:, Symbol("Code")]))


        #Df contains only the selected cause
        @test length(newCause) == 1 && newCause[1] == 1
            
        #Ancient DF has been changed
        @test data == transformedDF
    end



    @test "causedBy!(df, ColCause, causes)"
        data = data
        transformedDF = causedBy!(df = data, ColCause = colCause, causes = causes)
        newCauses = unique(map(x -> ismissing(x) ||  x in causes, newDF[:, Symbol("Code")]))

        #Df contains only the selected causes
        @test length(newCauses) == 1 && newCauses[1] == 1
            
        #Ancient DF has been changed
        @test data != newDF
    end  



    @test "causedBy(df, ColCause, cause)"
        data = data
        newdDF = causedBy!(df = data, ColCause = colCause, cause = cause)
        selectedCause = transformedDF[:, Symbol(colCause)]
        newCause = unique(map(x -> ismissing(x) ||  x == cause, newDF[:, Symbol("Code")]))

        #Df contains only the selected cause
        @test length(newCause) == 1 && newCause[1] == 1
            
        #Ancient DF has been changed
        @test data != newDF
    end


    
    @test "causedBy(df, ColCause, causes)"
        data = data
        transformedDF = causedBy!(df = data, ColCause = colCause, causes = causes)
        newCauses = unique(map(x -> ismissing(x) ||  x in causes, newDF[:, Symbol("Code")]))

        #Df contains only the selected causes
        @test length(newCauses) == 1 && newCauses[1] == 1
            
        #Ancient DF has been changed
        @test data == transformedDF
    end 

end