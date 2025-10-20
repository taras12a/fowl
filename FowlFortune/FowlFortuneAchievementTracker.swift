import Foundation

class FowlFortuneAchievementTracker {
    static let FowlFortuneShared = FowlFortuneAchievementTracker()
    
    private let FowlFortuneDataStorage = FowlFortuneDataManager.FowlFortuneShared
    
    private init() {}
    
    func FowlFortuneUpdateAchievementProgress(_ FowlFortuneAchievementType: FowlFortuneAchievementType, FowlFortuneProgress: Int, FowlFortuneFarm: inout FowlFortuneFarm) {
        guard let FowlFortuneAchievementIndex = FowlFortuneFarm.FowlFortuneAchievements.firstIndex(where: { $0.FowlFortuneAchievementType == FowlFortuneAchievementType }) else {
            return
        }
        
        var FowlFortuneAchievement = FowlFortuneFarm.FowlFortuneAchievements[FowlFortuneAchievementIndex]
        
        if !FowlFortuneAchievement.FowlFortuneAchievementIsUnlocked {
            FowlFortuneAchievement.FowlFortuneAchievementProgress = min(FowlFortuneProgress, FowlFortuneAchievement.FowlFortuneAchievementTarget)
            
            if FowlFortuneAchievement.FowlFortuneAchievementProgress >= FowlFortuneAchievement.FowlFortuneAchievementTarget {
                FowlFortuneAchievement.FowlFortuneAchievementIsUnlocked = true
                FowlFortuneFarm.FowlFortuneTotalCredits += FowlFortuneAchievement.FowlFortuneAchievementReward
                FowlFortuneFarm.FowlFortuneAchievements[FowlFortuneAchievementIndex] = FowlFortuneAchievement
                FowlFortuneDataStorage.FowlFortuneSaveFarm(FowlFortuneFarm)
            } else {
                FowlFortuneFarm.FowlFortuneAchievements[FowlFortuneAchievementIndex] = FowlFortuneAchievement
            }
        }
    }
    
    func FowlFortuneUpdateAllAchievements(FowlFortuneFarm: inout FowlFortuneFarm, FowlFortuneStats: FowlFortuneGameStats) {
        FowlFortuneUpdateAchievementProgress(.FowlFortuneFirstEggs, FowlFortuneProgress: FowlFortuneStats.FowlFortuneTotalEggsCollected, FowlFortuneFarm: &FowlFortuneFarm)
        FowlFortuneUpdateAchievementProgress(.FowlFortuneEggCollector, FowlFortuneProgress: FowlFortuneStats.FowlFortuneTotalEggsCollected, FowlFortuneFarm: &FowlFortuneFarm)
        FowlFortuneUpdateAchievementProgress(.FowlFortuneCreditEarner, FowlFortuneProgress: FowlFortuneStats.FowlFortuneTotalCreditsEarned, FowlFortuneFarm: &FowlFortuneFarm)
        FowlFortuneUpdateAchievementProgress(.FowlFortuneChickenFeeder, FowlFortuneProgress: FowlFortuneStats.FowlFortuneTotalChickensFed, FowlFortuneFarm: &FowlFortuneFarm)
        FowlFortuneUpdateAchievementProgress(.FowlFortuneBuildingUpgrader, FowlFortuneProgress: FowlFortuneStats.FowlFortuneTotalBuildingsUpgraded, FowlFortuneFarm: &FowlFortuneFarm)
        FowlFortuneUpdateAchievementProgress(.FowlFortuneDefenseMaster, FowlFortuneProgress: FowlFortuneStats.FowlFortuneTotalDefenseTowersBuilt, FowlFortuneFarm: &FowlFortuneFarm)
        FowlFortuneUpdateAchievementProgress(.FowlFortuneFarmMaster, FowlFortuneProgress: FowlFortuneStats.FowlFortuneTotalFarmCycles, FowlFortuneFarm: &FowlFortuneFarm)
        FowlFortuneUpdateAchievementProgress(.FowlFortuneDefender, FowlFortuneProgress: FowlFortuneStats.FowlFortuneTotalDefensesSuccessful, FowlFortuneFarm: &FowlFortuneFarm)
        
        let FowlFortuneUniqueChickenTypes = Set(FowlFortuneFarm.FowlFortuneChickens.map { $0.FowlFortuneChickenType }).count
        FowlFortuneUpdateAchievementProgress(.FowlFortuneChickenCollector, FowlFortuneProgress: FowlFortuneUniqueChickenTypes, FowlFortuneFarm: &FowlFortuneFarm)
        
        let FowlFortuneUniqueBuildingTypes = Set(FowlFortuneFarm.FowlFortuneBuildings.map { $0.FowlFortuneBuildingType }).count
        FowlFortuneUpdateAchievementProgress(.FowlFortuneBuilder, FowlFortuneProgress: FowlFortuneUniqueBuildingTypes, FowlFortuneFarm: &FowlFortuneFarm)
    }
    
