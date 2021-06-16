@testset "RainYday.jl" begin
    data_surv = CSO.dataset("cso_raw")
    data_trudeau = CSO.dataset("Montreal-Trudeau_15min_precipitations")
    data = innerjoin(data_surv, data_trudeau, on=:Date)

    notInc = 0
    if data[1, :d24h] == 1
        notInc = 1
    end
    for i in 2:nrow(data) 
        if data[i-1, :d24h] .> 0 && year(data[i,:].Date) .!= year(data[i-1,:].Date)
            notInc = notInc + 1
        end
    end
    
    transformedDF = addColRainYday!(data, "d24h", "RainYday", 5)
    nb1 = sum(transformedDF.RainYday)
    

    #New column contains only 0's and 1'
    @test unique(transformedDF.RainYday) in [0, 1, [0,1]]

    #The number of 1 equals the number of positive precipitations but doesn't include the first day of the year
    @test count(transformedDF[:, :d24h] .> 0.0) == (nb1 + notInc)

    #Ancient DF has been changed
    @test nrow(data) == nrow(transformedDF)   
end