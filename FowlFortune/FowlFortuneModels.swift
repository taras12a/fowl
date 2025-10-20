import Foundation

struct FowlFortuneFarm: Codable {
    var FowlFortuneTotalEggs: Int = 0
    var FowlFortuneTotalCredits: Int = 100
    var FowlFortuneLevel: Int = 1
    var FowlFortuneExperience: Int = 0
    var FowlFortuneBuildings: [FowlFortuneBuilding] = []
    var FowlFortuneChickens: [FowlFortuneChicken] = []
    var FowlFortuneAchievements: [FowlFortuneAchievement] = []
    var FowlFortuneLastPlayTime: Date = Date()
    
    static func FowlFortuneCreateInitialFarm() -> FowlFortuneFarm {
        var farm = FowlFortuneFarm()
        
        // Добавляем только одно начальное здание - Chicken Coop
        let initialBuilding = FowlFortuneBuilding(
            FowlFortuneBuildingType: .FowlFortuneCoop,
            FowlFortuneBuildingPosition: CGPoint(x: 50, y: 100)
        )
        
        farm.FowlFortuneBuildings = [initialBuilding]
        return farm
    }
}

struct FowlFortuneChicken: Codable {
    let FowlFortuneChickenID: String = UUID().uuidString
    var FowlFortuneChickenType: FowlFortuneChickenType
    var FowlFortuneChickenLevel: Int = 1
    var FowlFortuneChickenHealth: Int = 100
    var FowlFortuneChickenHappiness: Int = 80
    var FowlFortuneChickenEggProduction: Int = 1
    var FowlFortuneChickenLastFed: Date = Date()
    var FowlFortuneChickenPosition: CGPoint = CGPoint(x: 100, y: 100)
}

enum FowlFortuneChickenType: String, CaseIterable, Codable {
    case FowlFortuneRegularChicken = "Regular Chicken"
    case FowlFortuneGoldenChicken = "Golden Chicken"
    case FowlFortuneSpeedChicken = "Speed Chicken"
    case FowlFortuneHeavyChicken = "Heavy Chicken"
    
    var FowlFortuneChickenEmoji: String {
        switch self {
        case .FowlFortuneRegularChicken: return "🐔"
        case .FowlFortuneGoldenChicken: return "🐓"
        case .FowlFortuneSpeedChicken: return "🐣"
        case .FowlFortuneHeavyChicken: return "🐤"
        }
    }
    
    var FowlFortuneChickenCost: Int {
        switch self {
        case .FowlFortuneRegularChicken: return 50
        case .FowlFortuneGoldenChicken: return 200
        case .FowlFortuneSpeedChicken: return 150
        case .FowlFortuneHeavyChicken: return 100
        }
    }
}

struct FowlFortuneBuilding: Codable {
    let FowlFortuneBuildingID: String = UUID().uuidString
    var FowlFortuneBuildingType: FowlFortuneBuildingType
    var FowlFortuneBuildingLevel: Int = 1
    var FowlFortuneBuildingPosition: CGPoint
    var FowlFortuneBuildingLastIncomeTime: Date = Date()
    
    var FowlFortuneBuildingCapacity: Int {
        return FowlFortuneBuildingType.FowlFortuneBuildingCapacity * FowlFortuneBuildingLevel
    }
    
    var FowlFortuneBuildingProtection: Int {
        return FowlFortuneBuildingType.FowlFortuneBuildingProtection * FowlFortuneBuildingLevel
    }
    
    var FowlFortuneBuildingPassiveIncome: Int {
        return FowlFortuneBuildingType.FowlFortuneBuildingPassiveIncome * FowlFortuneBuildingLevel
    }
    
    var FowlFortuneBuildingIncomeInterval: TimeInterval {
        return 60.0
    }
}

enum FowlFortuneBuildingType: String, CaseIterable, Codable {
    case FowlFortuneCoop = "Chicken Coop"
    case FowlFortuneWarehouse = "Warehouse"
    case FowlFortuneDefense = "Defense Tower"
    case FowlFortuneHatchery = "Hatchery"
    
    var FowlFortuneBuildingEmoji: String {
        switch self {
        case .FowlFortuneCoop: return "🏠"
        case .FowlFortuneWarehouse: return "🏪"
        case .FowlFortuneDefense: return "🛡️"
        case .FowlFortuneHatchery: return "🥚"
        }
    }
    
    var FowlFortuneBuildingCost: Int {
        switch self {
        case .FowlFortuneCoop: return 100
        case .FowlFortuneWarehouse: return 200
        case .FowlFortuneDefense: return 300
        case .FowlFortuneHatchery: return 150
        }
    }
    
    var FowlFortuneBuildingPassiveIncome: Int {
        switch self {
        case .FowlFortuneCoop: return 5
        case .FowlFortuneWarehouse: return 8
        case .FowlFortuneDefense: return 3
        case .FowlFortuneHatchery: return 6
        }
    }
    
    var FowlFortuneBuildingCapacity: Int {
        switch self {
        case .FowlFortuneCoop: return 5
        case .FowlFortuneWarehouse: return 10
        case .FowlFortuneDefense: return 1
        case .FowlFortuneHatchery: return 3
        }
    }
    
    var FowlFortuneBuildingProtection: Int {
        switch self {
        case .FowlFortuneCoop: return 10
        case .FowlFortuneWarehouse: return 15
        case .FowlFortuneDefense: return 25
        case .FowlFortuneHatchery: return 5
        }
    }
}

struct FowlFortuneAchievement: Codable {
    let FowlFortuneAchievementID: String
    var FowlFortuneAchievementTitle: String
    var FowlFortuneAchievementDescription: String
    var FowlFortuneAchievementEmoji: String
    var FowlFortuneAchievementIsUnlocked: Bool = false
    var FowlFortuneAchievementReward: Int = 50
    var FowlFortuneAchievementProgress: Int = 0
    var FowlFortuneAchievementTarget: Int = 1
    var FowlFortuneAchievementType: FowlFortuneAchievementType
}

