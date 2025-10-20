import Foundation

struct FowlFortuneShopUpgrade: Codable {
    let FowlFortuneUpgradeID: String
    var FowlFortuneUpgradeName: String
    var FowlFortuneUpgradeDescription: String
    var FowlFortuneUpgradeEmoji: String
    var FowlFortuneUpgradeBaseCost: Int
    var FowlFortuneUpgradeCurrentLevel: Int = 0
    var FowlFortuneUpgradeMaxLevel: Int = 10
    var FowlFortuneUpgradePassiveIncomePerMinute: Int = 0
    var FowlFortuneUpgradeIncomeMultiplier: Double = 1.0
    var FowlFortuneUpgradeCostMultiplier: Double = 1.5
    var FowlFortuneUpgradeType: FowlFortuneUpgradeType
}

enum FowlFortuneUpgradeType: String, CaseIterable, Codable {
    case FowlFortuneEggProduction = "Egg Production"
    case FowlFortuneChickenHappiness = "Chicken Happiness"
    case FowlFortuneFarmEfficiency = "Farm Efficiency"
    case FowlFortuneBuildingCapacity = "Building Capacity"
    case FowlFortuneDefenseStrength = "Defense Strength"
    case FowlFortuneCreditMultiplier = "Credit Multiplier"
    
    var FowlFortuneUpgradeEmoji: String {
        switch self {
        case .FowlFortuneEggProduction: return "🥚"
        case .FowlFortuneChickenHappiness: return "😊"
        case .FowlFortuneFarmEfficiency: return "⚡"
        case .FowlFortuneBuildingCapacity: return "🏠"
        case .FowlFortuneDefenseStrength: return "🛡️"
        case .FowlFortuneCreditMultiplier: return "💰"
        }
    }
    
    var FowlFortuneUpgradeName: String {
        switch self {
        case .FowlFortuneEggProduction: return "Egg Boost"
        case .FowlFortuneChickenHappiness: return "Happy Chickens"
        case .FowlFortuneFarmEfficiency: return "Efficiency"
        case .FowlFortuneBuildingCapacity: return "Capacity"
        case .FowlFortuneDefenseStrength: return "Defense"
        case .FowlFortuneCreditMultiplier: return "Multiplier"
        }
    }
    
    var FowlFortuneUpgradeDescription: String {
        switch self {
        case .FowlFortuneEggProduction: return "Egg production +25% per level"
        case .FowlFortuneChickenHappiness: return "Chickens stay happy longer"
        case .FowlFortuneFarmEfficiency: return "Reduces maintenance time"
        case .FowlFortuneBuildingCapacity: return "Building capacity +2 per level"
        case .FowlFortuneDefenseStrength: return "Defense against predators +30%"
        case .FowlFortuneCreditMultiplier: return "Credit earnings +50% per level"
        }
    }
    
    var FowlFortuneUpgradeBaseCost: Int {
        switch self {
        case .FowlFortuneEggProduction: return 100
        case .FowlFortuneChickenHappiness: return 75
        case .FowlFortuneFarmEfficiency: return 150
        case .FowlFortuneBuildingCapacity: return 200
        case .FowlFortuneDefenseStrength: return 175
        case .FowlFortuneCreditMultiplier: return 250
        }
    }
    
    var FowlFortuneUpgradePassiveIncomePerMinute: Int {
        switch self {
        case .FowlFortuneEggProduction: return 5
        case .FowlFortuneChickenHappiness: return 3
        case .FowlFortuneFarmEfficiency: return 8
        case .FowlFortuneBuildingCapacity: return 10
        case .FowlFortuneDefenseStrength: return 7
        case .FowlFortuneCreditMultiplier: return 12
        }
    }
}

struct FowlFortuneShopData: Codable {
    var FowlFortuneUpgrades: [FowlFortuneShopUpgrade] = []
    var FowlFortuneTotalPassiveIncome: Int = 0
    var FowlFortuneLastPassiveIncomeTime: Date = Date()
    
    mutating func FowlFortuneInitializeDefaultUpgrades() {
        FowlFortuneUpgrades = FowlFortuneUpgradeType.allCases.map { upgradeType in
            FowlFortuneShopUpgrade(
                FowlFortuneUpgradeID: upgradeType.rawValue.lowercased().replacingOccurrences(of: " ", with: "_"),
                FowlFortuneUpgradeName: upgradeType.FowlFortuneUpgradeName,
                FowlFortuneUpgradeDescription: upgradeType.FowlFortuneUpgradeDescription,
                FowlFortuneUpgradeEmoji: upgradeType.FowlFortuneUpgradeEmoji,
                FowlFortuneUpgradeBaseCost: upgradeType.FowlFortuneUpgradeBaseCost,
                FowlFortuneUpgradePassiveIncomePerMinute: upgradeType.FowlFortuneUpgradePassiveIncomePerMinute,
                FowlFortuneUpgradeType: upgradeType
            )
        }
    }
    
    func FowlFortuneGetUpgradeCost(for upgrade: FowlFortuneShopUpgrade) -> Int {
        let FowlFortuneCostMultiplier = pow(upgrade.FowlFortuneUpgradeCostMultiplier, Double(upgrade.FowlFortuneUpgradeCurrentLevel))
        return Int(Double(upgrade.FowlFortuneUpgradeBaseCost) * FowlFortuneCostMultiplier)
    }
    
    func FowlFortuneGetTotalPassiveIncomePerMinute() -> Int {
        return FowlFortuneUpgrades.reduce(0) { total, upgrade in
            let FowlFortuneIncomeMultiplier = pow(upgrade.FowlFortuneUpgradeIncomeMultiplier, Double(upgrade.FowlFortuneUpgradeCurrentLevel))
            let FowlFortuneIncomePerLevel = Int(Double(upgrade.FowlFortuneUpgradePassiveIncomePerMinute) * FowlFortuneIncomeMultiplier)
            return total + (FowlFortuneIncomePerLevel * upgrade.FowlFortuneUpgradeCurrentLevel)
        }
    }
    
    mutating func FowlFortuneCalculatePassiveIncome() -> Int {
        let FowlFortuneCurrentTime = Date()
        let FowlFortuneTimeDifference = FowlFortuneCurrentTime.timeIntervalSince(FowlFortuneLastPassiveIncomeTime)
        let FowlFortuneMinutesPassed = FowlFortuneTimeDifference / 60.0
        
        let FowlFortuneTotalIncomePerMinute = FowlFortuneGetTotalPassiveIncomePerMinute()
        let FowlFortuneEarnedIncome = Int(FowlFortuneMinutesPassed * Double(FowlFortuneTotalIncomePerMinute))
        
        FowlFortuneTotalPassiveIncome += FowlFortuneEarnedIncome
        FowlFortuneLastPassiveIncomeTime = FowlFortuneCurrentTime
        
        return FowlFortuneEarnedIncome
    }
}
