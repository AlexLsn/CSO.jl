#test passed

@testset "siteSelection.jl" begin
    
    data = CSO.dataset("cso_raw")
    ColSite = "Site"
    sites = ["4420-01D"]

    @testset "selectSite(df, Site, ColSite)" begin
        newDF = selectSite(data, site, ColSite)
        selectedSite = newDF[:, Symbol(ColSite)]

        #New Df contains only the selected sites
        @test length(unique(selectedSite)) == length(sites)

        #Ancient DF has not been changed
        @test nrow(data) != nrow(newDF)
    end

    @testset "selectSite!(df, Site, ColSite)" begin
        transformedDF = selectSite!(data, site, ColSite)
        selectedSite = transformedDF[:, Symbol(ColSite)]

        #Df contains only the selected site
        @test length(unique(selectedSite)) == length(sites)
            
        #Ancient DF has been changed
        @test nrow(data) == nrow(transformedDF)
    end
    
end