    func FowlFortuneRecordEggCollection(FowlFortuneEggCount: Int, FowlFortuneFarm: inout FowlFortuneFarm, FowlFortuneStats: inout FowlFortuneGameStats) {
        FowlFortuneStats.FowlFortuneTotalEggsCollected += FowlFortuneEggCount
        FowlFortuneStats.FowlFortuneTotalCreditsEarned += FowlFortuneEggCount * 2
        FowlFortuneFarm.FowlFortuneTotalEggs += FowlFortuneEggCount
        FowlFortuneFarm.FowlFortuneTotalCredits += FowlFortuneEggCount * 2
        
        FowlFortuneUpdateAllAchievements(FowlFortuneFarm: &FowlFortuneFarm, FowlFortuneStats: FowlFortuneStats)
        
        FowlFortuneDataStorage.FowlFortuneSaveFarm(FowlFortuneFarm)
        FowlFortuneDataStorage.FowlFortuneSaveGameStats(FowlFortuneStats)
    }
    
    func FowlFortuneRecordChickenFeeding(FowlFortuneFarm: inout FowlFortuneFarm, FowlFortuneStats: inout FowlFortuneGameStats) {
        FowlFortuneStats.FowlFortuneTotalChickensFed += 1
        
        FowlFortuneUpdateAllAchievements(FowlFortuneFarm: &FowlFortuneFarm, FowlFortuneStats: FowlFortuneStats)
        
        FowlFortuneDataStorage.FowlFortuneSaveFarm(FowlFortuneFarm)
        FowlFortuneDataStorage.FowlFortuneSaveGameStats(FowlFortuneStats)
    }
    
    func FowlFortuneRecordBuildingBuilt(FowlFortuneBuildingType: FowlFortuneBuildingType, FowlFortuneFarm: inout FowlFortuneFarm, FowlFortuneStats: inout FowlFortuneGameStats) {
        FowlFortuneStats.FowlFortuneTotalBuildingsBuilt += 1
        
        if FowlFortuneBuildingType == .FowlFortuneDefense {
            FowlFortuneStats.FowlFortuneTotalDefenseTowersBuilt += 1
        }
        
        FowlFortuneUpdateAllAchievements(FowlFortuneFarm: &FowlFortuneFarm, FowlFortuneStats: FowlFortuneStats)
        
        FowlFortuneDataStorage.FowlFortuneSaveFarm(FowlFortuneFarm)
        FowlFortuneDataStorage.FowlFortuneSaveGameStats(FowlFortuneStats)
    }
    
    func FowlFortuneRecordBuildingUpgraded(FowlFortuneFarm: inout FowlFortuneFarm, FowlFortuneStats: inout FowlFortuneGameStats) {
        FowlFortuneStats.FowlFortuneTotalBuildingsUpgraded += 1
        
        FowlFortuneUpdateAllAchievements(FowlFortuneFarm: &FowlFortuneFarm, FowlFortuneStats: FowlFortuneStats)
        
        FowlFortuneDataStorage.FowlFortuneSaveFarm(FowlFortuneFarm)
        FowlFortuneDataStorage.FowlFortuneSaveGameStats(FowlFortuneStats)
    }
    
    func FowlFortuneRecordFarmCycle(FowlFortuneFarm: inout FowlFortuneFarm, FowlFortuneStats: inout FowlFortuneGameStats) {
        FowlFortuneStats.FowlFortuneTotalFarmCycles += 1
        
        FowlFortuneUpdateAllAchievements(FowlFortuneFarm: &FowlFortuneFarm, FowlFortuneStats: FowlFortuneStats)
        
        FowlFortuneDataStorage.FowlFortuneSaveFarm(FowlFortuneFarm)
        FowlFortuneDataStorage.FowlFortuneSaveGameStats(FowlFortuneStats)
    }
    
    func FowlFortuneRecordDefenseSuccess(FowlFortuneFarm: inout FowlFortuneFarm, FowlFortuneStats: inout FowlFortuneGameStats) {
        FowlFortuneStats.FowlFortuneTotalDefensesSuccessful += 1
        
        FowlFortuneUpdateAllAchievements(FowlFortuneFarm: &FowlFortuneFarm, FowlFortuneStats: FowlFortuneStats)
        
        FowlFortuneDataStorage.FowlFortuneSaveFarm(FowlFortuneFarm)
        FowlFortuneDataStorage.FowlFortuneSaveGameStats(FowlFortuneStats)
    }
}
