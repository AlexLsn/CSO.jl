#test passed

@testset "siteSelection.jl" begin
    
    data = DataFrame(CSV.File("C:\\Users\\Alexandrine\\cso_raw.csv"))
    ColSite = "Site"
    site = "4420-01D"

    @testset "selectSite(df, Site, ColSite)" begin
        newDF = selectSite(data, site, ColSite)
        selectedSite = newDF[:, Symbol(ColSite)]

        #New Df contains only the selected site
        @test length(unique(selectedSite)) == 1

        #Ancient DF has not been changed
        @test nrow(data) != nrow(newDF)
    end

    @testset "selectSite!(df, Site, ColSite)" begin
        transformedDF = selectSite!(data, site, ColSite)
        selectedSite = transformedDF[:, Symbol(ColSite)]

        #Df contains only the selected site
        @test length(unique(selectedSite)) == 1
            
        #Ancient DF has been changed
        @test nrow(data) == nrow(transformedDF)
    end
    
end