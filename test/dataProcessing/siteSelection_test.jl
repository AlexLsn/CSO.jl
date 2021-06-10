@testset "siteSelection.jl" begin
    
    data = CSO.dataset("cso_raw")
    site = "4420-01D"
    ColSite = "Site"

    @testset "selectSite(df, Site, ColSite)"
        newDF = selectSite(df = data, Site = site, ColSite = ColSite)
        selectedSite = newDF[:, Symbol(Site)]

        #New Df contains only the selected site
        @test length(unique(selectedSite)) == 1

        #Ancient DF has not been changed
        @test data != newDF
    end

    @testset "selectSite!(df, Site, ColSite)"
        transformedDF = selectSite!(df = data, Site = site, ColSite = ColSite)
        selectedSite = transformedDF[:, Symbol(Site)]

        #Df contains only the selected site
        @test length(unique(selectedSite)) == 1
            
        #Ancient DF has been changed
        @test data == transformedDF
    end
    
end