import UIKit

class FowlFortuneOnboardingViewController: UIViewController {
    
    private let FowlFortunePages = FowlFortuneOnboardingData.FowlFortuneOnboardingPages
    private var FowlFortuneCurrentPageIndex = 0
    
    private lazy var FowlFortuneScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var FowlFortuneContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var FowlFortunePageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = FowlFortunePages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 0.3)
        pageControl.currentPageIndicatorTintColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        return pageControl
    }()
    
    private lazy var FowlFortuneNextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next →", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 8
        button.addTarget(self, action: #selector(FowlFortuneNextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var FowlFortuneSkipButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 0.7), for: .normal)
        button.addTarget(self, action: #selector(FowlFortuneSkipButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var FowlFortunePageViews: [FowlFortuneOnboardingPageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FowlFortuneSetupUI()
        FowlFortuneCreatePageViews()
        FowlFortuneUpdateUI()
    }
    
    private func FowlFortuneSetupUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        
        view.addSubview(FowlFortuneScrollView)
        FowlFortuneScrollView.addSubview(FowlFortuneContentView)
        view.addSubview(FowlFortunePageControl)
        view.addSubview(FowlFortuneNextButton)
        view.addSubview(FowlFortuneSkipButton)
        
        FowlFortuneSetupConstraints()
    }
    
    private func FowlFortuneSetupConstraints() {
        NSLayoutConstraint.activate([
            FowlFortuneScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            FowlFortuneScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            FowlFortuneScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            FowlFortuneScrollView.bottomAnchor.constraint(equalTo: FowlFortunePageControl.topAnchor, constant: -20),
            
            FowlFortuneContentView.topAnchor.constraint(equalTo: FowlFortuneScrollView.topAnchor),
            FowlFortuneContentView.leadingAnchor.constraint(equalTo: FowlFortuneScrollView.leadingAnchor),
            FowlFortuneContentView.trailingAnchor.constraint(equalTo: FowlFortuneScrollView.trailingAnchor),
            FowlFortuneContentView.bottomAnchor.constraint(equalTo: FowlFortuneScrollView.bottomAnchor),
            FowlFortuneContentView.heightAnchor.constraint(equalTo: FowlFortuneScrollView.heightAnchor),
            
            FowlFortunePageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            FowlFortunePageControl.bottomAnchor.constraint(equalTo: FowlFortuneNextButton.topAnchor, constant: -30),
            
            FowlFortuneNextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            FowlFortuneNextButton.bottomAnchor.constraint(equalTo: FowlFortuneSkipButton.topAnchor, constant: -20),
            FowlFortuneNextButton.widthAnchor.constraint(equalToConstant: 200),
            FowlFortuneNextButton.heightAnchor.constraint(equalToConstant: 50),
            
            FowlFortuneSkipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            FowlFortuneSkipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func FowlFortuneCreatePageViews() {
        var FowlFortunePreviousPageView: FowlFortuneOnboardingPageView?
        
        for (index, page) in FowlFortunePages.enumerated() {
            let pageView = FowlFortuneOnboardingPageView()
            pageView.translatesAutoresizingMaskIntoConstraints = false
            pageView.FowlFortuneConfigure(with: page)
            
            FowlFortuneContentView.addSubview(pageView)
            FowlFortunePageViews.append(pageView)
            
            NSLayoutConstraint.activate([
                pageView.topAnchor.constraint(equalTo: FowlFortuneContentView.topAnchor),
                pageView.bottomAnchor.constraint(equalTo: FowlFortuneContentView.bottomAnchor),
                pageView.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])
            
            if let previousPageView = FowlFortunePreviousPageView {
                pageView.leadingAnchor.constraint(equalTo: previousPageView.trailingAnchor).isActive = true
            } else {
                pageView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor).isActive = true
            }
            
            if index == FowlFortunePages.count - 1 {
                pageView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor).isActive = true
            }
            
            FowlFortunePreviousPageView = pageView
        }
    }
    
    private func FowlFortuneUpdateUI() {
        FowlFortunePageControl.currentPage = FowlFortuneCurrentPageIndex
        
        if FowlFortuneCurrentPageIndex == FowlFortunePages.count - 1 {
            FowlFortuneNextButton.setTitle("Get Started! 🚀", for: .normal)
            FowlFortuneSkipButton.isHidden = true
        } else {
            FowlFortuneNextButton.setTitle("Next →", for: .normal)
            FowlFortuneSkipButton.isHidden = false
        }
    }
    
    @objc private func FowlFortuneNextButtonTapped() {
        if FowlFortuneCurrentPageIndex < FowlFortunePages.count - 1 {
            FowlFortuneCurrentPageIndex += 1
            let offset = CGPoint(x: CGFloat(FowlFortuneCurrentPageIndex) * view.frame.width, y: 0)
            FowlFortuneScrollView.setContentOffset(offset, animated: true)
        } else {
            FowlFortuneCompleteOnboarding()
        }
    }
    
    @objc private func FowlFortuneSkipButtonTapped() {
        FowlFortuneCompleteOnboarding()
    }
    
    private func FowlFortuneCompleteOnboarding() {
        UserDefaults.standard.set(true, forKey: "FowlFortuneHasCompletedOnboarding")
        
        let FowlFortuneMainTabBarController = FowlFortuneMainTabBarController()
        if let window = view.window {
            window.rootViewController = FowlFortuneMainTabBarController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        }
    }
}

