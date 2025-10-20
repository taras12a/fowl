import Foundation
import UIKit

class FowlFortuneFarmViewModel {

    private let FowlFortuneDataStorage = FowlFortuneDataManager.FowlFortuneShared
    private let FowlFortuneTrackerInstance = FowlFortuneAchievementTracker.FowlFortuneShared
    private let FowlFortuneBuildingIncomeManager = FowlFortuneBuildingIncomeViewModel()
    private var FowlFortuneCurrentFarm: FowlFortuneFarm
    private var FowlFortuneCurrentStats: FowlFortuneGameStats
    private var FowlFortuneGameTimer: Timer?

    var FowlFortuneFarmUpdateCallback: (() -> Void)?
    var FowlFortuneBuildingIncomeCallback: ((Int) -> Void)?

    init() {
        FowlFortuneCurrentFarm = FowlFortuneDataStorage.FowlFortuneLoadFarm()
        FowlFortuneCurrentStats = FowlFortuneDataStorage.FowlFortuneLoadGameStats()
        FowlFortuneInitializeDefaultAchievementsIfNeeded()
        FowlFortuneSetupBuildingIncome()
        FowlFortuneStartGameTimer()
    }

    deinit {
        FowlFortuneGameTimer?.invalidate()
    }
    
    private func FowlFortuneSetupBuildingIncome() {
        FowlFortuneBuildingIncomeManager.FowlFortuneBuildingIncomeCallback = { [weak self] income in
            DispatchQueue.main.async {
                self?.FowlFortuneBuildingIncomeCallback?(income)
            }
        }
        
        FowlFortuneBuildingIncomeManager.FowlFortuneFarmUpdateCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.FowlFortuneFarmUpdateCallback?()
            }
        }
    }
    
    private func FowlFortuneInitializeDefaultAchievementsIfNeeded() {
        if FowlFortuneCurrentFarm.FowlFortuneAchievements.isEmpty {
            FowlFortuneCurrentFarm.FowlFortuneAchievements = FowlFortuneDataStorage.FowlFortuneInitializeDefaultAchievements()
            FowlFortuneSaveFarm()
        }
    }
    
    private func FowlFortuneStartGameTimer() {
        FowlFortuneGameTimer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { [weak self] _ in
            self?.FowlFortuneProcessGameCycle()
        }
    }
    
    private func FowlFortuneProcessGameCycle() {
        FowlFortuneProduceEggs()
        FowlFortuneUpdateChickenStats()
        FowlFortuneCheckAchievements()
        
        FowlFortuneTrackerInstance.FowlFortuneRecordFarmCycle(
            FowlFortuneFarm: &FowlFortuneCurrentFarm,
            FowlFortuneStats: &FowlFortuneCurrentStats
        )
        
        FowlFortuneSaveFarm()
        FowlFortuneFarmUpdateCallback?()
    }
    
    private func FowlFortuneProduceEggs() {
        let FowlFortuneTotalProduction = FowlFortuneCurrentFarm.FowlFortuneChickens.reduce(0) { $0 + $1.FowlFortuneChickenEggProduction * $1.FowlFortuneChickenLevel }
        
        if FowlFortuneTotalProduction > 0 {
            FowlFortuneTrackerInstance.FowlFortuneRecordEggCollection(
                FowlFortuneEggCount: FowlFortuneTotalProduction,
                FowlFortuneFarm: &FowlFortuneCurrentFarm,
                FowlFortuneStats: &FowlFortuneCurrentStats
            )
        }
    }
    
    private func FowlFortuneUpdateChickenStats() {
        for index in FowlFortuneCurrentFarm.FowlFortuneChickens.indices {
            FowlFortuneCurrentFarm.FowlFortuneChickens[index].FowlFortuneChickenHappiness = max(0, FowlFortuneCurrentFarm.FowlFortuneChickens[index].FowlFortuneChickenHappiness - 5)
            FowlFortuneCurrentFarm.FowlFortuneChickens[index].FowlFortuneChickenHealth = max(0, FowlFortuneCurrentFarm.FowlFortuneChickens[index].FowlFortuneChickenHealth - 2)
        }
    }
    
    private func FowlFortuneCheckAchievements() {
        FowlFortuneTrackerInstance.FowlFortuneUpdateAllAchievements(
            FowlFortuneFarm: &FowlFortuneCurrentFarm,
            FowlFortuneStats: FowlFortuneCurrentStats
        )
    }
    
    private func FowlFortuneUnlockAchievement(at FowlFortuneIndex: Int) {
        if !FowlFortuneCurrentFarm.FowlFortuneAchievements[FowlFortuneIndex].FowlFortuneAchievementIsUnlocked {
            FowlFortuneCurrentFarm.FowlFortuneAchievements[FowlFortuneIndex].FowlFortuneAchievementIsUnlocked = true
            FowlFortuneCurrentFarm.FowlFortuneTotalCredits += FowlFortuneCurrentFarm.FowlFortuneAchievements[FowlFortuneIndex].FowlFortuneAchievementReward
        }
    }
    
    func FowlFortuneFeedChickens() {
        for index in FowlFortuneCurrentFarm.FowlFortuneChickens.indices {
            FowlFortuneCurrentFarm.FowlFortuneChickens[index].FowlFortuneChickenHappiness = min(100, FowlFortuneCurrentFarm.FowlFortuneChickens[index].FowlFortuneChickenHappiness + 20)
            FowlFortuneCurrentFarm.FowlFortuneChickens[index].FowlFortuneChickenHealth = min(100, FowlFortuneCurrentFarm.FowlFortuneChickens[index].FowlFortuneChickenHealth + 10)
            FowlFortuneCurrentFarm.FowlFortuneChickens[index].FowlFortuneChickenLastFed = Date()
        }
        
        FowlFortuneTrackerInstance.FowlFortuneRecordChickenFeeding(
            FowlFortuneFarm: &FowlFortuneCurrentFarm,
            FowlFortuneStats: &FowlFortuneCurrentStats
        )
    }
    
    func FowlFortuneCollectEggs() -> Int {
        let FowlFortuneCollectedEggs = FowlFortuneCurrentFarm.FowlFortuneTotalEggs
        FowlFortuneCurrentFarm.FowlFortuneTotalEggs = 0
        FowlFortuneCurrentFarm.FowlFortuneTotalCredits += FowlFortuneCollectedEggs
        FowlFortuneSaveFarm()
        return FowlFortuneCollectedEggs
    }
    
    func FowlFortuneBuyChicken(_ FowlFortuneChickenType: FowlFortuneChickenType) -> Bool {
        let FowlFortuneCost = FowlFortuneChickenType.FowlFortuneChickenCost
        guard FowlFortuneCurrentFarm.FowlFortuneTotalCredits >= FowlFortuneCost else { return false }
        
        let FowlFortuneNewChicken = FowlFortuneChicken(FowlFortuneChickenType: FowlFortuneChickenType)
        FowlFortuneCurrentFarm.FowlFortuneChickens.append(FowlFortuneNewChicken)
        FowlFortuneCurrentFarm.FowlFortuneTotalCredits -= FowlFortuneCost
        FowlFortuneSaveFarm()
        return true
    }
    
    func FowlFortuneBuyBuilding(_ FowlFortuneBuildingType: FowlFortuneBuildingType) -> Bool {
        let FowlFortuneCost = FowlFortuneBuildingType.FowlFortuneBuildingCost
        guard FowlFortuneCurrentFarm.FowlFortuneTotalCredits >= FowlFortuneCost else { return false }
        
        let FowlFortuneNewBuilding = FowlFortuneBuilding(
            FowlFortuneBuildingType: FowlFortuneBuildingType,
            FowlFortuneBuildingPosition: CGPoint(x: CGFloat.random(in: 50...300), y: CGFloat.random(in: 100...400))
        )
        FowlFortuneCurrentFarm.FowlFortuneBuildings.append(FowlFortuneNewBuilding)
        FowlFortuneCurrentFarm.FowlFortuneTotalCredits -= FowlFortuneCost
        
        FowlFortuneTrackerInstance.FowlFortuneRecordBuildingBuilt(
            FowlFortuneBuildingType: FowlFortuneBuildingType,
            FowlFortuneFarm: &FowlFortuneCurrentFarm,
            FowlFortuneStats: &FowlFortuneCurrentStats
        )
        
        return true
    }
    
    private func FowlFortuneSaveFarm() {
        FowlFortuneDataStorage.FowlFortuneSaveFarm(FowlFortuneCurrentFarm)
    }
    
    var FowlFortuneFarmData: FowlFortuneFarm {
        return FowlFortuneCurrentFarm
    }
    
    var FowlFortuneTotalEggs: Int {
        return FowlFortuneCurrentFarm.FowlFortuneTotalEggs
    }
    
    var FowlFortuneTotalCredits: Int {
        return FowlFortuneCurrentFarm.FowlFortuneTotalCredits
    }
    
    var FowlFortuneChickens: [FowlFortuneChicken] {
        return FowlFortuneCurrentFarm.FowlFortuneChickens
    }
    
    var FowlFortuneBuildings: [FowlFortuneBuilding] {
        return FowlFortuneCurrentFarm.FowlFortuneBuildings
    }
    
    var FowlFortuneAchievements: [FowlFortuneAchievement] {
        return FowlFortuneCurrentFarm.FowlFortuneAchievements
    }
    
    func FowlFortuneRecordDefenseSuccess() {
        FowlFortuneTrackerInstance.FowlFortuneRecordDefenseSuccess(
            FowlFortuneFarm: &FowlFortuneCurrentFarm,
            FowlFortuneStats: &FowlFortuneCurrentStats
        )
    }
    
    func FowlFortuneGetTotalBuildingIncome() -> Int {
        return FowlFortuneBuildingIncomeManager.FowlFortuneGetTotalBuildingIncome()
    }
    
    func FowlFortuneGetBuildingIncomePerMinute() -> Int {
        return FowlFortuneBuildingIncomeManager.FowlFortuneGetBuildingIncomePerMinute()
    }
    
    func FowlFortuneGetBuildingIncomePerHour() -> Int {
        return FowlFortuneBuildingIncomeManager.FowlFortuneGetBuildingIncomePerHour()
    }
}
