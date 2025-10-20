import UIKit

class FowlFortuneLoadingViewController: UIViewController {
    
    private lazy var FowlFortuneBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        return view
    }()
    
    private lazy var FowlFortuneGradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0).cgColor,
            UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0).cgColor,
            UIColor(red: 0.95, green: 0.90, blue: 0.95, alpha: 1.0).cgColor
        ]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
    
    private lazy var FowlFortuneEmojiContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private lazy var FowlFortuneMainEmojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "🐔"
        label.font = UIFont.systemFont(ofSize: 120)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var FowlFortuneTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "FowlFortune"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.white.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowOpacity = 0.3
        label.layer.shadowRadius = 4
        return label
    }()
    
    private lazy var FowlFortuneSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Chicken Farm Simulation"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 0.8)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var FowlFortuneLoadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading..."
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 0.7)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var FowlFortuneProgressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        progressView.trackTintColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 0.2)
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        return progressView
    }()
    
    private var FowlFortuneBackgroundEmojis: [UILabel] = []
    private var FowlFortuneLoadingTimer: Timer?
    private var FowlFortuneProgressTimer: Timer?
    private var FowlFortuneCurrentProgress: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FowlFortuneSetupUI()
        FowlFortuneStartAnimations()
        FowlFortuneStartLoading()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        FowlFortuneGradientLayer.frame = FowlFortuneBackgroundView.bounds
    }
    
    private func FowlFortuneSetupUI() {
        view.addSubview(FowlFortuneBackgroundView)
        FowlFortuneBackgroundView.layer.addSublayer(FowlFortuneGradientLayer)
        
        view.addSubview(FowlFortuneEmojiContainer)
        FowlFortuneEmojiContainer.addSubview(FowlFortuneMainEmojiLabel)
        
        view.addSubview(FowlFortuneTitleLabel)
        view.addSubview(FowlFortuneSubtitleLabel)
        view.addSubview(FowlFortuneProgressView)
        view.addSubview(FowlFortuneLoadingLabel)
        
        FowlFortuneSetupBackgroundEmojis()
        FowlFortuneSetupConstraints()
    }
    
    private func FowlFortuneSetupBackgroundEmojis() {
        let emojis = ["🌾", "🥚", "🐓", "🌻", "🪺", "🏠", "🛡️", "⚡", "💎", "⭐"]
        
        for emoji in emojis {
            let emojiLabel = UILabel()
            emojiLabel.text = emoji
            emojiLabel.font = UIFont.systemFont(ofSize: CGFloat.random(in: 20...40))
            emojiLabel.textAlignment = .center
            emojiLabel.alpha = 0.3
            emojiLabel.translatesAutoresizingMaskIntoConstraints = false
            
            FowlFortuneBackgroundView.addSubview(emojiLabel)
            FowlFortuneBackgroundEmojis.append(emojiLabel)
            
            NSLayoutConstraint.activate([
                emojiLabel.centerXAnchor.constraint(equalTo: FowlFortuneBackgroundView.leadingAnchor, constant: CGFloat.random(in: 50...300)),
                emojiLabel.centerYAnchor.constraint(equalTo: FowlFortuneBackgroundView.topAnchor, constant: CGFloat.random(in: 100...500))
            ])
        }
    }
    
    private func FowlFortuneSetupConstraints() {
        NSLayoutConstraint.activate([
            FowlFortuneBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            FowlFortuneBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            FowlFortuneBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            FowlFortuneBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            FowlFortuneEmojiContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            FowlFortuneEmojiContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            FowlFortuneEmojiContainer.widthAnchor.constraint(equalToConstant: 200),
            FowlFortuneEmojiContainer.heightAnchor.constraint(equalToConstant: 200),
            
            FowlFortuneMainEmojiLabel.centerXAnchor.constraint(equalTo: FowlFortuneEmojiContainer.centerXAnchor),
            FowlFortuneMainEmojiLabel.centerYAnchor.constraint(equalTo: FowlFortuneEmojiContainer.centerYAnchor),
            
            FowlFortuneTitleLabel.topAnchor.constraint(equalTo: FowlFortuneEmojiContainer.bottomAnchor, constant: 30),
            FowlFortuneTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            FowlFortuneTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            FowlFortuneSubtitleLabel.topAnchor.constraint(equalTo: FowlFortuneTitleLabel.bottomAnchor, constant: 8),
            FowlFortuneSubtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            FowlFortuneSubtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            FowlFortuneProgressView.topAnchor.constraint(equalTo: FowlFortuneSubtitleLabel.bottomAnchor, constant: 40),
            FowlFortuneProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            FowlFortuneProgressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            FowlFortuneProgressView.heightAnchor.constraint(equalToConstant: 8),
            
            FowlFortuneLoadingLabel.topAnchor.constraint(equalTo: FowlFortuneProgressView.bottomAnchor, constant: 16),
            FowlFortuneLoadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func FowlFortuneStartAnimations() {
        // Анимация главного эмодзи
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
            self.FowlFortuneMainEmojiLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        })
        
        // Анимация фоновых эмодзи
        for (index, emojiLabel) in FowlFortuneBackgroundEmojis.enumerated() {
            UIView.animate(withDuration: Double.random(in: 3...6), delay: Double(index) * 0.5, options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
                emojiLabel.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: -0.3...0.3))
                emojiLabel.alpha = CGFloat.random(in: 0.1...0.4)
            })
        }
        
        // Анимация загрузки
        FowlFortuneLoadingTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.FowlFortuneAnimateLoadingText()
        }
    }
    
    private func FowlFortuneAnimateLoadingText() {
        UIView.transition(with: FowlFortuneLoadingLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
            let dots = String(repeating: ".", count: Int.random(in: 1...4))
            self.FowlFortuneLoadingLabel.text = "Loading\(dots)"
        })
    }
    
    private func FowlFortuneStartLoading() {
        FowlFortuneProgressTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            self?.FowlFortuneUpdateProgress()
        }
    }
    
    private func FowlFortuneUpdateProgress() {
        FowlFortuneCurrentProgress += Float.random(in: 0.01...0.03)
        FowlFortuneProgressView.setProgress(FowlFortuneCurrentProgress, animated: true)
        
        if FowlFortuneCurrentProgress >= 1.0 {
            FowlFortuneProgressTimer?.invalidate()
            FowlFortuneLoadingTimer?.invalidate()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.FowlFortuneNavigateToNextScreen()
            }
        }
    }
    
    private func FowlFortuneNavigateToNextScreen() {
        let FowlFortuneUserDefaults = UserDefaults.standard
        let FowlFortuneHasCompletedOnboarding = FowlFortuneUserDefaults.bool(forKey: "FowlFortuneHasCompletedOnboarding")
        
        if FowlFortuneHasCompletedOnboarding {
            // Переходим к основному приложению
            let FowlFortuneMainTabBarController = FowlFortuneMainTabBarController()
            if let window = view.window {
                window.rootViewController = FowlFortuneMainTabBarController
                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
            }
        } else {
            // Переходим к onboarding
            let FowlFortuneOnboardingViewController = FowlFortuneOnboardingViewController()
            FowlFortuneOnboardingViewController.modalPresentationStyle = .fullScreen
            present(FowlFortuneOnboardingViewController, animated: true)
        }
    }
    
    deinit {
        FowlFortuneLoadingTimer?.invalidate()
        FowlFortuneProgressTimer?.invalidate()
    }
}
