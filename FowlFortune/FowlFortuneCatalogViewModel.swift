import Foundation

class FowlFortuneCatalogViewModel {
    
    private let FowlFortuneDataStorage = FowlFortuneDataManager.FowlFortuneShared
    private var FowlFortuneCurrentFarm: FowlFortuneFarm
    
    var FowlFortuneCatalogUpdateCallback: (() -> Void)?
    
    init() {
        FowlFortuneCurrentFarm = FowlFortuneDataStorage.FowlFortuneLoadFarm()
    }
    
    func FowlFortuneLoadCatalog() {
        FowlFortuneCurrentFarm = FowlFortuneDataStorage.FowlFortuneLoadFarm()
        FowlFortuneCatalogUpdateCallback?()
    }
    
    var FowlFortuneAvailableChickenTypes: [FowlFortuneChickenType] {
        return FowlFortuneChickenType.allCases
    }
    
    var FowlFortuneAvailableBuildingTypes: [FowlFortuneBuildingType] {
        return FowlFortuneBuildingType.allCases
    }
    
    var FowlFortuneOwnedChickens: [FowlFortuneChicken] {
        return FowlFortuneCurrentFarm.FowlFortuneChickens
    }
    
    var FowlFortuneOwnedBuildings: [FowlFortuneBuilding] {
        return FowlFortuneCurrentFarm.FowlFortuneBuildings
    }
    
    func FowlFortuneGetChickenCount(for FowlFortuneChickenType: FowlFortuneChickenType) -> Int {
        return FowlFortuneCurrentFarm.FowlFortuneChickens.filter { $0.FowlFortuneChickenType == FowlFortuneChickenType }.count
    }
    
    func FowlFortuneGetBuildingCount(for FowlFortuneBuildingType: FowlFortuneBuildingType) -> Int {
        return FowlFortuneCurrentFarm.FowlFortuneBuildings.filter { $0.FowlFortuneBuildingType == FowlFortuneBuildingType }.count
    }
    
    func FowlFortuneIsChickenOwned(_ FowlFortuneChickenType: FowlFortuneChickenType) -> Bool {
        return FowlFortuneGetChickenCount(for: FowlFortuneChickenType) > 0
    }
    
    func FowlFortuneIsBuildingOwned(_ FowlFortuneBuildingType: FowlFortuneBuildingType) -> Bool {
        return FowlFortuneGetBuildingCount(for: FowlFortuneBuildingType) > 0
    }
    
    func FowlFortuneGetChickenDetails(for FowlFortuneChickenType: FowlFortuneChickenType) -> FowlFortuneChickenDetails {
        let FowlFortuneOwnedCount = FowlFortuneGetChickenCount(for: FowlFortuneChickenType)
        
        return FowlFortuneChickenDetails(
            FowlFortuneChickenType: FowlFortuneChickenType,
            FowlFortuneOwnedCount: FowlFortuneOwnedCount,
            FowlFortuneCost: FowlFortuneChickenType.FowlFortuneChickenCost,
            FowlFortuneDescription: FowlFortuneGetChickenDescription(for: FowlFortuneChickenType)
        )
    }
    
    func FowlFortuneGetBuildingDetails(for FowlFortuneBuildingType: FowlFortuneBuildingType) -> FowlFortuneBuildingDetails {
        let FowlFortuneOwnedCount = FowlFortuneGetBuildingCount(for: FowlFortuneBuildingType)
        
        return FowlFortuneBuildingDetails(
            FowlFortuneBuildingType: FowlFortuneBuildingType,
            FowlFortuneOwnedCount: FowlFortuneOwnedCount,
            FowlFortuneCost: FowlFortuneBuildingType.FowlFortuneBuildingCost,
            FowlFortuneDescription: FowlFortuneGetBuildingDescription(for: FowlFortuneBuildingType)
        )
    }
    
    private func FowlFortuneGetChickenDescription(for FowlFortuneChickenType: FowlFortuneChickenType) -> String {
        switch FowlFortuneChickenType {
        case .FowlFortuneRegularChicken:
            return "A reliable chicken that produces eggs consistently. Great for beginners!"
        case .FowlFortuneGoldenChicken:
            return "A rare golden chicken that produces more valuable eggs and has higher happiness."
        case .FowlFortuneSpeedChicken:
            return "A fast chicken that produces eggs more frequently but requires more care."
        case .FowlFortuneHeavyChicken:
            return "A sturdy chicken that's resistant to predators and produces larger eggs."
        }
    }
    
    private func FowlFortuneGetBuildingDescription(for FowlFortuneBuildingType: FowlFortuneBuildingType) -> String {
        switch FowlFortuneBuildingType {
        case .FowlFortuneCoop:
            return "A comfortable home for your chickens. Increases their happiness and egg production."
        case .FowlFortuneWarehouse:
            return "Stores your eggs and resources safely. Provides protection from weather and theft."
        case .FowlFortuneDefense:
            return "Protects your farm from predators and intruders. Essential for farm security."
        case .FowlFortuneHatchery:
            return "Incubates eggs and helps breed new chickens. Increases your chicken population."
        }
    }
}

struct FowlFortuneChickenDetails {
    let FowlFortuneChickenType: FowlFortuneChickenType
    let FowlFortuneOwnedCount: Int
    let FowlFortuneCost: Int
    let FowlFortuneDescription: String
}

struct FowlFortuneBuildingDetails {
    let FowlFortuneBuildingType: FowlFortuneBuildingType
    let FowlFortuneOwnedCount: Int
    let FowlFortuneCost: Int
    let FowlFortuneDescription: String
}