extension FowlFortuneOnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let FowlFortunePageIndex = round(scrollView.contentOffset.x / view.frame.width)
        FowlFortuneCurrentPageIndex = Int(FowlFortunePageIndex)
        FowlFortuneUpdateUI()
    }
}

class FowlFortuneOnboardingPageView: UIView {
    
    private lazy var FowlFortuneBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 16
        return view
    }()
    
    private lazy var FowlFortuneEmojiContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        view.layer.cornerRadius = 80
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 8
        return view
    }()
    
    private lazy var FowlFortuneMainEmojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 80)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var FowlFortuneTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var FowlFortuneDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 0.8)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private var FowlFortuneBackgroundEmojis: [UILabel] = []
    
    func FowlFortuneConfigure(with page: FowlFortuneOnboardingPage) {
        FowlFortuneBackgroundView.backgroundColor = page.FowlFortunePageColor
        FowlFortuneMainEmojiLabel.text = page.FowlFortunePageEmoji
        FowlFortuneTitleLabel.text = page.FowlFortunePageTitle
        FowlFortuneDescriptionLabel.text = page.FowlFortunePageDescription
        
        FowlFortuneSetupUI()
        FowlFortuneSetupBackgroundEmojis(emojis: page.FowlFortunePageBackgroundEmojis)
    }
    
    private func FowlFortuneSetupUI() {
        addSubview(FowlFortuneBackgroundView)
        FowlFortuneBackgroundView.addSubview(FowlFortuneEmojiContainer)
        FowlFortuneEmojiContainer.addSubview(FowlFortuneMainEmojiLabel)
        FowlFortuneBackgroundView.addSubview(FowlFortuneTitleLabel)
        FowlFortuneBackgroundView.addSubview(FowlFortuneDescriptionLabel)
        
        FowlFortuneSetupConstraints()
    }
    
    private func FowlFortuneSetupConstraints() {
        NSLayoutConstraint.activate([
            FowlFortuneBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            FowlFortuneBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            FowlFortuneBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            FowlFortuneBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            
            FowlFortuneEmojiContainer.centerXAnchor.constraint(equalTo: FowlFortuneBackgroundView.centerXAnchor),
            FowlFortuneEmojiContainer.topAnchor.constraint(equalTo: FowlFortuneBackgroundView.topAnchor, constant: 40),
            FowlFortuneEmojiContainer.widthAnchor.constraint(equalToConstant: 160),
            FowlFortuneEmojiContainer.heightAnchor.constraint(equalToConstant: 160),
            
            FowlFortuneMainEmojiLabel.centerXAnchor.constraint(equalTo: FowlFortuneEmojiContainer.centerXAnchor),
            FowlFortuneMainEmojiLabel.centerYAnchor.constraint(equalTo: FowlFortuneEmojiContainer.centerYAnchor),
            
            FowlFortuneTitleLabel.topAnchor.constraint(equalTo: FowlFortuneEmojiContainer.bottomAnchor, constant: 30),
            FowlFortuneTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneBackgroundView.leadingAnchor, constant: 30),
            FowlFortuneTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneBackgroundView.trailingAnchor, constant: -30),
            
            FowlFortuneDescriptionLabel.topAnchor.constraint(equalTo: FowlFortuneTitleLabel.bottomAnchor, constant: 20),
            FowlFortuneDescriptionLabel.leadingAnchor.constraint(equalTo: FowlFortuneBackgroundView.leadingAnchor, constant: 30),
            FowlFortuneDescriptionLabel.trailingAnchor.constraint(equalTo: FowlFortuneBackgroundView.trailingAnchor, constant: -30)
        ])
    }
    
    private func FowlFortuneSetupBackgroundEmojis(emojis: [String]) {
        for emoji in emojis {
            let emojiLabel = UILabel()
            emojiLabel.text = emoji
            emojiLabel.font = UIFont.systemFont(ofSize: CGFloat.random(in: 24...36))
            emojiLabel.textAlignment = .center
            emojiLabel.alpha = 0.15
            emojiLabel.translatesAutoresizingMaskIntoConstraints = false
            
            FowlFortuneBackgroundView.addSubview(emojiLabel)
            FowlFortuneBackgroundEmojis.append(emojiLabel)
            
            NSLayoutConstraint.activate([
                emojiLabel.centerXAnchor.constraint(equalTo: FowlFortuneBackgroundView.leadingAnchor, constant: CGFloat.random(in: 60...280)),
                emojiLabel.centerYAnchor.constraint(equalTo: FowlFortuneBackgroundView.topAnchor, constant: CGFloat.random(in: 100...400))
            ])
            
            // Анимация фоновых эмодзи
            UIView.animate(withDuration: Double.random(in: 4...8), delay: Double.random(in: 0...2), options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
                emojiLabel.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: -0.2...0.2))
                emojiLabel.alpha = CGFloat.random(in: 0.05...0.2)
            })
        }
    }
}
