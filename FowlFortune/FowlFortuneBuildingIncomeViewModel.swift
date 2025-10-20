import Foundation

class FowlFortuneBuildingIncomeViewModel {
    
    private let FowlFortuneDataStorage = FowlFortuneDataManager.FowlFortuneShared
    private var FowlFortuneBuildingIncomeTimer: Timer?
    private var FowlFortuneCurrentFarm: FowlFortuneFarm
    
    var FowlFortuneBuildingIncomeCallback: ((Int) -> Void)?
    var FowlFortuneFarmUpdateCallback: (() -> Void)?
    
    init() {
        FowlFortuneCurrentFarm = FowlFortuneDataStorage.FowlFortuneLoadFarm()
        FowlFortuneStartBuildingIncomeTimer()
    }
    
    deinit {
        FowlFortuneBuildingIncomeTimer?.invalidate()
    }
    
    private func FowlFortuneStartBuildingIncomeTimer() {
        FowlFortuneBuildingIncomeTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            self?.FowlFortuneProcessBuildingIncome()
        }
    }
    
    private func FowlFortuneProcessBuildingIncome() {
        var totalIncome = 0
        let currentTime = Date()
        
        for index in FowlFortuneCurrentFarm.FowlFortuneBuildings.indices {
            let building = FowlFortuneCurrentFarm.FowlFortuneBuildings[index]
            let timeSinceLastIncome = currentTime.timeIntervalSince(building.FowlFortuneBuildingLastIncomeTime)
            
            if timeSinceLastIncome >= building.FowlFortuneBuildingIncomeInterval {
                let income = building.FowlFortuneBuildingPassiveIncome
                totalIncome += income
                
                FowlFortuneCurrentFarm.FowlFortuneBuildings[index].FowlFortuneBuildingLastIncomeTime = currentTime
            }
        }
        
        if totalIncome > 0 {
            FowlFortuneCurrentFarm.FowlFortuneTotalCredits += totalIncome
            FowlFortuneDataStorage.FowlFortuneSaveFarm(FowlFortuneCurrentFarm)
            FowlFortuneBuildingIncomeCallback?(totalIncome)
            FowlFortuneFarmUpdateCallback?()
        }
    }
    
    func FowlFortuneGetTotalBuildingIncome() -> Int {
        return FowlFortuneCurrentFarm.FowlFortuneBuildings.reduce(0) { total, building in
            total + building.FowlFortuneBuildingPassiveIncome
        }
    }
    
    func FowlFortuneGetBuildingIncomePerMinute() -> Int {
        let totalPerMinute = FowlFortuneGetTotalBuildingIncome()
        return totalPerMinute
    }
    
    func FowlFortuneGetBuildingIncomePerHour() -> Int {
        return FowlFortuneGetBuildingIncomePerMinute() * 60
    }
    
    func FowlFortuneRefreshFarm() {
        FowlFortuneCurrentFarm = FowlFortuneDataStorage.FowlFortuneLoadFarm()
    }
}
