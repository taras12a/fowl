import Foundation
import UIKit

class FowlFortuneBuildingViewModel {
    
    private let FowlFortuneDataStorage = FowlFortuneDataManager.FowlFortuneShared
    private let FowlFortuneTrackerInstance = FowlFortuneAchievementTracker.FowlFortuneShared
    private var FowlFortuneCurrentFarm: FowlFortuneFarm
    private var FowlFortuneCurrentStats: FowlFortuneGameStats
    
    var FowlFortuneBuildingsUpdateCallback: (() -> Void)?
    
    init() {
        FowlFortuneCurrentFarm = FowlFortuneDataStorage.FowlFortuneLoadFarm()
        FowlFortuneCurrentStats = FowlFortuneDataStorage.FowlFortuneLoadGameStats()
    }
    
    func FowlFortuneLoadBuildings() {
        FowlFortuneCurrentFarm = FowlFortuneDataStorage.FowlFortuneLoadFarm()
        FowlFortuneCurrentStats = FowlFortuneDataStorage.FowlFortuneLoadGameStats()
        FowlFortuneBuildingsUpdateCallback?()
    }
    
    func FowlFortuneCanBuyBuilding(_ FowlFortuneBuildingType: FowlFortuneBuildingType) -> Bool {
        return FowlFortuneCurrentFarm.FowlFortuneTotalCredits >= FowlFortuneBuildingType.FowlFortuneBuildingCost
    }
    
    func FowlFortuneBuyBuilding(_ FowlFortuneBuildingType: FowlFortuneBuildingType) -> Bool {
        let FowlFortuneCost = FowlFortuneBuildingType.FowlFortuneBuildingCost
        guard FowlFortuneCurrentFarm.FowlFortuneTotalCredits >= FowlFortuneCost else { return false }
        
        let FowlFortuneNewBuilding = FowlFortuneBuilding(
            FowlFortuneBuildingType: FowlFortuneBuildingType,
            FowlFortuneBuildingPosition: FowlFortuneGenerateRandomPosition()
        )
        
        FowlFortuneCurrentFarm.FowlFortuneBuildings.append(FowlFortuneNewBuilding)
        FowlFortuneCurrentFarm.FowlFortuneTotalCredits -= FowlFortuneCost
        
        FowlFortuneTrackerInstance.FowlFortuneRecordBuildingBuilt(
            FowlFortuneBuildingType: FowlFortuneBuildingType,
            FowlFortuneFarm: &FowlFortuneCurrentFarm,
            FowlFortuneStats: &FowlFortuneCurrentStats
        )
        
        FowlFortuneBuildingsUpdateCallback?()
        return true
    }
    
    func FowlFortuneUpgradeBuilding(_ FowlFortuneBuildingID: String) -> Bool {
        guard let FowlFortuneIndex = FowlFortuneCurrentFarm.FowlFortuneBuildings.firstIndex(where: { $0.FowlFortuneBuildingID == FowlFortuneBuildingID }) else {
            return false
        }
        
        let FowlFortuneUpgradeCost = FowlFortuneCurrentFarm.FowlFortuneBuildings[FowlFortuneIndex].FowlFortuneBuildingLevel * 50
        guard FowlFortuneCurrentFarm.FowlFortuneTotalCredits >= FowlFortuneUpgradeCost else { return false }
        
        FowlFortuneCurrentFarm.FowlFortuneBuildings[FowlFortuneIndex].FowlFortuneBuildingLevel += 1
        
        FowlFortuneCurrentFarm.FowlFortuneTotalCredits -= FowlFortuneUpgradeCost
        
        FowlFortuneTrackerInstance.FowlFortuneRecordBuildingUpgraded(
            FowlFortuneFarm: &FowlFortuneCurrentFarm,
            FowlFortuneStats: &FowlFortuneCurrentStats
        )
        
        FowlFortuneBuildingsUpdateCallback?()
        return true
    }
    
    func FowlFortuneRemoveBuilding(_ FowlFortuneBuildingID: String) -> Bool {
        guard let FowlFortuneIndex = FowlFortuneCurrentFarm.FowlFortuneBuildings.firstIndex(where: { $0.FowlFortuneBuildingID == FowlFortuneBuildingID }) else {
            return false
        }
        
        let FowlFortuneRefundAmount = FowlFortuneCurrentFarm.FowlFortuneBuildings[FowlFortuneIndex].FowlFortuneBuildingLevel * 25
        FowlFortuneCurrentFarm.FowlFortuneTotalCredits += FowlFortuneRefundAmount
        FowlFortuneCurrentFarm.FowlFortuneBuildings.remove(at: FowlFortuneIndex)
        
        FowlFortuneDataStorage.FowlFortuneSaveFarm(FowlFortuneCurrentFarm)
        FowlFortuneBuildingsUpdateCallback?()
        return true
    }
    
    private func FowlFortuneGenerateRandomPosition() -> CGPoint {
        let FowlFortuneX = CGFloat.random(in: 50...300)
        let FowlFortuneY = CGFloat.random(in: 100...400)
        return CGPoint(x: FowlFortuneX, y: FowlFortuneY)
    }
    
    var FowlFortuneBuildings: [FowlFortuneBuilding] {
        return FowlFortuneCurrentFarm.FowlFortuneBuildings
    }
    
    var FowlFortuneTotalCredits: Int {
        return FowlFortuneCurrentFarm.FowlFortuneTotalCredits
    }
    
    var FowlFortuneAvailableBuildingTypes: [FowlFortuneBuildingType] {
        return FowlFortuneBuildingType.allCases
    }
    
    func FowlFortuneGetBuildingCost(_ FowlFortuneBuildingType: FowlFortuneBuildingType) -> Int {
        return FowlFortuneBuildingType.FowlFortuneBuildingCost
    }
    
    func FowlFortuneGetUpgradeCost(for FowlFortuneBuilding: FowlFortuneBuilding) -> Int {
        return FowlFortuneBuilding.FowlFortuneBuildingLevel * 50
    }
    
    func FowlFortuneGetTotalBuildingIncome() -> Int {
        return FowlFortuneCurrentFarm.FowlFortuneBuildings.reduce(0) { total, building in
            total + building.FowlFortuneBuildingPassiveIncome
        }
    }
    
    func FowlFortuneGetBuildingIncomePerMinute() -> Int {
        return FowlFortuneGetTotalBuildingIncome()
    }
    
    func FowlFortuneGetBuildingIncomePerHour() -> Int {
        return FowlFortuneGetTotalBuildingIncome() * 60
    }
}
