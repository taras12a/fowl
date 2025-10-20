import Foundation

class FowlFortuneFactsViewModel {
    
    private var FowlFortuneAllFacts: [FowlFortuneChickenFact]
    private var FowlFortuneCurrentFacts: [FowlFortuneChickenFact]
    private var FowlFortuneSelectedCategory: FowlFortuneFactCategory?
    
    var FowlFortuneFactsUpdateCallback: (() -> Void)?
    
    init() {
        FowlFortuneAllFacts = FowlFortuneFactsData.FowlFortuneGetAllFacts()
        FowlFortuneCurrentFacts = FowlFortuneAllFacts
        FowlFortuneSelectedCategory = nil
    }
    
    func FowlFortuneGetAllFacts() -> [FowlFortuneChickenFact] {
        return FowlFortuneCurrentFacts
    }
    
    func FowlFortuneGetFactByID(_ FowlFortuneFactID: String) -> FowlFortuneChickenFact? {
        return FowlFortuneAllFacts.first { $0.FowlFortuneFactID == FowlFortuneFactID }
    }
    
    func FowlFortuneGetCategories() -> [FowlFortuneFactCategory] {
        return FowlFortuneFactCategory.allCases
    }
    
    func FowlFortuneGetSelectedCategory() -> FowlFortuneFactCategory? {
        return FowlFortuneSelectedCategory
    }
    
    func FowlFortuneFilterByCategory(_ FowlFortuneCategory: FowlFortuneFactCategory?) {
        FowlFortuneSelectedCategory = FowlFortuneCategory
        
        if let FowlFortuneCategory = FowlFortuneCategory {
            FowlFortuneCurrentFacts = FowlFortuneAllFacts.filter { $0.FowlFortuneFactCategory == FowlFortuneCategory }
        } else {
            FowlFortuneCurrentFacts = FowlFortuneAllFacts
        }
        
        FowlFortuneFactsUpdateCallback?()
    }
    
    func FowlFortuneGetRandomFact() -> FowlFortuneChickenFact? {
        return FowlFortuneAllFacts.randomElement()
    }
    
    func FowlFortuneGetFactCount() -> Int {
        return FowlFortuneCurrentFacts.count
    }
    
    func FowlFortuneGetTotalFactCount() -> Int {
        return FowlFortuneAllFacts.count
    }
    
    func FowlFortuneSearchFacts(_ FowlFortuneSearchText: String) {
        if FowlFortuneSearchText.isEmpty {
            if let FowlFortuneCategory = FowlFortuneSelectedCategory {
                FowlFortuneCurrentFacts = FowlFortuneAllFacts.filter { $0.FowlFortuneFactCategory == FowlFortuneCategory }
            } else {
                FowlFortuneCurrentFacts = FowlFortuneAllFacts
            }
        } else {
            let FowlFortuneLowercasedSearch = FowlFortuneSearchText.lowercased()
            FowlFortuneCurrentFacts = FowlFortuneAllFacts.filter { fact in
                let FowlFortuneMatchesCategory = FowlFortuneSelectedCategory == nil || fact.FowlFortuneFactCategory == FowlFortuneSelectedCategory
                let FowlFortuneMatchesSearch = fact.FowlFortuneFactTitle.lowercased().contains(FowlFortuneLowercasedSearch) ||
                                             fact.FowlFortuneFactShortDescription.lowercased().contains(FowlFortuneLowercasedSearch) ||
                                             fact.FowlFortuneFactDetailedInfo.lowercased().contains(FowlFortuneLowercasedSearch)
                return FowlFortuneMatchesCategory && FowlFortuneMatchesSearch
            }
        }
        
        FowlFortuneFactsUpdateCallback?()
    }
    
    func FowlFortuneGetCategoryCount(_ FowlFortuneCategory: FowlFortuneFactCategory) -> Int {
        return FowlFortuneAllFacts.filter { $0.FowlFortuneFactCategory == FowlFortuneCategory }.count
    }
    
    func FowlFortuneGetFactsForCategory(_ FowlFortuneCategory: FowlFortuneFactCategory) -> [FowlFortuneChickenFact] {
        return FowlFortuneAllFacts.filter { $0.FowlFortuneFactCategory == FowlFortuneCategory }
    }
}