enum FowlFortuneAchievementType: String, CaseIterable, Codable {
    case FowlFortuneFirstEggs = "First Eggs"
    case FowlFortuneFarmMaster = "Farm Master"
    case FowlFortuneDefender = "Defender"
    case FowlFortuneChickenCollector = "Chicken Collector"
    case FowlFortuneBuilder = "Builder"
    case FowlFortuneEggCollector = "Egg Collector"
    case FowlFortuneCreditEarner = "Credit Earner"
    case FowlFortuneChickenFeeder = "Chicken Feeder"
    case FowlFortuneBuildingUpgrader = "Building Upgrader"
    case FowlFortuneDefenseMaster = "Defense Master"
    
    var FowlFortuneAchievementEmoji: String {
        switch self {
        case .FowlFortuneFirstEggs: return "🥚"
        case .FowlFortuneFarmMaster: return "🏆"
        case .FowlFortuneDefender: return "🛡️"
        case .FowlFortuneChickenCollector: return "🐔"
        case .FowlFortuneBuilder: return "🔨"
        case .FowlFortuneEggCollector: return "🥚"
        case .FowlFortuneCreditEarner: return "💰"
        case .FowlFortuneChickenFeeder: return "🌾"
        case .FowlFortuneBuildingUpgrader: return "⬆️"
        case .FowlFortuneDefenseMaster: return "🏰"
        }
    }
    
    var FowlFortuneAchievementTitle: String {
        switch self {
        case .FowlFortuneFirstEggs: return "First Eggs"
        case .FowlFortuneFarmMaster: return "Farm Master"
        case .FowlFortuneDefender: return "Defender"
        case .FowlFortuneChickenCollector: return "Chicken Collector"
        case .FowlFortuneBuilder: return "Builder"
        case .FowlFortuneEggCollector: return "Egg Collector"
        case .FowlFortuneCreditEarner: return "Credit Earner"
        case .FowlFortuneChickenFeeder: return "Chicken Feeder"
        case .FowlFortuneBuildingUpgrader: return "Building Upgrader"
        case .FowlFortuneDefenseMaster: return "Defense Master"
        }
    }
    
    var FowlFortuneAchievementDescription: String {
        switch self {
        case .FowlFortuneFirstEggs: return "Collect your first batch of eggs"
        case .FowlFortuneFarmMaster: return "Manage your farm for 10 cycles"
        case .FowlFortuneDefender: return "Successfully defend your farm from predators"
        case .FowlFortuneChickenCollector: return "Own 5 different types of chickens"
        case .FowlFortuneBuilder: return "Build 3 different types of buildings"
        case .FowlFortuneEggCollector: return "Collect 100 eggs total"
        case .FowlFortuneCreditEarner: return "Earn 1000 credits total"
        case .FowlFortuneChickenFeeder: return "Feed your chickens 50 times"
        case .FowlFortuneBuildingUpgrader: return "Upgrade 5 buildings"
        case .FowlFortuneDefenseMaster: return "Build 3 defense towers"
        }
    }
    
    var FowlFortuneAchievementTarget: Int {
        switch self {
        case .FowlFortuneFirstEggs: return 1
        case .FowlFortuneFarmMaster: return 10
        case .FowlFortuneDefender: return 1
        case .FowlFortuneChickenCollector: return 5
        case .FowlFortuneBuilder: return 3
        case .FowlFortuneEggCollector: return 100
        case .FowlFortuneCreditEarner: return 1000
        case .FowlFortuneChickenFeeder: return 50
        case .FowlFortuneBuildingUpgrader: return 5
        case .FowlFortuneDefenseMaster: return 3
        }
    }
    
    var FowlFortuneAchievementReward: Int {
        switch self {
        case .FowlFortuneFirstEggs: return 25
        case .FowlFortuneFarmMaster: return 100
        case .FowlFortuneDefender: return 75
        case .FowlFortuneChickenCollector: return 150
        case .FowlFortuneBuilder: return 200
        case .FowlFortuneEggCollector: return 100
        case .FowlFortuneCreditEarner: return 200
        case .FowlFortuneChickenFeeder: return 75
        case .FowlFortuneBuildingUpgrader: return 125
        case .FowlFortuneDefenseMaster: return 250
        }
    }
}

struct FowlFortuneGameStats: Codable {
    var FowlFortuneTotalEggsCollected: Int = 0
    var FowlFortuneTotalBuildingsBuilt: Int = 0
    var FowlFortuneTotalDefensesSuccessful: Int = 0
    var FowlFortuneTotalPlayTime: TimeInterval = 0
    var FowlFortuneGameStartDate: Date = Date()
    var FowlFortuneTotalCreditsEarned: Int = 0
    var FowlFortuneTotalChickensFed: Int = 0
    var FowlFortuneTotalBuildingsUpgraded: Int = 0
    var FowlFortuneTotalDefenseTowersBuilt: Int = 0
    var FowlFortuneTotalFarmCycles: Int = 0
}

enum FowlFortuneFarmBotMode: String, CaseIterable, Codable {
    case FowlFortuneSupportMode = "Support"
    case FowlFortuneNeutralMode = "Neutral"
    case FowlFortuneSilentMode = "Silent"
    
    var FowlFortuneModeDescription: String {
        switch self {
        case .FowlFortuneSupportMode: return "Automatic improvements and hints"
        case .FowlFortuneNeutralMode: return "No hints or suggestions"
        case .FowlFortuneSilentMode: return "Complete silence, no notifications"
        }
    }
}
