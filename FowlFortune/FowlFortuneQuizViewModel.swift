import Foundation

class FowlFortuneQuizViewModel {
    
    private let FowlFortuneDataStorage = FowlFortuneDataManager.FowlFortuneShared
    private let FowlFortuneTrackerInstance = FowlFortuneAchievementTracker.FowlFortuneShared
    private var FowlFortuneAllQuestions: [FowlFortuneQuizQuestion]
    private var FowlFortuneCurrentSession: FowlFortuneQuizSession?
    private var FowlFortuneCurrentFarm: FowlFortuneFarm
    private var FowlFortuneCurrentStats: FowlFortuneGameStats
    
    var FowlFortuneQuizUpdateCallback: (() -> Void)?
    var FowlFortuneQuizCompletionCallback: ((FowlFortuneQuizSession) -> Void)?
    
    init() {
        FowlFortuneAllQuestions = FowlFortuneQuizData.FowlFortuneGetAllQuestions()
        FowlFortuneCurrentFarm = FowlFortuneDataStorage.FowlFortuneLoadFarm()
        FowlFortuneCurrentStats = FowlFortuneDataStorage.FowlFortuneLoadGameStats()
    }
    
    func FowlFortuneStartNewQuiz() -> FowlFortuneQuizSession {
        let FowlFortuneSelectedQuestions = FowlFortuneGetRandomQuestions(count: 10)
        
        FowlFortuneCurrentSession = FowlFortuneQuizSession(
            FowlFortuneQuestions: FowlFortuneSelectedQuestions,
            FowlFortuneCurrentQuestionIndex: 0,
            FowlFortuneUserAnswers: [],
            FowlFortuneStartTime: Date(),
            FowlFortuneEndTime: nil,
            FowlFortuneIsCompleted: false
        )
        
        return FowlFortuneCurrentSession!
    }
    
    private func FowlFortuneGetRandomQuestions(count: Int) -> [FowlFortuneQuizQuestion] {
        let FowlFortuneShuffledQuestions = FowlFortuneAllQuestions.shuffled()
        return Array(FowlFortuneShuffledQuestions.prefix(count))
    }
    
    func FowlFortuneGetCurrentQuestion() -> FowlFortuneQuizQuestion? {
        return FowlFortuneCurrentSession?.FowlFortuneCurrentQuestion
    }
    
    func FowlFortuneGetCurrentQuestionNumber() -> Int {
        guard let session = FowlFortuneCurrentSession else { return 0 }
        return session.FowlFortuneCurrentQuestionIndex + 1
    }
    
    func FowlFortuneGetTotalQuestions() -> Int {
        return FowlFortuneCurrentSession?.FowlFortuneTotalQuestions ?? 0
    }
    
    func FowlFortuneSubmitAnswer(_ FowlFortuneAnswerIndex: Int) -> Bool {
        guard var session = FowlFortuneCurrentSession else { return false }
        
        session.FowlFortuneUserAnswers.append(FowlFortuneAnswerIndex)
        session.FowlFortuneCurrentQuestionIndex += 1
        
        FowlFortuneCurrentSession = session
        
        if FowlFortuneIsQuizCompleted() {
            FowlFortuneCompleteQuiz()
            return true
        }
        
        FowlFortuneQuizUpdateCallback?()
        return false
    }
    
    func FowlFortuneIsQuizCompleted() -> Bool {
        guard let session = FowlFortuneCurrentSession else { return false }
        return session.FowlFortuneCurrentQuestionIndex >= session.FowlFortuneQuestions.count
    }
    
    private func FowlFortuneCompleteQuiz() {
        guard var session = FowlFortuneCurrentSession else { return }
        
        session.FowlFortuneEndTime = Date()
        session.FowlFortuneIsCompleted = true
        FowlFortuneCurrentSession = session
        
        FowlFortuneAwardRewards()
        FowlFortuneSaveProgress()
        
        FowlFortuneQuizCompletionCallback?(session)
    }
    
    private func FowlFortuneAwardRewards() {
        guard let session = FowlFortuneCurrentSession else { return }
        
        let FowlFortuneEarnedExperience = session.FowlFortuneEarnedExperience
        let FowlFortuneEarnedCredits = session.FowlFortuneEarnedCredits
        
        FowlFortuneCurrentFarm.FowlFortuneTotalCredits += FowlFortuneEarnedCredits
        FowlFortuneCurrentFarm.FowlFortuneExperience += FowlFortuneEarnedExperience
        
        FowlFortuneCurrentStats.FowlFortuneTotalCreditsEarned += FowlFortuneEarnedCredits
        
        FowlFortuneCheckLevelUp()
        FowlFortuneCheckAchievements()
    }
    
    private func FowlFortuneCheckLevelUp() {
        let FowlFortuneRequiredExperience = FowlFortuneCurrentFarm.FowlFortuneLevel * 100
        
        if FowlFortuneCurrentFarm.FowlFortuneExperience >= FowlFortuneRequiredExperience {
            FowlFortuneCurrentFarm.FowlFortuneLevel += 1
            FowlFortuneCurrentFarm.FowlFortuneExperience -= FowlFortuneRequiredExperience
        }
    }
    
    private func FowlFortuneCheckAchievements() {
        FowlFortuneTrackerInstance.FowlFortuneUpdateAllAchievements(
            FowlFortuneFarm: &FowlFortuneCurrentFarm,
            FowlFortuneStats: FowlFortuneCurrentStats
        )
    }
    
    private func FowlFortuneSaveProgress() {
        FowlFortuneDataStorage.FowlFortuneSaveFarm(FowlFortuneCurrentFarm)
        FowlFortuneDataStorage.FowlFortuneSaveGameStats(FowlFortuneCurrentStats)
    }
    
    func FowlFortuneGetCurrentSession() -> FowlFortuneQuizSession? {
        return FowlFortuneCurrentSession
    }
    
    func FowlFortuneResetQuiz() {
        FowlFortuneCurrentSession = nil
    }
    
    func FowlFortuneGetQuizProgress() -> Double {
        guard let session = FowlFortuneCurrentSession else { return 0.0 }
        return Double(session.FowlFortuneCurrentQuestionIndex) / Double(session.FowlFortuneTotalQuestions)
    }
    
    func FowlFortuneGetQuestionCategories() -> [FowlFortuneQuizCategory] {
        return FowlFortuneQuizCategory.allCases
    }
    
    func FowlFortuneGetQuestionDifficulties() -> [FowlFortuneQuizDifficulty] {
        return FowlFortuneQuizDifficulty.allCases
    }
    
    func FowlFortuneGetTotalQuestionsCount() -> Int {
        return FowlFortuneAllQuestions.count
    }
}
