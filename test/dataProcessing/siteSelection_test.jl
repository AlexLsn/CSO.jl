@testset "siteSelection.jl" begin
    
    data = CSO.dataset("cso_raw")
    site = "4420-01D"
    ColSite = "Site"

    @testset "selectSite(data, site, ColSite)"
        newDF = selectSite(data, site, ColSite)
        selectedSite = newDF[:, Symbol(Site)]

        #New Df contains only the selected site
        @test length(unique(selectedSite)) == 1

        #Ancient DF has not been changed
        @test data != newDF
    end

    @testset "selectSite!(data, site, ColSite)"
        transformedDF = selectSite!(data, site, ColSite)
        selectedSite = transformedDF[:, Symbol(Site)]

        #Df contains only the selected site
        @test length(unique(selectedSite)) == 1
            
        #Ancient DF has been changed
        @test data == transformedDF
    end
    
end