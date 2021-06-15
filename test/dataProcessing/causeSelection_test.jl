#test passed

@testset "causeSelection.jl" begin
    data = CSO.dataset("cso_raw")
    causes = ["P", "U"]
    colCause = "Code"


    @testset "causedBy!(df, ColCause, causes)" begin
        data = CSO.dataset("cso_raw")
        transformedDF = causedBy!(data, colCause, causes)
        newCauses = unique(map(x -> ismissing(x) ||  x in causes, transformedDF[:, Symbol("Code")]))

        #Df contains only the selected causes
        @test length(newCauses) == length(causes)
            
        #Ancient DF has been changed
        @test nrow(data) == nrow(transformedDF)
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