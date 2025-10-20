import Foundation
import UIKit

struct FowlFortuneOnboardingPage {
    let FowlFortunePageID: String
    let FowlFortunePageTitle: String
    let FowlFortunePageDescription: String
    let FowlFortunePageEmoji: String
    let FowlFortunePageBackgroundEmojis: [String]
    let FowlFortunePageColor: UIColor
}

struct FowlFortuneOnboardingData {
    static let FowlFortuneOnboardingPages: [FowlFortuneOnboardingPage] = [
        FowlFortuneOnboardingPage(
            FowlFortunePageID: "welcome",
            FowlFortunePageTitle: "Welcome to FowlFortune! 🐔",
            FowlFortunePageDescription: "Welcome to the most exciting chicken farm simulation game! Build your dream farm, manage your flock, and become the ultimate poultry tycoon.",
            FowlFortunePageEmoji: "🐔",
            FowlFortunePageBackgroundEmojis: ["🌾", "🥚", "🐓", "🌻", "🪺"],
            FowlFortunePageColor: UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        ),
        FowlFortuneOnboardingPage(
            FowlFortunePageID: "buildings",
            FowlFortunePageTitle: "Build Your Empire 🏗️",
            FowlFortunePageDescription: "Construct various buildings like coops, warehouses, and defense towers. Each building generates passive income and provides unique benefits to your farm.",
            FowlFortunePageEmoji: "🏠",
            FowlFortunePageBackgroundEmojis: ["🏢", "🛡️", "🥚", "🏗️", "⚡"],
            FowlFortunePageColor: UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0)
        ),
        FowlFortuneOnboardingPage(
            FowlFortunePageID: "chickens",
            FowlFortunePageTitle: "Manage Your Flock 🐣",
            FowlFortunePageDescription: "Feed, care for, and breed different types of chickens. Each chicken type has unique characteristics and egg production rates.",
            FowlFortunePageEmoji: "🐣",
            FowlFortunePageBackgroundEmojis: ["🐔", "🐓", "🌾", "🥚", "❤️"],
            FowlFortunePageColor: UIColor(red: 0.95, green: 0.90, blue: 0.95, alpha: 1.0)
        ),
        FowlFortuneOnboardingPage(
            FowlFortunePageID: "defense",
            FowlFortunePageTitle: "Defend Your Farm 🛡️",
            FowlFortunePageDescription: "Protect your precious chickens from predators like foxes and sparrows. Build defenses and upgrade your protection systems.",
            FowlFortunePageEmoji: "🛡️",
            FowlFortunePageBackgroundEmojis: ["🐺", "🦅", "🚧", "⚔️", "🏰"],
            FowlFortunePageColor: UIColor(red: 0.90, green: 0.90, blue: 0.95, alpha: 1.0)
        ),
        FowlFortuneOnboardingPage(
            FowlFortunePageID: "success",
            FowlFortunePageTitle: "Achieve Greatness! 🏆",
            FowlFortunePageDescription: "Earn achievements, unlock upgrades, and test your knowledge with our quiz system. Become the ultimate chicken farm master!",
            FowlFortunePageEmoji: "🏆",
            FowlFortunePageBackgroundEmojis: ["⭐", "💎", "🎯", "🧠", "✨"],
            FowlFortunePageColor: UIColor(red: 0.95, green: 0.95, blue: 0.90, alpha: 1.0)
        )
    ]
}

enum FowlFortuneOnboardingState {
    case FowlFortuneNotStarted
    case FowlFortuneInProgress
    case FowlFortuneCompleted
}
