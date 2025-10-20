import Foundation

class FowlFortuneAchievementsViewModel {

    private let FowlFortuneDataStorage = FowlFortuneDataManager.FowlFortuneShared
    private let FowlFortuneTrackerInstance = FowlFortuneAchievementTracker.FowlFortuneShared
    private var FowlFortuneCurrentFarm: FowlFortuneFarm
    private var FowlFortuneCurrentStats: FowlFortuneGameStats

    var FowlFortuneAchievementsUpdateCallback: (() -> Void)?

    init() {
        FowlFortuneCurrentFarm = FowlFortuneDataStorage.FowlFortuneLoadFarm()
        FowlFortuneCurrentStats = FowlFortuneDataStorage.FowlFortuneLoadGameStats()
        FowlFortuneUpdateAllAchievements()
    }
    
    func FowlFortuneUpdateAllAchievements() {
        FowlFortuneTrackerInstance.FowlFortuneUpdateAllAchievements(
            FowlFortuneFarm: &FowlFortuneCurrentFarm,
            FowlFortuneStats: FowlFortuneCurrentStats
        )
        FowlFortuneAchievementsUpdateCallback?()
    }
    
    func FowlFortuneLoadAchievements() {
        FowlFortuneCurrentFarm = FowlFortuneDataStorage.FowlFortuneLoadFarm()
        FowlFortuneCurrentStats = FowlFortuneDataStorage.FowlFortuneLoadGameStats()
        FowlFortuneUpdateAllAchievements()
    }
    
    func FowlFortuneClaimAchievementReward(_ FowlFortuneAchievementID: String) -> Bool {
        guard let FowlFortuneIndex = FowlFortuneCurrentFarm.FowlFortuneAchievements.firstIndex(where: { $0.FowlFortuneAchievementID == FowlFortuneAchievementID }) else {
            return false
        }
        
        let FowlFortuneAchievement = FowlFortuneCurrentFarm.FowlFortuneAchievements[FowlFortuneIndex]
        guard FowlFortuneAchievement.FowlFortuneAchievementIsUnlocked else { return false }
        
        FowlFortuneCurrentFarm.FowlFortuneTotalCredits += FowlFortuneAchievement.FowlFortuneAchievementReward
        FowlFortuneDataStorage.FowlFortuneSaveFarm(FowlFortuneCurrentFarm)
        FowlFortuneAchievementsUpdateCallback?()
        return true
    }
    
    var FowlFortuneUnlockedAchievements: [FowlFortuneAchievement] {
        return FowlFortuneCurrentFarm.FowlFortuneAchievements.filter { $0.FowlFortuneAchievementIsUnlocked }
    }
    
    var FowlFortuneLockedAchievements: [FowlFortuneAchievement] {
        return FowlFortuneCurrentFarm.FowlFortuneAchievements.filter { !$0.FowlFortuneAchievementIsUnlocked }
    }
    
    var FowlFortuneTotalAchievements: Int {
        return FowlFortuneCurrentFarm.FowlFortuneAchievements.count
    }
    
    var FowlFortuneUnlockedCount: Int {
        return FowlFortuneUnlockedAchievements.count
    }
    
    var FowlFortuneAchievementProgress: Double {
        guard FowlFortuneTotalAchievements > 0 else { return 0.0 }
        return Double(FowlFortuneUnlockedCount) / Double(FowlFortuneTotalAchievements)
    }
    
    var FowlFortuneTotalCredits: Int {
        return FowlFortuneCurrentFarm.FowlFortuneTotalCredits
    }
}
