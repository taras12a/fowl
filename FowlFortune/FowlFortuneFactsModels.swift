import Foundation

struct FowlFortuneChickenFact: Codable {
    let FowlFortuneFactID: String
    var FowlFortuneFactTitle: String
    var FowlFortuneFactShortDescription: String
    var FowlFortuneFactEmoji: String
    var FowlFortuneFactCategory: FowlFortuneFactCategory
    var FowlFortuneFactDetailedInfo: String
    var FowlFortuneFactFunFacts: [String]
    var FowlFortuneFactScientificName: String
    var FowlFortuneFactOrigin: String
    var FowlFortuneFactLifespan: String
    var FowlFortuneFactEggProduction: String
    var FowlFortuneFactWeight: String
    var FowlFortuneFactTemperament: String
    var FowlFortuneFactSpecialFeatures: [String]
    var FowlFortuneFactCareTips: [String]
}

enum FowlFortuneFactCategory: String, CaseIterable, Codable {
    case FowlFortuneGeneralFacts = "General"
    case FowlFortuneBreedFacts = "Breed"
    case FowlFortuneBehaviorFacts = "Behavior"
    case FowlFortuneCareFacts = "Care"
    case FowlFortuneHistoryFacts = "History"
    
    var FowlFortuneCategoryEmoji: String {
        switch self {
        case .FowlFortuneGeneralFacts: return "🐔"
        case .FowlFortuneBreedFacts: return "🏆"
        case .FowlFortuneBehaviorFacts: return "🎭"
        case .FowlFortuneCareFacts: return "💊"
        case .FowlFortuneHistoryFacts: return "📚"
        }
    }
    
    var FowlFortuneCategoryName: String {
        switch self {
        case .FowlFortuneGeneralFacts: return "General Facts"
        case .FowlFortuneBreedFacts: return "Breed Info"
        case .FowlFortuneBehaviorFacts: return "Behavior"
        case .FowlFortuneCareFacts: return "Care Tips"
        case .FowlFortuneHistoryFacts: return "History"
        }
    }
}

