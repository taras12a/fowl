import Foundation

class FowlFortuneDataManager {
    static let FowlFortuneShared = FowlFortuneDataManager()
    
    private let FowlFortuneUserDefaults = UserDefaults.standard
    private let FowlFortuneFarmKey = "FowlFortuneFarmData"
    private let FowlFortuneStatsKey = "FowlFortuneGameStats"
    private let FowlFortuneBotModeKey = "FowlFortuneBotMode"
    private let FowlFortuneShopKey = "FowlFortuneShopData"
    
    private init() {}
    
    func FowlFortuneSaveFarm(_ FowlFortuneFarm: FowlFortuneFarm) {
        do {
            let FowlFortuneEncodedData = try JSONEncoder().encode(FowlFortuneFarm)
            FowlFortuneUserDefaults.set(FowlFortuneEncodedData, forKey: FowlFortuneFarmKey)
        } catch {
            print("FowlFortune Error saving farm data: \(error)")
        }
    }
    
    func FowlFortuneLoadFarm() -> FowlFortuneFarm {
        guard let FowlFortuneData = FowlFortuneUserDefaults.data(forKey: FowlFortuneFarmKey) else {
            return FowlFortuneFarm.FowlFortuneCreateInitialFarm()
        }

        do {
            return try JSONDecoder().decode(FowlFortuneFarm.self, from: FowlFortuneData)
        } catch {
            print("FowlFortune Error loading farm data: \(error)")
            return FowlFortuneFarm.FowlFortuneCreateInitialFarm()
        }
    }
    
    func FowlFortuneSaveGameStats(_ FowlFortuneStats: FowlFortuneGameStats) {
        do {
            let FowlFortuneEncodedData = try JSONEncoder().encode(FowlFortuneStats)
            FowlFortuneUserDefaults.set(FowlFortuneEncodedData, forKey: FowlFortuneStatsKey)
        } catch {
            print("FowlFortune Error saving game stats: \(error)")
        }
    }
    
    func FowlFortuneLoadGameStats() -> FowlFortuneGameStats {
        guard let FowlFortuneData = FowlFortuneUserDefaults.data(forKey: FowlFortuneStatsKey) else {
            return FowlFortuneGameStats()
        }
        
        do {
            return try JSONDecoder().decode(FowlFortuneGameStats.self, from: FowlFortuneData)
        } catch {
            print("FowlFortune Error loading game stats: \(error)")
            return FowlFortuneGameStats()
        }
    }
    
    func FowlFortuneSaveBotMode(_ FowlFortuneBotMode: FowlFortuneFarmBotMode) {
        FowlFortuneUserDefaults.set(FowlFortuneBotMode.rawValue, forKey: FowlFortuneBotModeKey)
    }
    
    func FowlFortuneLoadBotMode() -> FowlFortuneFarmBotMode {
        guard let FowlFortuneModeString = FowlFortuneUserDefaults.string(forKey: FowlFortuneBotModeKey),
              let FowlFortuneMode = FowlFortuneFarmBotMode(rawValue: FowlFortuneModeString) else {
            return .FowlFortuneNeutralMode
        }
        return FowlFortuneMode
    }
    
    func FowlFortuneResetAllData() {
        FowlFortuneUserDefaults.removeObject(forKey: FowlFortuneFarmKey)
        FowlFortuneUserDefaults.removeObject(forKey: FowlFortuneStatsKey)
        FowlFortuneUserDefaults.removeObject(forKey: FowlFortuneBotModeKey)
        FowlFortuneUserDefaults.removeObject(forKey: FowlFortuneShopKey)
    }
    
    func FowlFortuneSaveShopData(_ FowlFortuneShopData: FowlFortuneShopData) {
        do {
            let FowlFortuneEncodedData = try JSONEncoder().encode(FowlFortuneShopData)
            FowlFortuneUserDefaults.set(FowlFortuneEncodedData, forKey: FowlFortuneShopKey)
        } catch {
            print("FowlFortune Error saving shop data: \(error)")
        }
    }
    
    func FowlFortuneLoadShopData() -> FowlFortuneShopData {
        guard let FowlFortuneData = FowlFortuneUserDefaults.data(forKey: FowlFortuneShopKey) else {
            return FowlFortuneShopData()
        }
        
        do {
            return try JSONDecoder().decode(FowlFortuneShopData.self, from: FowlFortuneData)
        } catch {
            print("FowlFortune Error loading shop data: \(error)")
            return FowlFortuneShopData()
        }
    }
    
    func FowlFortuneInitializeDefaultAchievements() -> [FowlFortuneAchievement] {
        var achievements: [FowlFortuneAchievement] = []
        
        for achievementType in FowlFortuneAchievementType.allCases {
            let achievement = FowlFortuneAchievement(
                FowlFortuneAchievementID: achievementType.rawValue.lowercased().replacingOccurrences(of: " ", with: "_"),
                FowlFortuneAchievementTitle: achievementType.FowlFortuneAchievementTitle,
                FowlFortuneAchievementDescription: achievementType.FowlFortuneAchievementDescription,
                FowlFortuneAchievementEmoji: achievementType.FowlFortuneAchievementEmoji,
                FowlFortuneAchievementReward: achievementType.FowlFortuneAchievementReward,
                FowlFortuneAchievementTarget: achievementType.FowlFortuneAchievementTarget,
                FowlFortuneAchievementType: achievementType
            )
            achievements.append(achievement)
        }
        
        return achievements
    }
}
