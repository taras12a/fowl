import Foundation

struct FowlFortuneQuizQuestion: Codable {
    let FowlFortuneQuestionID: String
    var FowlFortuneQuestionText: String
    var FowlFortuneQuestionOptions: [String]
    var FowlFortuneCorrectAnswerIndex: Int
    var FowlFortuneQuestionExplanation: String
    var FowlFortuneQuestionCategory: FowlFortuneQuizCategory
    var FowlFortuneQuestionDifficulty: FowlFortuneQuizDifficulty
}

enum FowlFortuneQuizCategory: String, CaseIterable, Codable {
    case FowlFortuneGeneralKnowledge = "General Knowledge"
    case FowlFortuneChickenBehavior = "Chicken Behavior"
    case FowlFortuneCareAndHealth = "Care & Health"
    case FowlFortuneBreeding = "Breeding"
    case FowlFortuneHistory = "History"
    
    var FowlFortuneCategoryEmoji: String {
        switch self {
        case .FowlFortuneGeneralKnowledge: return "🧠"
        case .FowlFortuneChickenBehavior: return "🎭"
        case .FowlFortuneCareAndHealth: return "💊"
        case .FowlFortuneBreeding: return "🥚"
        case .FowlFortuneHistory: return "📚"
        }
    }
}

enum FowlFortuneQuizDifficulty: String, CaseIterable, Codable {
    case FowlFortuneEasy = "Easy"
    case FowlFortuneMedium = "Medium"
    case FowlFortuneHard = "Hard"
    
    var FowlFortuneDifficultyEmoji: String {
        switch self {
        case .FowlFortuneEasy: return "🟢"
        case .FowlFortuneMedium: return "🟡"
        case .FowlFortuneHard: return "🔴"
        }
    }
    
    var FowlFortuneExperienceReward: Int {
        switch self {
        case .FowlFortuneEasy: return 10
        case .FowlFortuneMedium: return 20
        case .FowlFortuneHard: return 30
        }
    }
}

struct FowlFortuneQuizSession: Codable {
    var FowlFortuneQuestions: [FowlFortuneQuizQuestion]
    var FowlFortuneCurrentQuestionIndex: Int = 0
    var FowlFortuneUserAnswers: [Int] = []
    var FowlFortuneStartTime: Date = Date()
    var FowlFortuneEndTime: Date?
    var FowlFortuneIsCompleted: Bool = false
    
    var FowlFortuneCurrentQuestion: FowlFortuneQuizQuestion? {
        guard FowlFortuneCurrentQuestionIndex < FowlFortuneQuestions.count else { return nil }
        return FowlFortuneQuestions[FowlFortuneCurrentQuestionIndex]
    }
    
    var FowlFortuneTotalQuestions: Int {
        return FowlFortuneQuestions.count
    }
    
    var FowlFortuneCorrectAnswers: Int {
        return FowlFortuneUserAnswers.enumerated().reduce(0) { count, answer in
            let (index, userAnswer) = answer
            if index < FowlFortuneQuestions.count {
                return count + (userAnswer == FowlFortuneQuestions[index].FowlFortuneCorrectAnswerIndex ? 1 : 0)
            }
            return count
        }
    }
    
    var FowlFortuneIncorrectAnswers: Int {
        return FowlFortuneTotalQuestions - FowlFortuneCorrectAnswers
    }
    
    var FowlFortuneScore: Double {
        guard FowlFortuneTotalQuestions > 0 else { return 0.0 }
        return Double(FowlFortuneCorrectAnswers) / Double(FowlFortuneTotalQuestions) * 100.0
    }
    
    var FowlFortuneTotalExperience: Int {
        return FowlFortuneQuestions.reduce(0) { total, question in
            total + question.FowlFortuneQuestionDifficulty.FowlFortuneExperienceReward
        }
    }
    
