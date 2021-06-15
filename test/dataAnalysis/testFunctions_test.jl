#test passed

@testset "testFunctions.jl" begin

    data = DataFrame(CSV.File("C:\\Users\\Alexandrine\\cso_raw.csv"))
    years = unique(Dates.year.(data.Date))
    train, test = train_test_year(data, [2019, 2020])
    train_years = setdiff!(years, [2019, 2020])

    #The test set contains only the chosen years
    @test unique(Dates.year.(test.Date)) == [2019, 2020]

    #The train set contains only the chosen years
    @test unique(Dates.year.(train.Date)) == train_years
end