import UIKit

class FowlFortuneFactDetailViewController: UIViewController {
    
    private var FowlFortuneFact: FowlFortuneChickenFact?
    private var FowlFortuneScrollView: UIScrollView!
    private var FowlFortuneContentView: UIView!
    private var FowlFortuneCloseButton: UIButton!
    private var FowlFortuneHeaderView: UIView!
    private var FowlFortuneEmojiLabel: UILabel!
    private var FowlFortuneTitleLabel: UILabel!
    private var FowlFortuneCategoryLabel: UILabel!
    private var FowlFortuneDetailedInfoLabel: UILabel!
    private var FowlFortuneFunFactsView: UIView!
    private var FowlFortuneFunFactsTitleLabel: UILabel!
    private var FowlFortuneFunFactsStackView: UIStackView!
    private var FowlFortuneInfoSectionsView: UIView!
    private var FowlFortuneInfoSectionsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FowlFortuneSetupUI()
        FowlFortuneSetupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FowlFortuneUpdateUI()
    }
    
    func FowlFortuneConfigure(with fact: FowlFortuneChickenFact) {
        FowlFortuneFact = fact
    }
    
    private func FowlFortuneSetupUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        
        FowlFortuneSetupScrollView()
        FowlFortuneSetupHeaderView()
        FowlFortuneSetupDetailedInfo()
        FowlFortuneSetupFunFacts()
        FowlFortuneSetupInfoSections()
        FowlFortuneSetupCloseButton()
        FowlFortuneSetupConstraints()
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
        FowlFortuneHeaderView.layer.cornerRadius = 16
        FowlFortuneHeaderView.layer.shadowColor = UIColor.black.cgColor
        FowlFortuneHeaderView.layer.shadowOffset = CGSize(width: 0, height: 4)
        FowlFortuneHeaderView.layer.shadowOpacity = 0.15
        FowlFortuneHeaderView.layer.shadowRadius = 8
        FowlFortuneHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneEmojiLabel = UILabel()
        FowlFortuneEmojiLabel.font = UIFont.systemFont(ofSize: 60)
        FowlFortuneEmojiLabel.textAlignment = .center
        FowlFortuneEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneTitleLabel = UILabel()
        FowlFortuneTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        FowlFortuneTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneTitleLabel.textAlignment = .center
        FowlFortuneTitleLabel.numberOfLines = 0
        FowlFortuneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneCategoryLabel = UILabel()
        FowlFortuneCategoryLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        FowlFortuneCategoryLabel.textColor = UIColor(red: 0.4, green: 0.6, blue: 0.5, alpha: 1.0)
        FowlFortuneCategoryLabel.textAlignment = .center
        FowlFortuneCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneContentView.addSubview(FowlFortuneHeaderView)
        FowlFortuneHeaderView.addSubview(FowlFortuneEmojiLabel)
        FowlFortuneHeaderView.addSubview(FowlFortuneTitleLabel)
        FowlFortuneHeaderView.addSubview(FowlFortuneCategoryLabel)
    }
    
    private func FowlFortuneSetupDetailedInfo() {
        FowlFortuneDetailedInfoLabel = UILabel()
        FowlFortuneDetailedInfoLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        FowlFortuneDetailedInfoLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        FowlFortuneDetailedInfoLabel.numberOfLines = 0
        FowlFortuneDetailedInfoLabel.lineBreakMode = .byWordWrapping
        FowlFortuneDetailedInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneContentView.addSubview(FowlFortuneDetailedInfoLabel)
    }
    
    private func FowlFortuneSetupFunFacts() {
        FowlFortuneFunFactsView = UIView()
        FowlFortuneFunFactsView.backgroundColor = UIColor(red: 0.85, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneFunFactsView.layer.cornerRadius = 12
        FowlFortuneFunFactsView.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneFunFactsTitleLabel = UILabel()
        FowlFortuneFunFactsTitleLabel.text = "🎉 Fun Facts"
        FowlFortuneFunFactsTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        FowlFortuneFunFactsTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneFunFactsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneFunFactsStackView = UIStackView()
        FowlFortuneFunFactsStackView.axis = .vertical
        FowlFortuneFunFactsStackView.spacing = 8
        FowlFortuneFunFactsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneFunFactsView.addSubview(FowlFortuneFunFactsTitleLabel)
        FowlFortuneFunFactsView.addSubview(FowlFortuneFunFactsStackView)
        FowlFortuneContentView.addSubview(FowlFortuneFunFactsView)
    }
    
    private func FowlFortuneSetupInfoSections() {
        FowlFortuneInfoSectionsView = UIView()
        FowlFortuneInfoSectionsView.backgroundColor = UIColor(red: 0.88, green: 0.94, blue: 0.88, alpha: 1.0)
        FowlFortuneInfoSectionsView.layer.cornerRadius = 12
        FowlFortuneInfoSectionsView.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneInfoSectionsStackView = UIStackView()
        FowlFortuneInfoSectionsStackView.axis = .vertical
        FowlFortuneInfoSectionsStackView.spacing = 12
        FowlFortuneInfoSectionsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneInfoSectionsView.addSubview(FowlFortuneInfoSectionsStackView)
        FowlFortuneContentView.addSubview(FowlFortuneInfoSectionsView)
    }
    
    private func FowlFortuneSetupCloseButton() {
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
            
            FowlFortuneHeaderView.topAnchor.constraint(equalTo: FowlFortuneContentView.topAnchor, constant: 20),
            FowlFortuneHeaderView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 15),
            FowlFortuneHeaderView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -15),
            
            FowlFortuneEmojiLabel.topAnchor.constraint(equalTo: FowlFortuneHeaderView.topAnchor, constant: 20),
            FowlFortuneEmojiLabel.centerXAnchor.constraint(equalTo: FowlFortuneHeaderView.centerXAnchor),
            
            FowlFortuneTitleLabel.topAnchor.constraint(equalTo: FowlFortuneEmojiLabel.bottomAnchor, constant: 10),
            FowlFortuneTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneHeaderView.leadingAnchor, constant: 20),
            FowlFortuneTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneHeaderView.trailingAnchor, constant: -20),
            
            FowlFortuneCategoryLabel.topAnchor.constraint(equalTo: FowlFortuneTitleLabel.bottomAnchor, constant: 8),
            FowlFortuneCategoryLabel.leadingAnchor.constraint(equalTo: FowlFortuneHeaderView.leadingAnchor, constant: 20),
            FowlFortuneCategoryLabel.trailingAnchor.constraint(equalTo: FowlFortuneHeaderView.trailingAnchor, constant: -20),
            FowlFortuneCategoryLabel.bottomAnchor.constraint(equalTo: FowlFortuneHeaderView.bottomAnchor, constant: -20),
            
            FowlFortuneDetailedInfoLabel.topAnchor.constraint(equalTo: FowlFortuneHeaderView.bottomAnchor, constant: 20),
            FowlFortuneDetailedInfoLabel.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneDetailedInfoLabel.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            
            FowlFortuneFunFactsView.topAnchor.constraint(equalTo: FowlFortuneDetailedInfoLabel.bottomAnchor, constant: 20),
            FowlFortuneFunFactsView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 15),
            FowlFortuneFunFactsView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -15),
            
            FowlFortuneFunFactsTitleLabel.topAnchor.constraint(equalTo: FowlFortuneFunFactsView.topAnchor, constant: 15),
            FowlFortuneFunFactsTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneFunFactsView.leadingAnchor, constant: 15),
            FowlFortuneFunFactsTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneFunFactsView.trailingAnchor, constant: -15),
            
            FowlFortuneFunFactsStackView.topAnchor.constraint(equalTo: FowlFortuneFunFactsTitleLabel.bottomAnchor, constant: 10),
            FowlFortuneFunFactsStackView.leadingAnchor.constraint(equalTo: FowlFortuneFunFactsView.leadingAnchor, constant: 15),
            FowlFortuneFunFactsStackView.trailingAnchor.constraint(equalTo: FowlFortuneFunFactsView.trailingAnchor, constant: -15),
            FowlFortuneFunFactsStackView.bottomAnchor.constraint(equalTo: FowlFortuneFunFactsView.bottomAnchor, constant: -15),
            
            FowlFortuneInfoSectionsView.topAnchor.constraint(equalTo: FowlFortuneFunFactsView.bottomAnchor, constant: 20),
            FowlFortuneInfoSectionsView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 15),
            FowlFortuneInfoSectionsView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -15),
            
            FowlFortuneInfoSectionsStackView.topAnchor.constraint(equalTo: FowlFortuneInfoSectionsView.topAnchor, constant: 15),
            FowlFortuneInfoSectionsStackView.leadingAnchor.constraint(equalTo: FowlFortuneInfoSectionsView.leadingAnchor, constant: 15),
            FowlFortuneInfoSectionsStackView.trailingAnchor.constraint(equalTo: FowlFortuneInfoSectionsView.trailingAnchor, constant: -15),
            FowlFortuneInfoSectionsStackView.bottomAnchor.constraint(equalTo: FowlFortuneInfoSectionsView.bottomAnchor, constant: -15),
            
            FowlFortuneCloseButton.topAnchor.constraint(equalTo: FowlFortuneInfoSectionsView.bottomAnchor, constant: 30),
            FowlFortuneCloseButton.centerXAnchor.constraint(equalTo: FowlFortuneContentView.centerXAnchor),
            FowlFortuneCloseButton.widthAnchor.constraint(equalToConstant: 120),
            FowlFortuneCloseButton.heightAnchor.constraint(equalToConstant: 44),
            FowlFortuneCloseButton.bottomAnchor.constraint(equalTo: FowlFortuneContentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func FowlFortuneSetupBindings() {
        
    }
    
    private func FowlFortuneUpdateUI() {
        guard let fact = FowlFortuneFact else { return }
        
        FowlFortuneEmojiLabel.text = fact.FowlFortuneFactEmoji
        FowlFortuneTitleLabel.text = fact.FowlFortuneFactTitle
        FowlFortuneCategoryLabel.text = fact.FowlFortuneFactCategory.FowlFortuneCategoryEmoji + " " + fact.FowlFortuneFactCategory.FowlFortuneCategoryName
        FowlFortuneDetailedInfoLabel.text = fact.FowlFortuneFactDetailedInfo
        
        FowlFortunePopulateFunFacts()
        FowlFortunePopulateInfoSections()
    }
    
    private func FowlFortunePopulateFunFacts() {
        guard let fact = FowlFortuneFact else { return }
        
        FowlFortuneFunFactsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for funFact in fact.FowlFortuneFactFunFacts {
            let FowlFortuneFunFactView = UIView()
            FowlFortuneFunFactView.backgroundColor = UIColor(red: 0.92, green: 0.96, blue: 0.92, alpha: 1.0)
            FowlFortuneFunFactView.layer.cornerRadius = 8
            FowlFortuneFunFactView.translatesAutoresizingMaskIntoConstraints = false
            
            let FowlFortuneBulletLabel = UILabel()
            FowlFortuneBulletLabel.text = "•"
            FowlFortuneBulletLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            FowlFortuneBulletLabel.textColor = UIColor(red: 0.2, green: 0.6, blue: 0.4, alpha: 1.0)
            FowlFortuneBulletLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let FowlFortuneFunFactLabel = UILabel()
            FowlFortuneFunFactLabel.text = funFact
            FowlFortuneFunFactLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            FowlFortuneFunFactLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
            FowlFortuneFunFactLabel.numberOfLines = 0
            FowlFortuneFunFactLabel.translatesAutoresizingMaskIntoConstraints = false
            
            FowlFortuneFunFactView.addSubview(FowlFortuneBulletLabel)
            FowlFortuneFunFactView.addSubview(FowlFortuneFunFactLabel)
            
            NSLayoutConstraint.activate([
                FowlFortuneBulletLabel.leadingAnchor.constraint(equalTo: FowlFortuneFunFactView.leadingAnchor, constant: 12),
                FowlFortuneBulletLabel.topAnchor.constraint(equalTo: FowlFortuneFunFactView.topAnchor, constant: 12),
                FowlFortuneBulletLabel.widthAnchor.constraint(equalToConstant: 20),
                
                FowlFortuneFunFactLabel.leadingAnchor.constraint(equalTo: FowlFortuneBulletLabel.trailingAnchor, constant: 8),
                FowlFortuneFunFactLabel.trailingAnchor.constraint(equalTo: FowlFortuneFunFactView.trailingAnchor, constant: -12),
                FowlFortuneFunFactLabel.topAnchor.constraint(equalTo: FowlFortuneFunFactView.topAnchor, constant: 12),
                FowlFortuneFunFactLabel.bottomAnchor.constraint(equalTo: FowlFortuneFunFactView.bottomAnchor, constant: -12)
            ])
            
            FowlFortuneFunFactsStackView.addArrangedSubview(FowlFortuneFunFactView)
        }
    }
    
    private func FowlFortunePopulateInfoSections() {
        guard let fact = FowlFortuneFact else { return }
        
        FowlFortuneInfoSectionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let FowlFortuneInfoItems = [
            ("Scientific Name", fact.FowlFortuneFactScientificName, "🔬"),
            ("Origin", fact.FowlFortuneFactOrigin, "🌍"),
            ("Lifespan", fact.FowlFortuneFactLifespan, "⏰"),
            ("Egg Production", fact.FowlFortuneFactEggProduction, "🥚"),
            ("Weight", fact.FowlFortuneFactWeight, "⚖️"),
            ("Temperament", fact.FowlFortuneFactTemperament, "😊")
        ]
        
        for (title, value, emoji) in FowlFortuneInfoItems {
            let FowlFortuneInfoItemView = FowlFortuneCreateInfoItemView(title: title, value: value, emoji: emoji)
            FowlFortuneInfoSectionsStackView.addArrangedSubview(FowlFortuneInfoItemView)
        }
        
        if !fact.FowlFortuneFactSpecialFeatures.isEmpty {
            let FowlFortuneFeaturesView = FowlFortuneCreateFeaturesView(features: fact.FowlFortuneFactSpecialFeatures)
            FowlFortuneInfoSectionsStackView.addArrangedSubview(FowlFortuneFeaturesView)
        }
        
        if !fact.FowlFortuneFactCareTips.isEmpty {
            let FowlFortuneCareTipsView = FowlFortuneCreateCareTipsView(tips: fact.FowlFortuneFactCareTips)
            FowlFortuneInfoSectionsStackView.addArrangedSubview(FowlFortuneCareTipsView)
        }
    }
    
    private func FowlFortuneCreateInfoItemView(title: String, value: String, emoji: String) -> UIView {
        let FowlFortuneItemView = UIView()
        FowlFortuneItemView.backgroundColor = UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0)
        FowlFortuneItemView.layer.cornerRadius = 8
        FowlFortuneItemView.translatesAutoresizingMaskIntoConstraints = false
        
        let FowlFortuneEmojiLabel = UILabel()
        FowlFortuneEmojiLabel.text = emoji
        FowlFortuneEmojiLabel.font = UIFont.systemFont(ofSize: 20)
        FowlFortuneEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let FowlFortuneTitleLabel = UILabel()
        FowlFortuneTitleLabel.text = title
        FowlFortuneTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        FowlFortuneTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let FowlFortuneValueLabel = UILabel()
        FowlFortuneValueLabel.text = value
        FowlFortuneValueLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        FowlFortuneValueLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        FowlFortuneValueLabel.numberOfLines = 0
        FowlFortuneValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneItemView.addSubview(FowlFortuneEmojiLabel)
        FowlFortuneItemView.addSubview(FowlFortuneTitleLabel)
        FowlFortuneItemView.addSubview(FowlFortuneValueLabel)
        
        NSLayoutConstraint.activate([
            FowlFortuneEmojiLabel.leadingAnchor.constraint(equalTo: FowlFortuneItemView.leadingAnchor, constant: 12),
            FowlFortuneEmojiLabel.centerYAnchor.constraint(equalTo: FowlFortuneItemView.centerYAnchor),
            FowlFortuneEmojiLabel.widthAnchor.constraint(equalToConstant: 30),
            
            FowlFortuneTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneEmojiLabel.trailingAnchor, constant: 12),
            FowlFortuneTitleLabel.topAnchor.constraint(equalTo: FowlFortuneItemView.topAnchor, constant: 12),
            FowlFortuneTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneItemView.trailingAnchor, constant: -12),
            
            FowlFortuneValueLabel.leadingAnchor.constraint(equalTo: FowlFortuneTitleLabel.leadingAnchor),
            FowlFortuneValueLabel.trailingAnchor.constraint(equalTo: FowlFortuneTitleLabel.trailingAnchor),
            FowlFortuneValueLabel.topAnchor.constraint(equalTo: FowlFortuneTitleLabel.bottomAnchor, constant: 4),
            FowlFortuneValueLabel.bottomAnchor.constraint(equalTo: FowlFortuneItemView.bottomAnchor, constant: -12)
        ])
        
        return FowlFortuneItemView
    }
    
    private func FowlFortuneCreateFeaturesView(features: [String]) -> UIView {
        let FowlFortuneFeaturesView = UIView()
        FowlFortuneFeaturesView.backgroundColor = UIColor(red: 0.85, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneFeaturesView.layer.cornerRadius = 8
        FowlFortuneFeaturesView.translatesAutoresizingMaskIntoConstraints = false
        
        let FowlFortuneFeaturesTitleLabel = UILabel()
        FowlFortuneFeaturesTitleLabel.text = "✨ Special Features"
        FowlFortuneFeaturesTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        FowlFortuneFeaturesTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneFeaturesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let FowlFortuneFeaturesStackView = UIStackView()
        FowlFortuneFeaturesStackView.axis = .vertical
        FowlFortuneFeaturesStackView.spacing = 6
        FowlFortuneFeaturesStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for feature in features {
            let FowlFortuneFeatureLabel = UILabel()
            FowlFortuneFeatureLabel.text = "• " + feature
            FowlFortuneFeatureLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            FowlFortuneFeatureLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
            FowlFortuneFeatureLabel.numberOfLines = 0
            FowlFortuneFeaturesStackView.addArrangedSubview(FowlFortuneFeatureLabel)
        }
        
        FowlFortuneFeaturesView.addSubview(FowlFortuneFeaturesTitleLabel)
        FowlFortuneFeaturesView.addSubview(FowlFortuneFeaturesStackView)
        
        NSLayoutConstraint.activate([
            FowlFortuneFeaturesTitleLabel.topAnchor.constraint(equalTo: FowlFortuneFeaturesView.topAnchor, constant: 12),
            FowlFortuneFeaturesTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneFeaturesView.leadingAnchor, constant: 12),
            FowlFortuneFeaturesTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneFeaturesView.trailingAnchor, constant: -12),
            
            FowlFortuneFeaturesStackView.topAnchor.constraint(equalTo: FowlFortuneFeaturesTitleLabel.bottomAnchor, constant: 8),
            FowlFortuneFeaturesStackView.leadingAnchor.constraint(equalTo: FowlFortuneFeaturesView.leadingAnchor, constant: 12),
            FowlFortuneFeaturesStackView.trailingAnchor.constraint(equalTo: FowlFortuneFeaturesView.trailingAnchor, constant: -12),
            FowlFortuneFeaturesStackView.bottomAnchor.constraint(equalTo: FowlFortuneFeaturesView.bottomAnchor, constant: -12)
        ])
        
        return FowlFortuneFeaturesView
    }
    
    private func FowlFortuneCreateCareTipsView(tips: [String]) -> UIView {
        let FowlFortuneCareTipsView = UIView()
        FowlFortuneCareTipsView.backgroundColor = UIColor(red: 0.88, green: 0.94, blue: 0.88, alpha: 1.0)
        FowlFortuneCareTipsView.layer.cornerRadius = 8
        FowlFortuneCareTipsView.translatesAutoresizingMaskIntoConstraints = false
        
        let FowlFortuneCareTipsTitleLabel = UILabel()
        FowlFortuneCareTipsTitleLabel.text = "💡 Care Tips"
        FowlFortuneCareTipsTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        FowlFortuneCareTipsTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneCareTipsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let FowlFortuneCareTipsStackView = UIStackView()
        FowlFortuneCareTipsStackView.axis = .vertical
        FowlFortuneCareTipsStackView.spacing = 6
        FowlFortuneCareTipsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for tip in tips {
            let FowlFortuneTipLabel = UILabel()
            FowlFortuneTipLabel.text = "• " + tip
            FowlFortuneTipLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            FowlFortuneTipLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
            FowlFortuneTipLabel.numberOfLines = 0
            FowlFortuneCareTipsStackView.addArrangedSubview(FowlFortuneTipLabel)
        }
        
        FowlFortuneCareTipsView.addSubview(FowlFortuneCareTipsTitleLabel)
        FowlFortuneCareTipsView.addSubview(FowlFortuneCareTipsStackView)
        
        NSLayoutConstraint.activate([
            FowlFortuneCareTipsTitleLabel.topAnchor.constraint(equalTo: FowlFortuneCareTipsView.topAnchor, constant: 12),
            FowlFortuneCareTipsTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneCareTipsView.leadingAnchor, constant: 12),
            FowlFortuneCareTipsTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneCareTipsView.trailingAnchor, constant: -12),
            
            FowlFortuneCareTipsStackView.topAnchor.constraint(equalTo: FowlFortuneCareTipsTitleLabel.bottomAnchor, constant: 8),
            FowlFortuneCareTipsStackView.leadingAnchor.constraint(equalTo: FowlFortuneCareTipsView.leadingAnchor, constant: 12),
            FowlFortuneCareTipsStackView.trailingAnchor.constraint(equalTo: FowlFortuneCareTipsView.trailingAnchor, constant: -12),
            FowlFortuneCareTipsStackView.bottomAnchor.constraint(equalTo: FowlFortuneCareTipsView.bottomAnchor, constant: -12)
        ])
        
        return FowlFortuneCareTipsView
    }
    
    @objc private func FowlFortuneCloseButtonTapped() {
        dismiss(animated: true)
    }
}
