import UIKit

class FowlFortuneQuizResultsViewController: UIViewController {
    
    private var FowlFortuneQuizSession: FowlFortuneQuizSession?
    private var FowlFortuneScrollView: UIScrollView!
    private var FowlFortuneContentView: UIView!
    private var FowlFortuneHeaderView: UIView!
    private var FowlFortuneEmojiLabel: UILabel!
    private var FowlFortuneTitleLabel: UILabel!
    private var FowlFortuneScoreLabel: UILabel!
    private var FowlFortuneStatsView: UIView!
    private var FowlFortuneCorrectAnswersLabel: UILabel!
    private var FowlFortuneIncorrectAnswersLabel: UILabel!
    private var FowlFortuneRewardsView: UIView!
    private var FowlFortuneExperienceLabel: UILabel!
    private var FowlFortuneCreditsLabel: UILabel!
    private var FowlFortunePlayAgainButton: UIButton!
    private var FowlFortuneCloseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FowlFortuneSetupUI()
        FowlFortuneSetupConstraints()
        FowlFortuneUpdateUI()
    }
    
    func FowlFortuneConfigure(with session: FowlFortuneQuizSession) {
        FowlFortuneQuizSession = session
    }
    
    private func FowlFortuneSetupUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        
        FowlFortuneSetupScrollView()
        FowlFortuneSetupHeaderView()
        FowlFortuneSetupStatsView()
        FowlFortuneSetupRewardsView()
        FowlFortuneSetupButtons()
    }
    
    private func FowlFortuneSetupScrollView() {
        FowlFortuneScrollView = UIScrollView()
        FowlFortuneScrollView.backgroundColor = UIColor.clear
        FowlFortuneScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneContentView = UIView()
        FowlFortuneContentView.backgroundColor = UIColor.clear
        FowlFortuneContentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(FowlFortuneScrollView)
        FowlFortuneScrollView.addSubview(FowlFortuneContentView)
    }
    
    private func FowlFortuneSetupHeaderView() {
        FowlFortuneHeaderView = UIView()
        FowlFortuneHeaderView.backgroundColor = UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0)
        FowlFortuneHeaderView.layer.cornerRadius = 20
        FowlFortuneHeaderView.layer.shadowColor = UIColor.black.cgColor
        FowlFortuneHeaderView.layer.shadowOffset = CGSize(width: 0, height: 6)
        FowlFortuneHeaderView.layer.shadowOpacity = 0.2
        FowlFortuneHeaderView.layer.shadowRadius = 10
        FowlFortuneHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneEmojiLabel = UILabel()
        FowlFortuneEmojiLabel.font = UIFont.systemFont(ofSize: 80)
        FowlFortuneEmojiLabel.textAlignment = .center
        FowlFortuneEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneTitleLabel = UILabel()
        FowlFortuneTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        FowlFortuneTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneTitleLabel.textAlignment = .center
        FowlFortuneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneScoreLabel = UILabel()
        FowlFortuneScoreLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        FowlFortuneScoreLabel.textColor = UIColor(red: 0.2, green: 0.6, blue: 0.4, alpha: 1.0)
        FowlFortuneScoreLabel.textAlignment = .center
        FowlFortuneScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneHeaderView.addSubview(FowlFortuneEmojiLabel)
        FowlFortuneHeaderView.addSubview(FowlFortuneTitleLabel)
        FowlFortuneHeaderView.addSubview(FowlFortuneScoreLabel)
        FowlFortuneContentView.addSubview(FowlFortuneHeaderView)
    }
    
    private func FowlFortuneSetupStatsView() {
        FowlFortuneStatsView = UIView()
        FowlFortuneStatsView.backgroundColor = UIColor(red: 0.85, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneStatsView.layer.cornerRadius = 16
        FowlFortuneStatsView.layer.shadowColor = UIColor.black.cgColor
        FowlFortuneStatsView.layer.shadowOffset = CGSize(width: 0, height: 4)
        FowlFortuneStatsView.layer.shadowOpacity = 0.15
        FowlFortuneStatsView.layer.shadowRadius = 8
        FowlFortuneStatsView.translatesAutoresizingMaskIntoConstraints = false
        
        let FowlFortuneStatsTitleLabel = UILabel()
        FowlFortuneStatsTitleLabel.text = "📊 Quiz Results"
        FowlFortuneStatsTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        FowlFortuneStatsTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneStatsTitleLabel.textAlignment = .center
        FowlFortuneStatsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneCorrectAnswersLabel = UILabel()
        FowlFortuneCorrectAnswersLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        FowlFortuneCorrectAnswersLabel.textColor = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1.0)
        FowlFortuneCorrectAnswersLabel.textAlignment = .center
        FowlFortuneCorrectAnswersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneIncorrectAnswersLabel = UILabel()
        FowlFortuneIncorrectAnswersLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        FowlFortuneIncorrectAnswersLabel.textColor = UIColor(red: 0.8, green: 0.3, blue: 0.3, alpha: 1.0)
        FowlFortuneIncorrectAnswersLabel.textAlignment = .center
        FowlFortuneIncorrectAnswersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneStatsView.addSubview(FowlFortuneStatsTitleLabel)
        FowlFortuneStatsView.addSubview(FowlFortuneCorrectAnswersLabel)
        FowlFortuneStatsView.addSubview(FowlFortuneIncorrectAnswersLabel)
        FowlFortuneContentView.addSubview(FowlFortuneStatsView)
        
        NSLayoutConstraint.activate([
            FowlFortuneStatsTitleLabel.topAnchor.constraint(equalTo: FowlFortuneStatsView.topAnchor, constant: 20),
            FowlFortuneStatsTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneStatsView.leadingAnchor, constant: 20),
            FowlFortuneStatsTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneStatsView.trailingAnchor, constant: -20),
            
            FowlFortuneCorrectAnswersLabel.topAnchor.constraint(equalTo: FowlFortuneStatsTitleLabel.bottomAnchor, constant: 20),
            FowlFortuneCorrectAnswersLabel.leadingAnchor.constraint(equalTo: FowlFortuneStatsView.leadingAnchor, constant: 20),
            FowlFortuneCorrectAnswersLabel.trailingAnchor.constraint(equalTo: FowlFortuneStatsView.trailingAnchor, constant: -20),
            
            FowlFortuneIncorrectAnswersLabel.topAnchor.constraint(equalTo: FowlFortuneCorrectAnswersLabel.bottomAnchor, constant: 15),
            FowlFortuneIncorrectAnswersLabel.leadingAnchor.constraint(equalTo: FowlFortuneStatsView.leadingAnchor, constant: 20),
            FowlFortuneIncorrectAnswersLabel.trailingAnchor.constraint(equalTo: FowlFortuneStatsView.trailingAnchor, constant: -20),
            FowlFortuneIncorrectAnswersLabel.bottomAnchor.constraint(equalTo: FowlFortuneStatsView.bottomAnchor, constant: -20)
        ])
    }
    
    private func FowlFortuneSetupRewardsView() {
        FowlFortuneRewardsView = UIView()
        FowlFortuneRewardsView.backgroundColor = UIColor(red: 0.88, green: 0.94, blue: 0.88, alpha: 1.0)
        FowlFortuneRewardsView.layer.cornerRadius = 16
        FowlFortuneRewardsView.layer.shadowColor = UIColor.black.cgColor
        FowlFortuneRewardsView.layer.shadowOffset = CGSize(width: 0, height: 4)
        FowlFortuneRewardsView.layer.shadowOpacity = 0.15
        FowlFortuneRewardsView.layer.shadowRadius = 8
        FowlFortuneRewardsView.translatesAutoresizingMaskIntoConstraints = false
        
        let FowlFortuneRewardsTitleLabel = UILabel()
        FowlFortuneRewardsTitleLabel.text = "🎁 Rewards Earned"
        FowlFortuneRewardsTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        FowlFortuneRewardsTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneRewardsTitleLabel.textAlignment = .center
        FowlFortuneRewardsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneExperienceLabel = UILabel()
        FowlFortuneExperienceLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        FowlFortuneExperienceLabel.textColor = UIColor(red: 0.6, green: 0.4, blue: 0.8, alpha: 1.0)
        FowlFortuneExperienceLabel.textAlignment = .center
        FowlFortuneExperienceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneCreditsLabel = UILabel()
        FowlFortuneCreditsLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        FowlFortuneCreditsLabel.textColor = UIColor(red: 0.8, green: 0.6, blue: 0.0, alpha: 1.0)
        FowlFortuneCreditsLabel.textAlignment = .center
        FowlFortuneCreditsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneRewardsView.addSubview(FowlFortuneRewardsTitleLabel)
        FowlFortuneRewardsView.addSubview(FowlFortuneExperienceLabel)
        FowlFortuneRewardsView.addSubview(FowlFortuneCreditsLabel)
        FowlFortuneContentView.addSubview(FowlFortuneRewardsView)
        
        NSLayoutConstraint.activate([
            FowlFortuneRewardsTitleLabel.topAnchor.constraint(equalTo: FowlFortuneRewardsView.topAnchor, constant: 20),
            FowlFortuneRewardsTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneRewardsView.leadingAnchor, constant: 20),
            FowlFortuneRewardsTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneRewardsView.trailingAnchor, constant: -20),
            
            FowlFortuneExperienceLabel.topAnchor.constraint(equalTo: FowlFortuneRewardsTitleLabel.bottomAnchor, constant: 20),
            FowlFortuneExperienceLabel.leadingAnchor.constraint(equalTo: FowlFortuneRewardsView.leadingAnchor, constant: 20),
            FowlFortuneExperienceLabel.trailingAnchor.constraint(equalTo: FowlFortuneRewardsView.trailingAnchor, constant: -20),
            
            FowlFortuneCreditsLabel.topAnchor.constraint(equalTo: FowlFortuneExperienceLabel.bottomAnchor, constant: 15),
            FowlFortuneCreditsLabel.leadingAnchor.constraint(equalTo: FowlFortuneRewardsView.leadingAnchor, constant: 20),
            FowlFortuneCreditsLabel.trailingAnchor.constraint(equalTo: FowlFortuneRewardsView.trailingAnchor, constant: -20),
            FowlFortuneCreditsLabel.bottomAnchor.constraint(equalTo: FowlFortuneRewardsView.bottomAnchor, constant: -20)
        ])
    }
    
    private func FowlFortuneSetupButtons() {
        FowlFortunePlayAgainButton = UIButton(type: .system)
        FowlFortunePlayAgainButton.setTitle("🔄 Play Again", for: .normal)
        FowlFortunePlayAgainButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        FowlFortunePlayAgainButton.setTitleColor(UIColor.white, for: .normal)
        FowlFortunePlayAgainButton.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.4, alpha: 1.0)
        FowlFortunePlayAgainButton.layer.cornerRadius = 12
        FowlFortunePlayAgainButton.layer.shadowColor = UIColor.black.cgColor
        FowlFortunePlayAgainButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        FowlFortunePlayAgainButton.layer.shadowOpacity = 0.2
        FowlFortunePlayAgainButton.layer.shadowRadius = 6
        FowlFortunePlayAgainButton.addTarget(self, action: #selector(FowlFortunePlayAgainButtonTapped), for: .touchUpInside)
        FowlFortunePlayAgainButton.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneCloseButton = UIButton(type: .system)
        FowlFortuneCloseButton.setTitle("✕ Close", for: .normal)
        FowlFortuneCloseButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        FowlFortuneCloseButton.setTitleColor(UIColor(red: 0.6, green: 0.2, blue: 0.2, alpha: 1.0), for: .normal)
        FowlFortuneCloseButton.backgroundColor = UIColor(red: 0.95, green: 0.9, blue: 0.9, alpha: 1.0)
        FowlFortuneCloseButton.layer.cornerRadius = 12
        FowlFortuneCloseButton.layer.shadowColor = UIColor.black.cgColor
        FowlFortuneCloseButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneCloseButton.layer.shadowOpacity = 0.1
        FowlFortuneCloseButton.layer.shadowRadius = 4
        FowlFortuneCloseButton.addTarget(self, action: #selector(FowlFortuneCloseButtonTapped), for: .touchUpInside)
        FowlFortuneCloseButton.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneContentView.addSubview(FowlFortunePlayAgainButton)
        FowlFortuneContentView.addSubview(FowlFortuneCloseButton)
    }
    
    private func FowlFortuneSetupConstraints() {
        NSLayoutConstraint.activate([
            FowlFortuneScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            FowlFortuneScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            FowlFortuneScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            FowlFortuneScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            FowlFortuneContentView.topAnchor.constraint(equalTo: FowlFortuneScrollView.topAnchor),
            FowlFortuneContentView.leadingAnchor.constraint(equalTo: FowlFortuneScrollView.leadingAnchor),
            FowlFortuneContentView.trailingAnchor.constraint(equalTo: FowlFortuneScrollView.trailingAnchor),
            FowlFortuneContentView.bottomAnchor.constraint(equalTo: FowlFortuneScrollView.bottomAnchor),
            FowlFortuneContentView.widthAnchor.constraint(equalTo: FowlFortuneScrollView.widthAnchor),
            
            FowlFortuneHeaderView.topAnchor.constraint(equalTo: FowlFortuneContentView.topAnchor, constant: 30),
            FowlFortuneHeaderView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneHeaderView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            
            FowlFortuneEmojiLabel.topAnchor.constraint(equalTo: FowlFortuneHeaderView.topAnchor, constant: 30),
            FowlFortuneEmojiLabel.centerXAnchor.constraint(equalTo: FowlFortuneHeaderView.centerXAnchor),
            
            FowlFortuneTitleLabel.topAnchor.constraint(equalTo: FowlFortuneEmojiLabel.bottomAnchor, constant: 20),
            FowlFortuneTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneHeaderView.leadingAnchor, constant: 20),
            FowlFortuneTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneHeaderView.trailingAnchor, constant: -20),
            
            FowlFortuneScoreLabel.topAnchor.constraint(equalTo: FowlFortuneTitleLabel.bottomAnchor, constant: 15),
            FowlFortuneScoreLabel.leadingAnchor.constraint(equalTo: FowlFortuneHeaderView.leadingAnchor, constant: 20),
            FowlFortuneScoreLabel.trailingAnchor.constraint(equalTo: FowlFortuneHeaderView.trailingAnchor, constant: -20),
            FowlFortuneScoreLabel.bottomAnchor.constraint(equalTo: FowlFortuneHeaderView.bottomAnchor, constant: -30),
            
            FowlFortuneStatsView.topAnchor.constraint(equalTo: FowlFortuneHeaderView.bottomAnchor, constant: 30),
            FowlFortuneStatsView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneStatsView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            
            FowlFortuneRewardsView.topAnchor.constraint(equalTo: FowlFortuneStatsView.bottomAnchor, constant: 20),
            FowlFortuneRewardsView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneRewardsView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            
            FowlFortunePlayAgainButton.topAnchor.constraint(equalTo: FowlFortuneRewardsView.bottomAnchor, constant: 40),
            FowlFortunePlayAgainButton.centerXAnchor.constraint(equalTo: FowlFortuneContentView.centerXAnchor),
            FowlFortunePlayAgainButton.widthAnchor.constraint(equalToConstant: 200),
            FowlFortunePlayAgainButton.heightAnchor.constraint(equalToConstant: 50),
            
            FowlFortuneCloseButton.topAnchor.constraint(equalTo: FowlFortunePlayAgainButton.bottomAnchor, constant: 15),
            FowlFortuneCloseButton.centerXAnchor.constraint(equalTo: FowlFortuneContentView.centerXAnchor),
            FowlFortuneCloseButton.widthAnchor.constraint(equalToConstant: 150),
            FowlFortuneCloseButton.heightAnchor.constraint(equalToConstant: 44),
            FowlFortuneCloseButton.bottomAnchor.constraint(equalTo: FowlFortuneContentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func FowlFortuneUpdateUI() {
        guard let session = FowlFortuneQuizSession else { return }
        
        let FowlFortuneScore = session.FowlFortuneScore
        let FowlFortuneCorrectAnswers = session.FowlFortuneCorrectAnswers
        let FowlFortuneIncorrectAnswers = session.FowlFortuneIncorrectAnswers
        let FowlFortuneEarnedExperience = session.FowlFortuneEarnedExperience
        let FowlFortuneEarnedCredits = session.FowlFortuneEarnedCredits
        
        FowlFortuneTitleLabel.text = FowlFortuneGetTitleForScore(FowlFortuneScore)
        FowlFortuneEmojiLabel.text = FowlFortuneGetEmojiForScore(FowlFortuneScore)
        FowlFortuneScoreLabel.text = String(format: "%.1f%% Score", FowlFortuneScore)
        
        FowlFortuneCorrectAnswersLabel.text = "✅ Correct Answers: \(FowlFortuneCorrectAnswers)"
        FowlFortuneIncorrectAnswersLabel.text = "❌ Incorrect Answers: \(FowlFortuneIncorrectAnswers)"
        
        FowlFortuneExperienceLabel.text = "⭐ Experience: +\(FowlFortuneEarnedExperience)"
        FowlFortuneCreditsLabel.text = "💰 Credits: +\(FowlFortuneEarnedCredits)"
        
        FowlFortuneAnimateRewards()
    }
    
    private func FowlFortuneGetTitleForScore(_ score: Double) -> String {
        switch score {
        case 90...100:
            return "Outstanding! 🌟"
        case 80..<90:
            return "Excellent Work! 🎉"
        case 70..<80:
            return "Great Job! 👍"
        case 60..<70:
            return "Good Effort! 👏"
        case 50..<60:
            return "Not Bad! 😊"
        default:
            return "Keep Trying! 💪"
        }
    }
    
    private func FowlFortuneGetEmojiForScore(_ score: Double) -> String {
        switch score {
        case 90...100:
            return "🏆"
        case 80..<90:
            return "🥇"
        case 70..<80:
            return "🥈"
        case 60..<70:
            return "🥉"
        case 50..<60:
            return "📚"
        default:
            return "💪"
        }
    }
    
    private func FowlFortuneAnimateRewards() {
        FowlFortuneExperienceLabel.alpha = 0
        FowlFortuneCreditsLabel.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseInOut) {
            self.FowlFortuneExperienceLabel.alpha = 1
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.6, options: .curveEaseInOut) {
            self.FowlFortuneCreditsLabel.alpha = 1
        }
    }
    
    @objc private func FowlFortunePlayAgainButtonTapped() {
        dismiss(animated: true) {
            let FowlFortuneQuizViewController = FowlFortuneQuizViewController()
            FowlFortuneQuizViewController.modalPresentationStyle = .fullScreen
            FowlFortuneQuizViewController.modalTransitionStyle = .coverVertical
            
            if let FowlFortuneTopViewController = UIApplication.shared.windows.first?.rootViewController?.presentedViewController {
                FowlFortuneTopViewController.present(FowlFortuneQuizViewController, animated: true)
            }
        }
    }
    
    @objc private func FowlFortuneCloseButtonTapped() {
        dismiss(animated: true)
    }
}
