import UIKit

class FowlFortuneSettingsViewController: UIViewController {
    
    private let FowlFortuneViewModel = FowlFortuneSettingsViewModel()
    
    private lazy var FowlFortuneScrollView: UIScrollView = {
        let FowlFortuneScrollView = UIScrollView()
        FowlFortuneScrollView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneScrollView.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        return FowlFortuneScrollView
    }()
    
    private lazy var FowlFortuneContentView: UIView = {
        let FowlFortuneContentView = UIView()
        FowlFortuneContentView.translatesAutoresizingMaskIntoConstraints = false
        return FowlFortuneContentView
    }()
    
    private lazy var FowlFortuneFarmBotSectionView: UIView = {
        let FowlFortuneSectionView = UIView()
        FowlFortuneSectionView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneSectionView.backgroundColor = UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0)
        FowlFortuneSectionView.layer.cornerRadius = 12
        FowlFortuneSectionView.layer.shadowOpacity = 0.15
        FowlFortuneSectionView.layer.shadowRadius = 6
        FowlFortuneSectionView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return FowlFortuneSectionView
    }()
    
    private lazy var FowlFortuneFarmBotTitleLabel: UILabel = {
        let FowlFortuneTitleLabel = UILabel()
        FowlFortuneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneTitleLabel.text = "🤖 FarmBot Mode"
        FowlFortuneTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        FowlFortuneTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        return FowlFortuneTitleLabel
    }()
    
    private lazy var FowlFortuneFarmBotSegmentedControl: UISegmentedControl = {
        let FowlFortuneSegmentedControl = UISegmentedControl(items: ["Support", "Neutral", "Silent"])
        FowlFortuneSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneSegmentedControl.backgroundColor = UIColor(red: 0.85, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneSegmentedControl.selectedSegmentTintColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)], for: .normal)
        FowlFortuneSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        FowlFortuneSegmentedControl.addTarget(self, action: #selector(FowlFortuneFarmBotModeChanged), for: .valueChanged)
        return FowlFortuneSegmentedControl
    }()
    
    private lazy var FowlFortuneFarmBotDescriptionLabel: UILabel = {
        let FowlFortuneDescriptionLabel = UILabel()
        FowlFortuneDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneDescriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        FowlFortuneDescriptionLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 0.8)
        FowlFortuneDescriptionLabel.numberOfLines = 0
        return FowlFortuneDescriptionLabel
    }()
    
    private lazy var FowlFortuneStatsSectionView: UIView = {
        let FowlFortuneSectionView = UIView()
        FowlFortuneSectionView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneSectionView.backgroundColor = UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0)
        FowlFortuneSectionView.layer.cornerRadius = 12
        FowlFortuneSectionView.layer.shadowOpacity = 0.15
        FowlFortuneSectionView.layer.shadowRadius = 6
        FowlFortuneSectionView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return FowlFortuneSectionView
    }()
    
    private lazy var FowlFortuneStatsTitleLabel: UILabel = {
        let FowlFortuneTitleLabel = UILabel()
        FowlFortuneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneTitleLabel.text = "📊 Game Statistics"
        FowlFortuneTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        FowlFortuneTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        return FowlFortuneTitleLabel
    }()
    
    private lazy var FowlFortuneEggsCollectedLabel: UILabel = {
        let FowlFortuneLabel = UILabel()
        FowlFortuneLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        FowlFortuneLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        return FowlFortuneLabel
    }()
    
    private lazy var FowlFortuneBuildingsBuiltLabel: UILabel = {
        let FowlFortuneLabel = UILabel()
        FowlFortuneLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        FowlFortuneLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        return FowlFortuneLabel
    }()
    
    private lazy var FowlFortuneDefensesSuccessfulLabel: UILabel = {
        let FowlFortuneLabel = UILabel()
        FowlFortuneLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        FowlFortuneLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        return FowlFortuneLabel
    }()
    
    private lazy var FowlFortunePlayTimeLabel: UILabel = {
        let FowlFortuneLabel = UILabel()
        FowlFortuneLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        FowlFortuneLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        return FowlFortuneLabel
    }()
    
    private lazy var FowlFortuneActionsSectionView: UIView = {
        let FowlFortuneSectionView = UIView()
        FowlFortuneSectionView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneSectionView.backgroundColor = UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0)
        FowlFortuneSectionView.layer.cornerRadius = 12
        FowlFortuneSectionView.layer.shadowOpacity = 0.15
        FowlFortuneSectionView.layer.shadowRadius = 6
        FowlFortuneSectionView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return FowlFortuneSectionView
    }()
    
    private lazy var FowlFortuneActionsTitleLabel: UILabel = {
        let FowlFortuneTitleLabel = UILabel()
        FowlFortuneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneTitleLabel.text = "⚙️ Actions"
        FowlFortuneTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        FowlFortuneTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        return FowlFortuneTitleLabel
    }()
    
    private lazy var FowlFortuneResetDataButton: UIButton = {
        let FowlFortuneButton = UIButton(type: .system)
        FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneButton.setTitle("🗑️ Reset All Data", for: .normal)
        FowlFortuneButton.backgroundColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
        FowlFortuneButton.setTitleColor(.white, for: .normal)
        FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        FowlFortuneButton.layer.cornerRadius = 12
        FowlFortuneButton.layer.shadowOpacity = 0.15
        FowlFortuneButton.layer.shadowRadius = 6
        FowlFortuneButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneButton.addTarget(self, action: #selector(FowlFortuneResetDataButtonTapped), for: .touchUpInside)
        return FowlFortuneButton
    }()
    
    private lazy var FowlFortunePrivacyButton: UIButton = {
        let FowlFortuneButton = UIButton(type: .system)
        FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneButton.setTitle("🔒 Privacy Policy", for: .normal)
        FowlFortuneButton.backgroundColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneButton.setTitleColor(.white, for: .normal)
        FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        FowlFortuneButton.layer.cornerRadius = 12
        FowlFortuneButton.layer.shadowOpacity = 0.15
        FowlFortuneButton.layer.shadowRadius = 6
        FowlFortuneButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneButton.addTarget(self, action: #selector(FowlFortunePrivacyButtonTapped), for: .touchUpInside)
        return FowlFortuneButton
    }()
    
    private lazy var FowlFortuneTermsButton: UIButton = {
        let FowlFortuneButton = UIButton(type: .system)
        FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneButton.setTitle("📄 Terms of Service", for: .normal)
        FowlFortuneButton.backgroundColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneButton.setTitleColor(.white, for: .normal)
        FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        FowlFortuneButton.layer.cornerRadius = 12
        FowlFortuneButton.layer.shadowOpacity = 0.15
        FowlFortuneButton.layer.shadowRadius = 6
        FowlFortuneButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneButton.addTarget(self, action: #selector(FowlFortuneTermsButtonTapped), for: .touchUpInside)
        return FowlFortuneButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFowlFortuneUI()
        setupFowlFortuneViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FowlFortuneViewModel.FowlFortuneLoadSettings()
    }
    
    private func setupFowlFortuneUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        title = "⚙️ Settings"
        
        view.addSubview(FowlFortuneScrollView)
        FowlFortuneScrollView.addSubview(FowlFortuneContentView)
        
        FowlFortuneContentView.addSubview(FowlFortuneFarmBotSectionView)
        FowlFortuneContentView.addSubview(FowlFortuneStatsSectionView)
        FowlFortuneContentView.addSubview(FowlFortuneActionsSectionView)
        
        FowlFortuneFarmBotSectionView.addSubview(FowlFortuneFarmBotTitleLabel)
        FowlFortuneFarmBotSectionView.addSubview(FowlFortuneFarmBotSegmentedControl)
        FowlFortuneFarmBotSectionView.addSubview(FowlFortuneFarmBotDescriptionLabel)
        
        FowlFortuneStatsSectionView.addSubview(FowlFortuneStatsTitleLabel)
        FowlFortuneStatsSectionView.addSubview(FowlFortuneEggsCollectedLabel)
        FowlFortuneStatsSectionView.addSubview(FowlFortuneBuildingsBuiltLabel)
        FowlFortuneStatsSectionView.addSubview(FowlFortuneDefensesSuccessfulLabel)
        FowlFortuneStatsSectionView.addSubview(FowlFortunePlayTimeLabel)
        
        FowlFortuneActionsSectionView.addSubview(FowlFortuneActionsTitleLabel)
        FowlFortuneActionsSectionView.addSubview(FowlFortuneResetDataButton)
        FowlFortuneActionsSectionView.addSubview(FowlFortunePrivacyButton)
        FowlFortuneActionsSectionView.addSubview(FowlFortuneTermsButton)
        
        setupFowlFortuneConstraints()
    }
    
    private func setupFowlFortuneConstraints() {
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
            
            FowlFortuneFarmBotSectionView.topAnchor.constraint(equalTo: FowlFortuneContentView.topAnchor, constant: 20),
            FowlFortuneFarmBotSectionView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneFarmBotSectionView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            FowlFortuneFarmBotSectionView.heightAnchor.constraint(equalToConstant: 140),
            
            FowlFortuneFarmBotTitleLabel.topAnchor.constraint(equalTo: FowlFortuneFarmBotSectionView.topAnchor, constant: 16),
            FowlFortuneFarmBotTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneFarmBotSectionView.leadingAnchor, constant: 16),
            FowlFortuneFarmBotTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneFarmBotSectionView.trailingAnchor, constant: -16),
            
            FowlFortuneFarmBotSegmentedControl.topAnchor.constraint(equalTo: FowlFortuneFarmBotTitleLabel.bottomAnchor, constant: 12),
            FowlFortuneFarmBotSegmentedControl.leadingAnchor.constraint(equalTo: FowlFortuneFarmBotSectionView.leadingAnchor, constant: 16),
            FowlFortuneFarmBotSegmentedControl.trailingAnchor.constraint(equalTo: FowlFortuneFarmBotSectionView.trailingAnchor, constant: -16),
            
            FowlFortuneFarmBotDescriptionLabel.topAnchor.constraint(equalTo: FowlFortuneFarmBotSegmentedControl.bottomAnchor, constant: 8),
            FowlFortuneFarmBotDescriptionLabel.leadingAnchor.constraint(equalTo: FowlFortuneFarmBotSectionView.leadingAnchor, constant: 16),
            FowlFortuneFarmBotDescriptionLabel.trailingAnchor.constraint(equalTo: FowlFortuneFarmBotSectionView.trailingAnchor, constant: -16),
            
            FowlFortuneStatsSectionView.topAnchor.constraint(equalTo: FowlFortuneFarmBotSectionView.bottomAnchor, constant: 20),
            FowlFortuneStatsSectionView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneStatsSectionView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            FowlFortuneStatsSectionView.heightAnchor.constraint(equalToConstant: 160),
            
            FowlFortuneStatsTitleLabel.topAnchor.constraint(equalTo: FowlFortuneStatsSectionView.topAnchor, constant: 16),
            FowlFortuneStatsTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneStatsSectionView.leadingAnchor, constant: 16),
            FowlFortuneStatsTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneStatsSectionView.trailingAnchor, constant: -16),
            
            FowlFortuneEggsCollectedLabel.topAnchor.constraint(equalTo: FowlFortuneStatsTitleLabel.bottomAnchor, constant: 12),
            FowlFortuneEggsCollectedLabel.leadingAnchor.constraint(equalTo: FowlFortuneStatsSectionView.leadingAnchor, constant: 16),
            FowlFortuneEggsCollectedLabel.trailingAnchor.constraint(equalTo: FowlFortuneStatsSectionView.trailingAnchor, constant: -16),
            
            FowlFortuneBuildingsBuiltLabel.topAnchor.constraint(equalTo: FowlFortuneEggsCollectedLabel.bottomAnchor, constant: 8),
            FowlFortuneBuildingsBuiltLabel.leadingAnchor.constraint(equalTo: FowlFortuneStatsSectionView.leadingAnchor, constant: 16),
            FowlFortuneBuildingsBuiltLabel.trailingAnchor.constraint(equalTo: FowlFortuneStatsSectionView.trailingAnchor, constant: -16),
            
            FowlFortuneDefensesSuccessfulLabel.topAnchor.constraint(equalTo: FowlFortuneBuildingsBuiltLabel.bottomAnchor, constant: 8),
            FowlFortuneDefensesSuccessfulLabel.leadingAnchor.constraint(equalTo: FowlFortuneStatsSectionView.leadingAnchor, constant: 16),
            FowlFortuneDefensesSuccessfulLabel.trailingAnchor.constraint(equalTo: FowlFortuneStatsSectionView.trailingAnchor, constant: -16),
            
            FowlFortunePlayTimeLabel.topAnchor.constraint(equalTo: FowlFortuneDefensesSuccessfulLabel.bottomAnchor, constant: 8),
            FowlFortunePlayTimeLabel.leadingAnchor.constraint(equalTo: FowlFortuneStatsSectionView.leadingAnchor, constant: 16),
            FowlFortunePlayTimeLabel.trailingAnchor.constraint(equalTo: FowlFortuneStatsSectionView.trailingAnchor, constant: -16),
            
            FowlFortuneActionsSectionView.topAnchor.constraint(equalTo: FowlFortuneStatsSectionView.bottomAnchor, constant: 20),
            FowlFortuneActionsSectionView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneActionsSectionView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            FowlFortuneActionsSectionView.heightAnchor.constraint(equalToConstant: 200),
            FowlFortuneActionsSectionView.bottomAnchor.constraint(equalTo: FowlFortuneContentView.bottomAnchor, constant: -20),
            
            FowlFortuneActionsTitleLabel.topAnchor.constraint(equalTo: FowlFortuneActionsSectionView.topAnchor, constant: 16),
            FowlFortuneActionsTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneActionsSectionView.leadingAnchor, constant: 16),
            FowlFortuneActionsTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneActionsSectionView.trailingAnchor, constant: -16),
            
            FowlFortuneResetDataButton.topAnchor.constraint(equalTo: FowlFortuneActionsTitleLabel.bottomAnchor, constant: 16),
            FowlFortuneResetDataButton.leadingAnchor.constraint(equalTo: FowlFortuneActionsSectionView.leadingAnchor, constant: 16),
            FowlFortuneResetDataButton.trailingAnchor.constraint(equalTo: FowlFortuneActionsSectionView.trailingAnchor, constant: -16),
            FowlFortuneResetDataButton.heightAnchor.constraint(equalToConstant: 44),
            
            FowlFortunePrivacyButton.topAnchor.constraint(equalTo: FowlFortuneResetDataButton.bottomAnchor, constant: 12),
            FowlFortunePrivacyButton.leadingAnchor.constraint(equalTo: FowlFortuneActionsSectionView.leadingAnchor, constant: 16),
            FowlFortunePrivacyButton.trailingAnchor.constraint(equalTo: FowlFortuneActionsSectionView.trailingAnchor, constant: -16),
            FowlFortunePrivacyButton.heightAnchor.constraint(equalToConstant: 44),
            
            FowlFortuneTermsButton.topAnchor.constraint(equalTo: FowlFortunePrivacyButton.bottomAnchor, constant: 12),
            FowlFortuneTermsButton.leadingAnchor.constraint(equalTo: FowlFortuneActionsSectionView.leadingAnchor, constant: 16),
            FowlFortuneTermsButton.trailingAnchor.constraint(equalTo: FowlFortuneActionsSectionView.trailingAnchor, constant: -16),
            FowlFortuneTermsButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupFowlFortuneViewModel() {
        FowlFortuneViewModel.FowlFortuneSettingsUpdateCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.updateFowlFortuneUI()
            }
        }
    }
    
    private func updateFowlFortuneUI() {
        let FowlFortuneCurrentBotMode = FowlFortuneViewModel.FowlFortuneCurrentBotModeValue
        
        switch FowlFortuneCurrentBotMode {
        case .FowlFortuneSupportMode:
            FowlFortuneFarmBotSegmentedControl.selectedSegmentIndex = 0
        case .FowlFortuneNeutralMode:
            FowlFortuneFarmBotSegmentedControl.selectedSegmentIndex = 1
        case .FowlFortuneSilentMode:
            FowlFortuneFarmBotSegmentedControl.selectedSegmentIndex = 2
        }
        
        FowlFortuneFarmBotDescriptionLabel.text = FowlFortuneViewModel.FowlFortuneGetBotModeDescription(for: FowlFortuneCurrentBotMode)
        
        FowlFortuneEggsCollectedLabel.text = "🥚 Total Eggs Collected: \(FowlFortuneViewModel.FowlFortuneTotalEggsCollected)"
        FowlFortuneBuildingsBuiltLabel.text = "🏠 Total Buildings Built: \(FowlFortuneViewModel.FowlFortuneTotalBuildingsBuilt)"
        FowlFortuneDefensesSuccessfulLabel.text = "🛡️ Successful Defenses: \(FowlFortuneViewModel.FowlFortuneTotalDefensesSuccessful)"
        FowlFortunePlayTimeLabel.text = "⏱️ Total Play Time: \(FowlFortuneViewModel.FowlFortuneTotalPlayTime)"
    }
    
    @objc private func FowlFortuneFarmBotModeChanged() {
        let FowlFortuneSelectedMode: FowlFortuneFarmBotMode
        
        switch FowlFortuneFarmBotSegmentedControl.selectedSegmentIndex {
        case 0:
            FowlFortuneSelectedMode = .FowlFortuneSupportMode
        case 1:
            FowlFortuneSelectedMode = .FowlFortuneNeutralMode
        case 2:
            FowlFortuneSelectedMode = .FowlFortuneSilentMode
        default:
            FowlFortuneSelectedMode = .FowlFortuneNeutralMode
        }
        
        FowlFortuneViewModel.FowlFortuneUpdateBotMode(FowlFortuneSelectedMode)
    }
    
    @objc private func FowlFortuneResetDataButtonTapped() {
        let FowlFortuneAlert = UIAlertController(title: "Reset All Data 🗑️", message: "This will permanently delete all your farm data, progress, and achievements. This action cannot be undone.", preferredStyle: .alert)
        
        FowlFortuneAlert.addAction(UIAlertAction(title: "Reset", style: .destructive) { [weak self] _ in
            self?.FowlFortuneViewModel.FowlFortuneResetAllData()
            self?.showFowlFortuneAlert(title: "Data Reset 🔄", message: "All data has been reset. Your farm is now fresh and ready for new adventures!")
        })
        
        FowlFortuneAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(FowlFortuneAlert, animated: true)
    }
    
    @objc private func FowlFortunePrivacyButtonTapped() {
        FowlFortuneViewModel.FowlFortuneShowPrivacyPolicy()
    }
    
    @objc private func FowlFortuneTermsButtonTapped() {
        FowlFortuneViewModel.FowlFortuneShowTermsOfService()
    }
    
    private func showFowlFortuneAlert(title: String, message: String) {
        let FowlFortuneAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        FowlFortuneAlert.addAction(UIAlertAction(title: "OK", style: .default))
        present(FowlFortuneAlert, animated: true)
    }
}
