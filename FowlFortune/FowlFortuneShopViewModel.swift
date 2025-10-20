import Foundation

class FowlFortuneShopViewModel {
    
    private let FowlFortuneDataStorage = FowlFortuneDataManager.FowlFortuneShared
    private let FowlFortuneTrackerInstance = FowlFortuneAchievementTracker.FowlFortuneShared
    private var FowlFortuneCurrentShopData: FowlFortuneShopData
    private var FowlFortuneCurrentFarm: FowlFortuneFarm
    private var FowlFortuneCurrentStats: FowlFortuneGameStats
    private var FowlFortunePassiveIncomeTimer: Timer?
    
    var FowlFortuneShopUpdateCallback: (() -> Void)?
    var FowlFortunePassiveIncomeCallback: ((Int) -> Void)?
    
    init() {
        FowlFortuneCurrentShopData = FowlFortuneDataStorage.FowlFortuneLoadShopData()
        FowlFortuneCurrentFarm = FowlFortuneDataStorage.FowlFortuneLoadFarm()
        FowlFortuneCurrentStats = FowlFortuneDataStorage.FowlFortuneLoadGameStats()
        
        FowlFortuneInitializeShopDataIfNeeded()
        FowlFortuneStartPassiveIncomeTimer()
    }
    
    deinit {
        FowlFortunePassiveIncomeTimer?.invalidate()
    }
    
    private func FowlFortuneInitializeShopDataIfNeeded() {
        if FowlFortuneCurrentShopData.FowlFortuneUpgrades.isEmpty {
            FowlFortuneCurrentShopData.FowlFortuneInitializeDefaultUpgrades()
            FowlFortuneSaveShopData()
        }
    }
    
    private func FowlFortuneStartPassiveIncomeTimer() {
        FowlFortunePassiveIncomeTimer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { [weak self] _ in
            self?.FowlFortuneProcessPassiveIncome()
        }
    }
    
    private func FowlFortuneProcessPassiveIncome() {
        let FowlFortuneEarnedIncome = FowlFortuneCurrentShopData.FowlFortuneCalculatePassiveIncome()
        
        if FowlFortuneEarnedIncome > 0 {
            FowlFortuneCurrentFarm.FowlFortuneTotalCredits += FowlFortuneEarnedIncome
            FowlFortuneCurrentStats.FowlFortuneTotalCreditsEarned += FowlFortuneEarnedIncome
            
            FowlFortuneSaveData()
            FowlFortunePassiveIncomeCallback?(FowlFortuneEarnedIncome)
        }
    }
    
    func FowlFortuneBuyUpgrade(_ FowlFortuneUpgradeID: String) -> Bool {
        guard let FowlFortuneUpgradeIndex = FowlFortuneCurrentShopData.FowlFortuneUpgrades.firstIndex(where: { $0.FowlFortuneUpgradeID == FowlFortuneUpgradeID }) else {
            return false
        }
        
        var FowlFortuneUpgrade = FowlFortuneCurrentShopData.FowlFortuneUpgrades[FowlFortuneUpgradeIndex]
        
        guard FowlFortuneUpgrade.FowlFortuneUpgradeCurrentLevel < FowlFortuneUpgrade.FowlFortuneUpgradeMaxLevel else {
            return false
        }
        
        let FowlFortuneUpgradeCost = FowlFortuneCurrentShopData.FowlFortuneGetUpgradeCost(for: FowlFortuneUpgrade)
        
        guard FowlFortuneCurrentFarm.FowlFortuneTotalCredits >= FowlFortuneUpgradeCost else {
            return false
        }
        
        FowlFortuneCurrentFarm.FowlFortuneTotalCredits -= FowlFortuneUpgradeCost
        FowlFortuneUpgrade.FowlFortuneUpgradeCurrentLevel += 1
        
        FowlFortuneCurrentShopData.FowlFortuneUpgrades[FowlFortuneUpgradeIndex] = FowlFortuneUpgrade
        
        FowlFortuneSaveData()
        FowlFortuneShopUpdateCallback?()
        
        return true
    }
    
    func FowlFortuneCanAffordUpgrade(_ FowlFortuneUpgradeID: String) -> Bool {
        guard let FowlFortuneUpgrade = FowlFortuneCurrentShopData.FowlFortuneUpgrades.first(where: { $0.FowlFortuneUpgradeID == FowlFortuneUpgradeID }) else {
            return false
        }
        
        let FowlFortuneUpgradeCost = FowlFortuneCurrentShopData.FowlFortuneGetUpgradeCost(for: FowlFortuneUpgrade)
        return FowlFortuneCurrentFarm.FowlFortuneTotalCredits >= FowlFortuneUpgradeCost
    }
    
    func FowlFortuneGetUpgradeCost(_ FowlFortuneUpgradeID: String) -> Int {
        guard let FowlFortuneUpgrade = FowlFortuneCurrentShopData.FowlFortuneUpgrades.first(where: { $0.FowlFortuneUpgradeID == FowlFortuneUpgradeID }) else {
            return 0
        }
        
        return FowlFortuneCurrentShopData.FowlFortuneGetUpgradeCost(for: FowlFortuneUpgrade)
    }
    
    func FowlFortuneIsUpgradeMaxLevel(_ FowlFortuneUpgradeID: String) -> Bool {
        guard let FowlFortuneUpgrade = FowlFortuneCurrentShopData.FowlFortuneUpgrades.first(where: { $0.FowlFortuneUpgradeID == FowlFortuneUpgradeID }) else {
            return true
        }
        
        return FowlFortuneUpgrade.FowlFortuneUpgradeCurrentLevel >= FowlFortuneUpgrade.FowlFortuneUpgradeMaxLevel
    }
    
    private func FowlFortuneSaveData() {
        FowlFortuneDataStorage.FowlFortuneSaveFarm(FowlFortuneCurrentFarm)
        FowlFortuneDataStorage.FowlFortuneSaveGameStats(FowlFortuneCurrentStats)
        FowlFortuneDataStorage.FowlFortuneSaveShopData(FowlFortuneCurrentShopData)
    }
    
    private func FowlFortuneSaveShopData() {
        FowlFortuneDataStorage.FowlFortuneSaveShopData(FowlFortuneCurrentShopData)
    }
    
    func FowlFortuneLoadShopData() {
        FowlFortuneCurrentShopData = FowlFortuneDataStorage.FowlFortuneLoadShopData()
        FowlFortuneCurrentFarm = FowlFortuneDataStorage.FowlFortuneLoadFarm()
        FowlFortuneCurrentStats = FowlFortuneDataStorage.FowlFortuneLoadGameStats()
        FowlFortuneShopUpdateCallback?()
    }
    
    // MARK: - Public Properties
    
    var FowlFortuneUpgrades: [FowlFortuneShopUpgrade] {
        return FowlFortuneCurrentShopData.FowlFortuneUpgrades
    }
    
    var FowlFortuneTotalCredits: Int {
        return FowlFortuneCurrentFarm.FowlFortuneTotalCredits
    }
    
    var FowlFortuneTotalPassiveIncomePerMinute: Int {
        return FowlFortuneCurrentShopData.FowlFortuneGetTotalPassiveIncomePerMinute()
    }
    
    var FowlFortuneTotalPassiveIncome: Int {
        return FowlFortuneCurrentShopData.FowlFortuneTotalPassiveIncome
    }
}
