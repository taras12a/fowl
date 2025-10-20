import Foundation
import UIKit

class FowlFortuneSettingsViewModel {
    
    private let FowlFortuneDataStorage = FowlFortuneDataManager.FowlFortuneShared
    private var FowlFortuneCurrentStats: FowlFortuneGameStats
    private var FowlFortuneCurrentBotMode: FowlFortuneFarmBotMode
    
    var FowlFortuneSettingsUpdateCallback: (() -> Void)?
    
    init() {
        FowlFortuneCurrentStats = FowlFortuneDataStorage.FowlFortuneLoadGameStats()
        FowlFortuneCurrentBotMode = FowlFortuneDataStorage.FowlFortuneLoadBotMode()
    }
    
    func FowlFortuneLoadSettings() {
        FowlFortuneCurrentStats = FowlFortuneDataStorage.FowlFortuneLoadGameStats()
        FowlFortuneCurrentBotMode = FowlFortuneDataStorage.FowlFortuneLoadBotMode()
        FowlFortuneSettingsUpdateCallback?()
    }
    
    func FowlFortuneUpdateBotMode(_ FowlFortuneNewMode: FowlFortuneFarmBotMode) {
        FowlFortuneCurrentBotMode = FowlFortuneNewMode
        FowlFortuneDataStorage.FowlFortuneSaveBotMode(FowlFortuneNewMode)
        FowlFortuneSettingsUpdateCallback?()
    }
    
    func FowlFortuneResetAllData() {
        FowlFortuneDataStorage.FowlFortuneResetAllData()
        FowlFortuneCurrentStats = FowlFortune.FowlFortuneGameStats()
        FowlFortuneCurrentBotMode = .FowlFortuneNeutralMode
        FowlFortuneSettingsUpdateCallback?()
    }
    
    func FowlFortuneUpdateGameStats() {
        let FowlFortuneCurrentFarm = FowlFortuneDataStorage.FowlFortuneLoadFarm()
        FowlFortuneCurrentStats.FowlFortuneTotalEggsCollected = FowlFortuneCurrentFarm.FowlFortuneTotalEggs
        FowlFortuneCurrentStats.FowlFortuneTotalBuildingsBuilt = FowlFortuneCurrentFarm.FowlFortuneBuildings.count
        FowlFortuneCurrentStats.FowlFortuneTotalDefensesSuccessful = FowlFortuneCurrentFarm.FowlFortuneAchievements.filter { $0.FowlFortuneAchievementID == "defender" && $0.FowlFortuneAchievementIsUnlocked }.count
        FowlFortuneDataStorage.FowlFortuneSaveGameStats(FowlFortuneCurrentStats)
        FowlFortuneSettingsUpdateCallback?()
    }
    
    var FowlFortuneCurrentBotModeValue: FowlFortuneFarmBotMode {
        return FowlFortuneCurrentBotMode
    }
    
    var FowlFortuneAvailableBotModes: [FowlFortuneFarmBotMode] {
        return FowlFortuneFarmBotMode.allCases
    }
    
    var FowlFortuneGameStats: FowlFortuneGameStats {
        return FowlFortuneCurrentStats
    }
    
    var FowlFortuneTotalEggsCollected: Int {
        return FowlFortuneCurrentStats.FowlFortuneTotalEggsCollected
    }
    
    var FowlFortuneTotalBuildingsBuilt: Int {
        return FowlFortuneCurrentStats.FowlFortuneTotalBuildingsBuilt
    }
    
    var FowlFortuneTotalDefensesSuccessful: Int {
        return FowlFortuneCurrentStats.FowlFortuneTotalDefensesSuccessful
    }
    
    var FowlFortuneTotalPlayTime: String {
        let FowlFortunePlayTimeInterval = Date().timeIntervalSince(FowlFortuneCurrentStats.FowlFortuneGameStartDate)
        let FowlFortuneHours = Int(FowlFortunePlayTimeInterval) / 3600
        let FowlFortuneMinutes = Int(FowlFortunePlayTimeInterval.truncatingRemainder(dividingBy: 3600)) / 60
        return "\(FowlFortuneHours)h \(FowlFortuneMinutes)m"
    }
    
    func FowlFortuneGetBotModeDescription(for FowlFortuneMode: FowlFortuneFarmBotMode) -> String {
        return FowlFortuneMode.FowlFortuneModeDescription
    }
    
    func FowlFortuneShowPrivacyPolicy() {
        if let FowlFortuneURL = URL(string: "https://example.com/privacy") {
            UIApplication.shared.open(FowlFortuneURL)
        }
    }
    
    func FowlFortuneShowTermsOfService() {
        if let FowlFortuneURL = URL(string: "https://example.com/terms") {
            UIApplication.shared.open(FowlFortuneURL)
        }
    }
}