    var FowlFortuneEarnedExperience: Int {
        let FowlFortuneCorrectAnswers = FowlFortuneCorrectAnswers
        let FowlFortuneBaseExperience = FowlFortuneTotalExperience / FowlFortuneTotalQuestions
        return FowlFortuneCorrectAnswers * FowlFortuneBaseExperience
    }
    
    var FowlFortuneEarnedCredits: Int {
        return FowlFortuneCorrectAnswers * 5
    }
    
    var FowlFortuneTimeSpent: TimeInterval {
        guard let endTime = FowlFortuneEndTime else {
            return Date().timeIntervalSince(FowlFortuneStartTime)
        }
        return endTime.timeIntervalSince(FowlFortuneStartTime)
    }
}

struct FowlFortuneQuizData {
    static func FowlFortuneGetAllQuestions() -> [FowlFortuneQuizQuestion] {
        return [
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q001",
                FowlFortuneQuestionText: "How many eggs can a healthy hen lay per year?",
                FowlFortuneQuestionOptions: ["100-150", "200-300", "400-500", "50-75"],
                FowlFortuneCorrectAnswerIndex: 1,
                FowlFortuneQuestionExplanation: "A healthy hen can lay approximately 200-300 eggs per year, depending on the breed and care.",
                FowlFortuneQuestionCategory: .FowlFortuneGeneralKnowledge,
                FowlFortuneQuestionDifficulty: .FowlFortuneEasy
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q002",
                FowlFortuneQuestionText: "What is the pecking order in chickens?",
                FowlFortuneQuestionOptions: ["The order they eat", "A social hierarchy system", "Their sleeping arrangement", "Their nesting preferences"],
                FowlFortuneCorrectAnswerIndex: 1,
                FowlFortuneQuestionExplanation: "The pecking order is a social hierarchy that determines access to food, water, and roosting spots.",
                FowlFortuneQuestionCategory: .FowlFortuneChickenBehavior,
                FowlFortuneQuestionDifficulty: .FowlFortuneMedium
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q003",
                FowlFortuneQuestionText: "How long does it take for a chicken egg to hatch?",
                FowlFortuneQuestionOptions: ["14 days", "21 days", "28 days", "35 days"],
                FowlFortuneCorrectAnswerIndex: 1,
                FowlFortuneQuestionExplanation: "Chicken eggs typically take 21 days to hatch under proper incubation conditions.",
                FowlFortuneQuestionCategory: .FowlFortuneBreeding,
                FowlFortuneQuestionDifficulty: .FowlFortuneEasy
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q004",
                FowlFortuneQuestionText: "What is the scientific name for domestic chickens?",
                FowlFortuneQuestionOptions: ["Gallus gallus domesticus", "Gallus domesticus", "Gallus gallus", "Gallus bankiva"],
                FowlFortuneCorrectAnswerIndex: 0,
                FowlFortuneQuestionExplanation: "The scientific name for domestic chickens is Gallus gallus domesticus.",
                FowlFortuneQuestionCategory: .FowlFortuneGeneralKnowledge,
                FowlFortuneQuestionDifficulty: .FowlFortuneMedium
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q005",
                FowlFortuneQuestionText: "What temperature is ideal for chicken coops?",
                FowlFortuneQuestionOptions: ["50-60°F", "60-70°F", "70-80°F", "80-90°F"],
                FowlFortuneCorrectAnswerIndex: 1,
                FowlFortuneQuestionExplanation: "The ideal temperature for chicken coops is between 60-70°F (15-21°C).",
                FowlFortuneQuestionCategory: .FowlFortuneCareAndHealth,
                FowlFortuneQuestionDifficulty: .FowlFortuneMedium
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q006",
                FowlFortuneQuestionText: "How many different vocalizations can chickens make?",
                FowlFortuneQuestionOptions: ["5-10", "15-20", "25-30", "40-50"],
                FowlFortuneCorrectAnswerIndex: 2,
                FowlFortuneQuestionExplanation: "Chickens can make over 30 different vocalizations to communicate with each other.",
                FowlFortuneQuestionCategory: .FowlFortuneChickenBehavior,
                FowlFortuneQuestionDifficulty: .FowlFortuneHard
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q007",
                FowlFortuneQuestionText: "When were chickens first domesticated?",
                FowlFortuneQuestionOptions: ["2000 years ago", "5000 years ago", "8000 years ago", "12000 years ago"],
                FowlFortuneCorrectAnswerIndex: 2,
                FowlFortuneQuestionExplanation: "Chickens were first domesticated over 8000 years ago in Southeast Asia.",
                FowlFortuneQuestionCategory: .FowlFortuneHistory,
                FowlFortuneQuestionDifficulty: .FowlFortuneHard
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q008",
                FowlFortuneQuestionText: "What do chickens use dust baths for?",
                FowlFortuneQuestionOptions: ["Cooling down", "Cleaning feathers", "Social bonding", "All of the above"],
                FowlFortuneCorrectAnswerIndex: 3,
                FowlFortuneQuestionExplanation: "Dust baths help chickens clean their feathers, regulate temperature, and provide social interaction.",
                FowlFortuneQuestionCategory: .FowlFortuneCareAndHealth,
                FowlFortuneQuestionDifficulty: .FowlFortuneMedium
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q009",
                FowlFortuneQuestionText: "How long do chickens typically live?",
                FowlFortuneQuestionOptions: ["2-3 years", "5-10 years", "10-15 years", "15-20 years"],
                FowlFortuneCorrectAnswerIndex: 1,
                FowlFortuneQuestionExplanation: "With proper care, chickens typically live 5-10 years, though some can live longer.",
                FowlFortuneQuestionCategory: .FowlFortuneGeneralKnowledge,
                FowlFortuneQuestionDifficulty: .FowlFortuneEasy
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q010",
                FowlFortuneQuestionText: "What is molting in chickens?",
                FowlFortuneQuestionOptions: ["Growing new feathers", "Laying eggs", "Building nests", "Eating more food"],
                FowlFortuneCorrectAnswerIndex: 0,
                FowlFortuneQuestionExplanation: "Molting is the process where chickens shed old feathers and grow new ones, usually once a year.",
                FowlFortuneQuestionCategory: .FowlFortuneCareAndHealth,
                FowlFortuneQuestionDifficulty: .FowlFortuneMedium
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q011",
                FowlFortuneQuestionText: "Can chickens see in color?",
                FowlFortuneQuestionOptions: ["No, only black and white", "Yes, but limited colors", "Yes, full color vision", "Only red and blue"],
                FowlFortuneCorrectAnswerIndex: 2,
                FowlFortuneQuestionExplanation: "Chickens have excellent color vision and can even see ultraviolet light that humans cannot.",
                FowlFortuneQuestionCategory: .FowlFortuneGeneralKnowledge,
                FowlFortuneQuestionDifficulty: .FowlFortuneMedium
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q012",
                FowlFortuneQuestionText: "What is the purpose of a roost in a chicken coop?",
                FowlFortuneQuestionOptions: ["For laying eggs", "For sleeping at night", "For feeding", "For dust bathing"],
                FowlFortuneCorrectAnswerIndex: 1,
                FowlFortuneQuestionExplanation: "Roosts are elevated perches where chickens sleep at night, providing safety from ground predators.",
                FowlFortuneQuestionCategory: .FowlFortuneCareAndHealth,
                FowlFortuneQuestionDifficulty: .FowlFortuneEasy
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q013",
                FowlFortuneQuestionText: "How many toes do most chickens have?",
                FowlFortuneQuestionOptions: ["3", "4", "5", "6"],
                FowlFortuneCorrectAnswerIndex: 1,
                FowlFortuneQuestionExplanation: "Most chicken breeds have 4 toes on each foot, though some breeds like the Dorking have 5.",
                FowlFortuneQuestionCategory: .FowlFortuneGeneralKnowledge,
                FowlFortuneQuestionDifficulty: .FowlFortuneHard
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q014",
                FowlFortuneQuestionText: "What is the red fleshy growth on top of a chicken's head called?",
                FowlFortuneQuestionOptions: ["Crest", "Comb", "Crown", "Cap"],
                FowlFortuneCorrectAnswerIndex: 1,
                FowlFortuneQuestionExplanation: "The comb is the red fleshy growth on top of a chicken's head, used for temperature regulation.",
                FowlFortuneQuestionCategory: .FowlFortuneGeneralKnowledge,
                FowlFortuneQuestionDifficulty: .FowlFortuneMedium
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q015",
                FowlFortuneQuestionText: "Do chickens need a rooster to lay eggs?",
                FowlFortuneQuestionOptions: ["Yes, always", "No, never", "Only for fertilized eggs", "Only in certain seasons"],
                FowlFortuneCorrectAnswerIndex: 2,
                FowlFortuneQuestionExplanation: "Hens can lay eggs without a rooster, but eggs will only be fertilized if a rooster is present.",
                FowlFortuneQuestionCategory: .FowlFortuneBreeding,
                FowlFortuneQuestionDifficulty: .FowlFortuneEasy
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q016",
                FowlFortuneQuestionText: "What is the best age to start laying eggs?",
                FowlFortuneQuestionOptions: ["3-4 months", "5-6 months", "8-9 months", "12 months"],
                FowlFortuneCorrectAnswerIndex: 1,
                FowlFortuneQuestionExplanation: "Most hens start laying eggs at 5-6 months of age, though this can vary by breed.",
                FowlFortuneQuestionCategory: .FowlFortuneBreeding,
                FowlFortuneQuestionDifficulty: .FowlFortuneMedium
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q017",
                FowlFortuneQuestionText: "What is the purpose of wattles on chickens?",
                FowlFortuneQuestionOptions: ["Attracting mates", "Temperature regulation", "Communication", "All of the above"],
                FowlFortuneCorrectAnswerIndex: 3,
                FowlFortuneQuestionExplanation: "Wattles serve multiple purposes including temperature regulation, attracting mates, and communication.",
                FowlFortuneQuestionCategory: .FowlFortuneGeneralKnowledge,
                FowlFortuneQuestionDifficulty: .FowlFortuneHard
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q018",
                FowlFortuneQuestionText: "How much space does each chicken need in a coop?",
                FowlFortuneQuestionOptions: ["1-2 square feet", "2-3 square feet", "4-5 square feet", "6-8 square feet"],
                FowlFortuneCorrectAnswerIndex: 1,
                FowlFortuneQuestionExplanation: "Each chicken needs approximately 2-3 square feet of space inside the coop.",
                FowlFortuneQuestionCategory: .FowlFortuneCareAndHealth,
                FowlFortuneQuestionDifficulty: .FowlFortuneMedium
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q019",
                FowlFortuneQuestionText: "What is the largest chicken breed?",
                FowlFortuneQuestionOptions: ["Rhode Island Red", "Leghorn", "Brahma", "Orpington"],
                FowlFortuneCorrectAnswerIndex: 2,
                FowlFortuneQuestionExplanation: "The Brahma is one of the largest chicken breeds, with roosters weighing up to 12 pounds.",
                FowlFortuneQuestionCategory: .FowlFortuneGeneralKnowledge,
                FowlFortuneQuestionDifficulty: .FowlFortuneHard
            ),
            
            FowlFortuneQuizQuestion(
                FowlFortuneQuestionID: "q020",
                FowlFortuneQuestionText: "What happens to egg production during molting?",
                FowlFortuneQuestionOptions: ["Increases", "Stays the same", "Decreases or stops", "Becomes irregular"],
                FowlFortuneCorrectAnswerIndex: 2,
                FowlFortuneQuestionExplanation: "Egg production typically decreases or stops during molting as the hen's energy focuses on growing new feathers.",
                FowlFortuneQuestionCategory: .FowlFortuneCareAndHealth,
                FowlFortuneQuestionDifficulty: .FowlFortuneMedium
            )
        ]
    }
}