struct FowlFortuneFactsData {
    static func FowlFortuneGetAllFacts() -> [FowlFortuneChickenFact] {
        return [
            FowlFortuneChickenFact(
                FowlFortuneFactID: "fact_001",
                FowlFortuneFactTitle: "Chicken Intelligence",
                FowlFortuneFactShortDescription: "Chickens are smarter than you think! They can recognize up to 100 different faces.",
                FowlFortuneFactEmoji: "🧠",
                FowlFortuneFactCategory: .FowlFortuneGeneralFacts,
                FowlFortuneFactDetailedInfo: "Chickens possess remarkable cognitive abilities that often surprise people. Research has shown that chickens can distinguish between more than 100 faces of people or animals and remember them for several months. They can also understand cause and effect relationships, demonstrate self-control, and even show empathy towards other chickens in distress.",
                FowlFortuneFactFunFacts: [
                    "Chickens can solve complex puzzles",
                    "They dream during REM sleep like humans",
                    "Chickens can count up to five",
                    "They have excellent memory and can remember routes"
                ],
                FowlFortuneFactScientificName: "Gallus gallus domesticus",
                FowlFortuneFactOrigin: "Southeast Asia, domesticated 8000+ years ago",
                FowlFortuneFactLifespan: "5-10 years (depending on breed and care)",
                FowlFortuneFactEggProduction: "200-300 eggs per year",
                FowlFortuneFactWeight: "3-8 lbs (1.4-3.6 kg)",
                FowlFortuneFactTemperament: "Social, curious, and surprisingly intelligent",
                FowlFortuneFactSpecialFeatures: [
                    "Excellent color vision",
                    "Can see ultraviolet light",
                    "Strong spatial awareness",
                    "Complex communication system"
                ],
                FowlFortuneFactCareTips: [
                    "Provide mental stimulation with puzzles",
                    "Allow free-range time for exploration",
                    "Social interaction is crucial",
                    "Varied diet keeps them engaged"
                ]
            ),
            
            FowlFortuneChickenFact(
                FowlFortuneFactID: "fact_002",
                FowlFortuneFactTitle: "Egg Production Wonders",
                FowlFortuneFactShortDescription: "A hen can lay up to 300 eggs per year, but it takes 24-26 hours to form each egg!",
                FowlFortuneFactEmoji: "🥚",
                FowlFortuneFactCategory: .FowlFortuneGeneralFacts,
                FowlFortuneFactDetailedInfo: "The egg-laying process in chickens is a fascinating biological marvel. It takes approximately 24-26 hours for a hen to produce a single egg, with most of this time spent forming the eggshell from calcium carbonate. The process begins with the yolk formation in the hen's ovary and continues through the oviduct where the white and shell are added.",
                FowlFortuneFactFunFacts: [
                    "Hens can lay eggs without a rooster",
                    "Egg color depends on the breed",
                    "Chickens can lay eggs for 2-3 years",
                    "Some hens lay double-yolked eggs"
                ],
                FowlFortuneFactScientificName: "Gallus gallus domesticus",
                FowlFortuneFactOrigin: "Domesticated from wild red junglefowl",
                FowlFortuneFactLifespan: "5-8 years productive laying",
                FowlFortuneFactEggProduction: "250-300 eggs per year peak production",
                FowlFortuneFactWeight: "4-6 lbs average",
                FowlFortuneFactTemperament: "Calm and productive",
                FowlFortuneFactSpecialFeatures: [
                    "Efficient calcium metabolism",
                    "Consistent laying cycles",
                    "Adaptable to various climates",
                    "Strong maternal instincts"
                ],
                FowlFortuneFactCareTips: [
                    "Provide calcium-rich feed",
                    "Ensure 14+ hours of light for optimal laying",
                    "Keep nesting boxes clean and comfortable",
                    "Monitor for signs of egg binding"
                ]
            ),
            
            FowlFortuneChickenFact(
                FowlFortuneFactID: "fact_003",
                FowlFortuneFactTitle: "Chicken Communication",
                FowlFortuneFactShortDescription: "Chickens have over 30 different vocalizations to communicate with each other!",
                FowlFortuneFactEmoji: "🗣️",
                FowlFortuneFactCategory: .FowlFortuneBehaviorFacts,
                FowlFortuneFactDetailedInfo: "Chickens have a sophisticated communication system with over 30 distinct vocalizations. Each sound has a specific meaning, from warning calls about predators to contented clucking while foraging. Mother hens even 'talk' to their chicks while they're still in the egg, and the chicks respond with peeps from inside their shells.",
                FowlFortuneFactFunFacts: [
                    "Chicks respond to mother's voice from inside the egg",
                    "Different alarm calls for different threats",
                    "Chickens can recognize their owner's voice",
                    "They use body language extensively"
                ],
                FowlFortuneFactScientificName: "Gallus gallus domesticus",
                FowlFortuneFactOrigin: "Evolved from junglefowl communication",
                FowlFortuneFactLifespan: "5-10 years",
                FowlFortuneFactEggProduction: "Varies by breed",
                FowlFortuneFactWeight: "3-8 lbs",
                FowlFortuneFactTemperament: "Highly social and communicative",
                FowlFortuneFactSpecialFeatures: [
                    "Complex vocal repertoire",
                    "Body language communication",
                    "Alarm system for flock protection",
                    "Maternal communication with chicks"
                ],
                FowlFortuneFactCareTips: [
                    "Learn to recognize their different calls",
                    "Provide quiet areas for nesting",
                    "Avoid sudden loud noises",
                    "Spend time talking to your chickens"
                ]
            ),
            
            FowlFortuneChickenFact(
                FowlFortuneFactID: "fact_004",
                FowlFortuneFactTitle: "Feather Colors & Patterns",
                FowlFortuneFactShortDescription: "Chicken feathers come in over 60 different colors and patterns, from solid black to speckled!",
                FowlFortuneFactEmoji: "🎨",
                FowlFortuneFactCategory: .FowlFortuneBreedFacts,
                FowlFortuneFactDetailedInfo: "The diversity of chicken feather colors and patterns is truly remarkable. From the glossy black feathers of the Ayam Cemani to the golden laced feathers of the Wyandotte, chickens display an incredible variety of colors and patterns. These variations are controlled by multiple genes and have been selectively bred over thousands of years.",
                FowlFortuneFactFunFacts: [
                    "Some breeds change color as they molt",
                    "Feather patterns can indicate breed purity",
                    "Chickens can have iridescent feathers",
                    "Feather color affects heat absorption"
                ],
                FowlFortuneFactScientificName: "Gallus gallus domesticus",
                FowlFortuneFactOrigin: "Selective breeding over 8000 years",
                FowlFortuneFactLifespan: "5-10 years",
                FowlFortuneFactEggProduction: "Varies by breed",
                FowlFortuneFactWeight: "2-15 lbs depending on breed",
                FowlFortuneFactTemperament: "Varies by breed and individual",
                FowlFortuneFactSpecialFeatures: [
                    "Over 60 documented color variations",
                    "Seasonal molting patterns",
                    "Breed-specific feather structures",
                    "Weather-resistant feather types"
                ],
                FowlFortuneFactCareTips: [
                    "Provide dust baths for feather health",
                    "Protect from extreme weather during molting",
                    "Regular health checks for feather condition",
                    "Proper nutrition for healthy feather growth"
                ]
            ),
            
            FowlFortuneChickenFact(
                FowlFortuneFactID: "fact_005",
                FowlFortuneFactTitle: "Social Hierarchy",
                FowlFortuneFactShortDescription: "Chickens establish a strict pecking order that determines who eats first and where they sleep!",
                FowlFortuneFactEmoji: "👑",
                FowlFortuneFactCategory: .FowlFortuneBehaviorFacts,
                FowlFortuneFactDetailedInfo: "The pecking order is a complex social hierarchy that chickens establish to maintain order within their flock. This system determines access to food, water, nesting sites, and roosting spots. The hierarchy is established through displays of dominance and submission, and once established, it helps reduce conflict within the flock.",
                FowlFortuneFactFunFacts: [
                    "New chickens must find their place in the order",
                    "The hierarchy can change over time",
                    "Chickens remember who's above and below them",
                    "Roosters usually rank higher than hens"
                ],
                FowlFortuneFactScientificName: "Gallus gallus domesticus",
                FowlFortuneFactOrigin: "Evolved for flock survival",
                FowlFortuneFactLifespan: "5-10 years",
                FowlFortuneFactEggProduction: "Affected by stress from hierarchy",
                FowlFortuneFactWeight: "Size often affects rank",
                FowlFortuneFactTemperament: "Social but hierarchical",
                FowlFortuneFactSpecialFeatures: [
                    "Complex dominance displays",
                    "Memory of social relationships",
                    "Adaptable hierarchy system",
                    "Conflict resolution behaviors"
                ],
                FowlFortuneFactCareTips: [
                    "Introduce new chickens gradually",
                    "Provide multiple feeding stations",
                    "Ensure adequate space per chicken",
                    "Monitor for bullying behaviors"
                ]
            ),
            
            FowlFortuneChickenFact(
                FowlFortuneFactID: "fact_006",
                FowlFortuneFactTitle: "Ancient Domestication",
                FowlFortuneFactShortDescription: "Chickens were first domesticated over 8,000 years ago in Southeast Asia from wild junglefowl!",
                FowlFortuneFactEmoji: "🏛️",
                FowlFortuneFactCategory: .FowlFortuneHistoryFacts,
                FowlFortuneFactDetailedInfo: "The domestication of chickens began over 8,000 years ago in Southeast Asia, where wild red junglefowl were first tamed by humans. This makes chickens one of the earliest domesticated animals, alongside dogs and goats. The process of domestication changed both the behavior and physical characteristics of these birds, making them more suitable for human companionship and agriculture.",
                FowlFortuneFactFunFacts: [
                    "Chickens were originally kept for cockfighting",
                    "Egg production became important later",
                    "Ancient Egyptians kept chickens as pets",
                    "Chickens spread worldwide through trade routes"
                ],
                FowlFortuneFactScientificName: "Gallus gallus domesticus",
                FowlFortuneFactOrigin: "Southeast Asia, 6000+ BCE",
                FowlFortuneFactLifespan: "Varies by historical period",
                FowlFortuneFactEggProduction: "Improved through selective breeding",
                FowlFortuneFactWeight: "Increased from wild ancestors",
                FowlFortuneFactTemperament: "Became more docile through domestication",
                FowlFortuneFactSpecialFeatures: [
                    "Retained wild instincts",
                    "Adaptable to various climates",
                    "Strong foraging abilities",
                    "Natural predator awareness"
                ],
                FowlFortuneFactCareTips: [
                    "Respect their natural behaviors",
                    "Provide opportunities for foraging",
                    "Maintain natural light cycles",
                    "Allow for natural social interactions"
                ]
            ),
            
            FowlFortuneChickenFact(
                FowlFortuneFactID: "fact_007",
                FowlFortuneFactTitle: "Temperature Regulation",
                FowlFortuneFactShortDescription: "Chickens can't sweat, so they pant and hold their wings away from their body to cool down!",
                FowlFortuneFactEmoji: "🌡️",
                FowlFortuneFactCategory: .FowlFortuneCareFacts,
                FowlFortuneFactDetailedInfo: "Unlike mammals, chickens cannot sweat to regulate their body temperature. Instead, they use several clever methods to stay cool. They pant to increase air circulation through their respiratory system, hold their wings away from their body to increase air flow, and seek shade or water. In cold weather, they fluff their feathers to trap warm air close to their bodies.",
                FowlFortuneFactFunFacts: [
                    "Chickens can die from heat stroke",
                    "They prefer temperatures between 70-75°F",
                    "Chickens will drink more water in hot weather",
                    "Dust baths help with temperature regulation"
                ],
                FowlFortuneFactScientificName: "Gallus gallus domesticus",
                FowlFortuneFactOrigin: "Adapted from tropical ancestors",
                FowlFortuneFactLifespan: "Affected by temperature extremes",
                FowlFortuneFactEggProduction: "Decreases in extreme heat",
                FowlFortuneFactWeight: "Maintained through proper care",
                FowlFortuneFactTemperament: "Affected by temperature comfort",
                FowlFortuneFactSpecialFeatures: [
                    "Feather fluffing for insulation",
                    "Panting for cooling",
                    "Seeking shade behavior",
                    "Water wading for temperature control"
                ],
                FowlFortuneFactCareTips: [
                    "Provide shade in hot weather",
                    "Ensure fresh water is always available",
                    "Ventilate the coop properly",
                    "Monitor for signs of heat stress"
                ]
            ),
            
            FowlFortuneChickenFact(
                FowlFortuneFactID: "fact_008",
                FowlFortuneFactTitle: "Chicken Vision",
                FowlFortuneFactShortDescription: "Chickens can see in full color and even detect ultraviolet light that humans can't see!",
                FowlFortuneFactEmoji: "👁️",
                FowlFortuneFactCategory: .FowlFortuneGeneralFacts,
                FowlFortuneFactDetailedInfo: "Chickens have excellent vision with several remarkable abilities. They can see in full color, including ultraviolet light that is invisible to humans. This UV vision helps them find food, identify other chickens, and even see patterns on eggs. Their eyes are positioned on the sides of their head, giving them nearly 360-degree vision to spot predators.",
                FowlFortuneFactFunFacts: [
                    "Chickens have better color vision than humans",
                    "They can see UV patterns on other chickens",
                    "Each eye can focus independently",
                    "They can detect motion from great distances"
                ],
                FowlFortuneFactScientificName: "Gallus gallus domesticus",
                FowlFortuneFactOrigin: "Evolved for predator detection",
                FowlFortuneFactLifespan: "Vision remains sharp throughout life",
                FowlFortuneFactEggProduction: "Not directly affected by vision",
                FowlFortuneFactWeight: "Normal range",
                FowlFortuneFactTemperament: "Alert and observant",
                FowlFortuneFactSpecialFeatures: [
                    "360-degree field of vision",
                    "UV light detection capability",
                    "Superior color discrimination",
                    "Excellent motion detection"
                ],
                FowlFortuneFactCareTips: [
                    "Avoid sudden movements that startle them",
                    "Use their vision for training",
                    "Provide visual enrichment",
                    "Be aware of their keen predator detection"
                ]
            ),
            
            FowlFortuneChickenFact(
                FowlFortuneFactID: "fact_009",
                FowlFortuneFactTitle: "Molting Process",
                FowlFortuneFactShortDescription: "Chickens molt (lose and regrow feathers) once a year, usually in fall, and stop laying eggs during this time!",
                FowlFortuneFactEmoji: "🪶",
                FowlFortuneFactCategory: .FowlFortuneCareFacts,
                FowlFortuneFactDetailedInfo: "Molting is a natural process where chickens shed their old feathers and grow new ones. This typically happens once a year, usually in the fall, and can last 8-16 weeks. During molting, chickens redirect their energy and protein resources from egg production to feather growth, so they stop laying eggs. This is completely normal and healthy.",
                FowlFortuneFactFunFacts: [
                    "Molting is triggered by decreasing daylight",
                    "Some chickens molt faster than others",
                    "New feathers are called 'pin feathers'",
                    "Chickens may look scruffy during molting"
                ],
                FowlFortuneFactScientificName: "Gallus gallus domesticus",
                FowlFortuneFactOrigin: "Natural seasonal adaptation",
                FowlFortuneFactLifespan: "Occurs annually throughout life",
                FowlFortuneFactEggProduction: "Stops during molting period",
                FowlFortuneFactWeight: "May lose some weight during molting",
                FowlFortuneFactTemperament: "May be more irritable during molting",
                FowlFortuneFactSpecialFeatures: [
                    "Seasonal feather replacement",
                    "Energy redirection to feather growth",
                    "Natural light cycle response",
                    "Individual variation in timing"
                ],
                FowlFortuneFactCareTips: [
                    "Increase protein in their diet during molting",
                    "Don't handle chickens roughly during molting",
                    "Provide extra warmth if needed",
                    "Be patient - egg production will resume"
                ]
            ),
            
            FowlFortuneChickenFact(
                FowlFortuneFactID: "fact_010",
                FowlFortuneFactTitle: "Chicken Sleep Patterns",
                FowlFortuneFactShortDescription: "Chickens sleep standing up on roosts and can sleep with one eye open to watch for predators!",
                FowlFortuneFactEmoji: "😴",
                FowlFortuneFactCategory: .FowlFortuneBehaviorFacts,
                FowlFortuneFactDetailedInfo: "Chickens have unique sleep patterns and behaviors. They prefer to sleep on elevated roosts, standing up with their feet locked around the perch. This position helps protect them from ground predators. Chickens can also sleep with one eye open, allowing half of their brain to rest while the other half remains alert for danger. This is called unihemispheric sleep.",
                FowlFortuneFactFunFacts: [
                    "Chickens prefer the highest roost spots",
                    "They can sleep with one eye open",
                    "Sleep position helps regulate body temperature",
                    "Chickens dream during REM sleep"
                ],
                FowlFortuneFactScientificName: "Gallus gallus domesticus",
                FowlFortuneFactOrigin: "Evolved for predator avoidance",
                FowlFortuneFactLifespan: "Sleep quality affects overall health",
                FowlFortuneFactEggProduction: "Adequate sleep is important for laying",
                FowlFortuneFactWeight: "Normal range",
                FowlFortuneFactTemperament: "More alert when well-rested",
                FowlFortuneFactSpecialFeatures: [
                    "Unihemispheric sleep capability",
                    "Natural roosting instincts",
                    "Temperature regulation during sleep",
                    "REM sleep and dreaming"
                ],
                FowlFortuneFactCareTips: [
                    "Provide multiple roosting levels",
                    "Ensure roosts are secure and comfortable",
                    "Keep the coop dark at night",
                    "Allow natural sleep-wake cycles"
                ]
            )
        ]
    }
}
