import UIKit

class FowlFortuneFarmViewController: UIViewController {
    
    private let FowlFortuneViewModel = FowlFortuneFarmViewModel()
    
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
    
    private lazy var FowlFortuneHeaderView: UIView = {
        let FowlFortuneHeaderView = UIView()
        FowlFortuneHeaderView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneHeaderView.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneHeaderView.layer.cornerRadius = 12
        FowlFortuneHeaderView.layer.shadowOpacity = 0.15
        FowlFortuneHeaderView.layer.shadowRadius = 6
        FowlFortuneHeaderView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return FowlFortuneHeaderView
    }()
    
    private lazy var FowlFortuneTitleLabel: UILabel = {
        let FowlFortuneTitleLabel = UILabel()
        FowlFortuneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneTitleLabel.text = "🐔 FowlFortune Farm 🐔"
        FowlFortuneTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        FowlFortuneTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneTitleLabel.textAlignment = .center
        return FowlFortuneTitleLabel
    }()
    
    private lazy var FowlFortuneEggsLabel: UILabel = {
        let FowlFortuneEggsLabel = UILabel()
        FowlFortuneEggsLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneEggsLabel.text = "🥚 Eggs: 0"
        FowlFortuneEggsLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        FowlFortuneEggsLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        return FowlFortuneEggsLabel
    }()
    
    private lazy var FowlFortuneCreditsLabel: UILabel = {
        let FowlFortuneCreditsLabel = UILabel()
        FowlFortuneCreditsLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneCreditsLabel.text = "💰 Credits: 100"
        FowlFortuneCreditsLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        FowlFortuneCreditsLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        return FowlFortuneCreditsLabel
    }()
    
    private lazy var FowlFortuneActionButtonsStackView: UIStackView = {
        let FowlFortuneStackView = UIStackView()
        FowlFortuneStackView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneStackView.axis = .vertical
        FowlFortuneStackView.spacing = 12
        FowlFortuneStackView.distribution = .fillEqually
        return FowlFortuneStackView
    }()
    
    private lazy var FowlFortuneFeedChickensButton: UIButton = {
        let FowlFortuneButton = UIButton(type: .system)
        FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneButton.setTitle("🌾 Feed Chickens", for: .normal)
        FowlFortuneButton.backgroundColor = UIColor(red: 0.85, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneButton.setTitleColor(UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0), for: .normal)
        FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        FowlFortuneButton.layer.cornerRadius = 12
        FowlFortuneButton.layer.shadowOpacity = 0.15
        FowlFortuneButton.layer.shadowRadius = 6
        FowlFortuneButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneButton.addTarget(self, action: #selector(FowlFortuneFeedChickensButtonTapped), for: .touchUpInside)
        return FowlFortuneButton
    }()
    
    private lazy var FowlFortuneCollectEggsButton: UIButton = {
        let FowlFortuneButton = UIButton(type: .system)
        FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneButton.setTitle("🥚 Collect Eggs", for: .normal)
        FowlFortuneButton.backgroundColor = UIColor(red: 0.85, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneButton.setTitleColor(UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0), for: .normal)
        FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        FowlFortuneButton.layer.cornerRadius = 12
        FowlFortuneButton.layer.shadowOpacity = 0.15
        FowlFortuneButton.layer.shadowRadius = 6
        FowlFortuneButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneButton.addTarget(self, action: #selector(FowlFortuneCollectEggsButtonTapped), for: .touchUpInside)
        return FowlFortuneButton
    }()
    
    private lazy var FowlFortuneBuyChickenButton: UIButton = {
        let FowlFortuneButton = UIButton(type: .system)
        FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneButton.setTitle("🐔 Buy Chicken", for: .normal)
        FowlFortuneButton.backgroundColor = UIColor(red: 0.85, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneButton.setTitleColor(UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0), for: .normal)
        FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        FowlFortuneButton.layer.cornerRadius = 12
        FowlFortuneButton.layer.shadowOpacity = 0.15
        FowlFortuneButton.layer.shadowRadius = 6
        FowlFortuneButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneButton.addTarget(self, action: #selector(FowlFortuneBuyChickenButtonTapped), for: .touchUpInside)
        return FowlFortuneButton
    }()
    
    private lazy var FowlFortuneTicTacToeButton: UIButton = {
        let FowlFortuneButton = UIButton(type: .system)
        FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneButton.setTitle("🎮 Tic Tac Toe", for: .normal)
        FowlFortuneButton.backgroundColor = UIColor(red: 0.85, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneButton.setTitleColor(UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0), for: .normal)
        FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        FowlFortuneButton.layer.cornerRadius = 12
        FowlFortuneButton.layer.shadowOpacity = 0.15
        FowlFortuneButton.layer.shadowRadius = 6
        FowlFortuneButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneButton.addTarget(self, action: #selector(FowlFortuneTicTacToeButtonTapped), for: .touchUpInside)
        return FowlFortuneButton
    }()
    
    private lazy var FowlFortuneShopButton: UIButton = {
        let FowlFortuneButton = UIButton(type: .system)
        FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneButton.setTitle("🛒 Shop", for: .normal)
        FowlFortuneButton.backgroundColor = UIColor(red: 0.9, green: 0.85, blue: 0.9, alpha: 1.0)
        FowlFortuneButton.setTitleColor(UIColor(red: 0.6, green: 0.2, blue: 0.6, alpha: 1.0), for: .normal)
        FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        FowlFortuneButton.layer.cornerRadius = 12
        FowlFortuneButton.layer.shadowOpacity = 0.2
        FowlFortuneButton.layer.shadowRadius = 8
        FowlFortuneButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        FowlFortuneButton.layer.borderWidth = 2
        FowlFortuneButton.layer.borderColor = UIColor(red: 0.8, green: 0.4, blue: 0.8, alpha: 1.0).cgColor
        FowlFortuneButton.addTarget(self, action: #selector(FowlFortuneShopButtonTapped), for: .touchUpInside)
        return FowlFortuneButton
    }()
    
    private lazy var FowlFortuneFarmStatsView: UIView = {
        let FowlFortuneStatsView = UIView()
        FowlFortuneStatsView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneStatsView.backgroundColor = UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0)
        FowlFortuneStatsView.layer.cornerRadius = 12
        FowlFortuneStatsView.layer.shadowOpacity = 0.15
        FowlFortuneStatsView.layer.shadowRadius = 6
        FowlFortuneStatsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return FowlFortuneStatsView
    }()
    
    private lazy var FowlFortuneStatsLabel: UILabel = {
        let FowlFortuneStatsLabel = UILabel()
        FowlFortuneStatsLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneStatsLabel.text = "Farm Statistics"
        FowlFortuneStatsLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        FowlFortuneStatsLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneStatsLabel.textAlignment = .center
        return FowlFortuneStatsLabel
    }()
    
    private lazy var FowlFortuneChickensCountLabel: UILabel = {
        let FowlFortuneLabel = UILabel()
        FowlFortuneLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLabel.text = "🐔 Chickens: 0"
        FowlFortuneLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        FowlFortuneLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        return FowlFortuneLabel
    }()
    
    private lazy var FowlFortuneBuildingsCountLabel: UILabel = {
        let FowlFortuneLabel = UILabel()
        FowlFortuneLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLabel.text = "🏠 Buildings: 0"
        FowlFortuneLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        FowlFortuneLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        return FowlFortuneLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFowlFortuneUI()
        setupFowlFortuneViewModel()
    }
    
    private func setupFowlFortuneUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        
        view.addSubview(FowlFortuneScrollView)
        FowlFortuneScrollView.addSubview(FowlFortuneContentView)
        
        FowlFortuneContentView.addSubview(FowlFortuneHeaderView)
        FowlFortuneContentView.addSubview(FowlFortuneActionButtonsStackView)
        FowlFortuneContentView.addSubview(FowlFortuneFarmStatsView)
        
        FowlFortuneHeaderView.addSubview(FowlFortuneTitleLabel)
        FowlFortuneHeaderView.addSubview(FowlFortuneEggsLabel)
        FowlFortuneHeaderView.addSubview(FowlFortuneCreditsLabel)
        
        FowlFortuneActionButtonsStackView.addArrangedSubview(FowlFortuneFeedChickensButton)
        FowlFortuneActionButtonsStackView.addArrangedSubview(FowlFortuneCollectEggsButton)
        FowlFortuneActionButtonsStackView.addArrangedSubview(FowlFortuneBuyChickenButton)
        FowlFortuneActionButtonsStackView.addArrangedSubview(FowlFortuneTicTacToeButton)
        FowlFortuneActionButtonsStackView.addArrangedSubview(FowlFortuneShopButton)
        
        FowlFortuneFarmStatsView.addSubview(FowlFortuneStatsLabel)
        FowlFortuneFarmStatsView.addSubview(FowlFortuneChickensCountLabel)
        FowlFortuneFarmStatsView.addSubview(FowlFortuneBuildingsCountLabel)
        
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
            
            FowlFortuneHeaderView.topAnchor.constraint(equalTo: FowlFortuneContentView.topAnchor, constant: 20),
            FowlFortuneHeaderView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneHeaderView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            FowlFortuneHeaderView.heightAnchor.constraint(equalToConstant: 120),
            
            FowlFortuneTitleLabel.topAnchor.constraint(equalTo: FowlFortuneHeaderView.topAnchor, constant: 16),
            FowlFortuneTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneHeaderView.leadingAnchor, constant: 16),
            FowlFortuneTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneHeaderView.trailingAnchor, constant: -16),
            
            FowlFortuneEggsLabel.topAnchor.constraint(equalTo: FowlFortuneTitleLabel.bottomAnchor, constant: 12),
            FowlFortuneEggsLabel.leadingAnchor.constraint(equalTo: FowlFortuneHeaderView.leadingAnchor, constant: 16),
            
            FowlFortuneCreditsLabel.topAnchor.constraint(equalTo: FowlFortuneEggsLabel.bottomAnchor, constant: 8),
            FowlFortuneCreditsLabel.leadingAnchor.constraint(equalTo: FowlFortuneHeaderView.leadingAnchor, constant: 16),
            
            FowlFortuneActionButtonsStackView.topAnchor.constraint(equalTo: FowlFortuneHeaderView.bottomAnchor, constant: 20),
            FowlFortuneActionButtonsStackView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneActionButtonsStackView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            
            FowlFortuneFeedChickensButton.heightAnchor.constraint(equalToConstant: 50),
            FowlFortuneCollectEggsButton.heightAnchor.constraint(equalToConstant: 50),
            FowlFortuneBuyChickenButton.heightAnchor.constraint(equalToConstant: 50),
            FowlFortuneTicTacToeButton.heightAnchor.constraint(equalToConstant: 50),
            FowlFortuneShopButton.heightAnchor.constraint(equalToConstant: 50),
            
            FowlFortuneFarmStatsView.topAnchor.constraint(equalTo: FowlFortuneActionButtonsStackView.bottomAnchor, constant: 20),
            FowlFortuneFarmStatsView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneFarmStatsView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            FowlFortuneFarmStatsView.heightAnchor.constraint(equalToConstant: 120),
            FowlFortuneFarmStatsView.bottomAnchor.constraint(equalTo: FowlFortuneContentView.bottomAnchor, constant: -20),
            
            FowlFortuneStatsLabel.topAnchor.constraint(equalTo: FowlFortuneFarmStatsView.topAnchor, constant: 16),
            FowlFortuneStatsLabel.leadingAnchor.constraint(equalTo: FowlFortuneFarmStatsView.leadingAnchor, constant: 16),
            FowlFortuneStatsLabel.trailingAnchor.constraint(equalTo: FowlFortuneFarmStatsView.trailingAnchor, constant: -16),
            
            FowlFortuneChickensCountLabel.topAnchor.constraint(equalTo: FowlFortuneStatsLabel.bottomAnchor, constant: 12),
            FowlFortuneChickensCountLabel.leadingAnchor.constraint(equalTo: FowlFortuneFarmStatsView.leadingAnchor, constant: 16),
            
            FowlFortuneBuildingsCountLabel.topAnchor.constraint(equalTo: FowlFortuneChickensCountLabel.bottomAnchor, constant: 8),
            FowlFortuneBuildingsCountLabel.leadingAnchor.constraint(equalTo: FowlFortuneFarmStatsView.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupFowlFortuneViewModel() {
        FowlFortuneViewModel.FowlFortuneFarmUpdateCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.updateFowlFortuneUI()
            }
        }
        
        FowlFortuneViewModel.FowlFortuneBuildingIncomeCallback = { [weak self] income in
            DispatchQueue.main.async {
                self?.FowlFortuneShowBuildingIncome(income: income)
            }
        }
        
        updateFowlFortuneUI()
    }
    
    private func updateFowlFortuneUI() {
        let FowlFortuneFarmData = FowlFortuneViewModel.FowlFortuneFarmData
        
        FowlFortuneEggsLabel.text = "🥚 Eggs: \(FowlFortuneFarmData.FowlFortuneTotalEggs)"
        FowlFortuneCreditsLabel.text = "💰 Credits: \(FowlFortuneFarmData.FowlFortuneTotalCredits)"
        FowlFortuneChickensCountLabel.text = "🐔 Chickens: \(FowlFortuneFarmData.FowlFortuneChickens.count)"
        FowlFortuneBuildingsCountLabel.text = "🏠 Buildings: \(FowlFortuneFarmData.FowlFortuneBuildings.count)"
    }
    
    private func FowlFortuneShowBuildingIncome(income: Int) {
        let FowlFortuneIncomeLabel = UILabel()
        FowlFortuneIncomeLabel.text = "+💰\(income)"
        FowlFortuneIncomeLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        FowlFortuneIncomeLabel.textColor = UIColor(red: 0.0, green: 0.7, blue: 0.0, alpha: 1.0)
        FowlFortuneIncomeLabel.textAlignment = .center
        FowlFortuneIncomeLabel.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        FowlFortuneIncomeLabel.layer.cornerRadius = 8
        FowlFortuneIncomeLabel.layer.borderWidth = 2
        FowlFortuneIncomeLabel.layer.borderColor = UIColor(red: 0.0, green: 0.7, blue: 0.0, alpha: 1.0).cgColor
        FowlFortuneIncomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(FowlFortuneIncomeLabel)
        
        NSLayoutConstraint.activate([
            FowlFortuneIncomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            FowlFortuneIncomeLabel.topAnchor.constraint(equalTo: FowlFortuneHeaderView.bottomAnchor, constant: 20),
            FowlFortuneIncomeLabel.widthAnchor.constraint(equalToConstant: 100),
            FowlFortuneIncomeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Анимация появления и исчезновения
        FowlFortuneIncomeLabel.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            FowlFortuneIncomeLabel.alpha = 1
            FowlFortuneIncomeLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 1.0, options: [], animations: {
                FowlFortuneIncomeLabel.alpha = 0
                FowlFortuneIncomeLabel.transform = CGAffineTransform(translationX: 0, y: -50)
            }) { _ in
                FowlFortuneIncomeLabel.removeFromSuperview()
            }
        }
    }
    
    @objc private func FowlFortuneFeedChickensButtonTapped() {
        FowlFortuneViewModel.FowlFortuneFeedChickens()
        showFowlFortuneNotification(title: "Chickens Fed! 🌾", message: "Your chickens are now happier and healthier!", icon: "🌾")
    }
    
    @objc private func FowlFortuneCollectEggsButtonTapped() {
        let FowlFortuneCollectedEggs = FowlFortuneViewModel.FowlFortuneCollectEggs()
        updateFowlFortuneUI()
        showFowlFortuneNotification(title: "Eggs Collected! 🥚", message: "You collected \(FowlFortuneCollectedEggs) eggs and earned \(FowlFortuneCollectedEggs) credits!", icon: "🥚")
    }
    
    @objc private func FowlFortuneBuyChickenButtonTapped() {
        let FowlFortuneBuyChickenViewController = FowlFortuneBuyChickenViewController(
            onChickenSelected: { [weak self] FowlFortuneChickenType in
                if self?.FowlFortuneViewModel.FowlFortuneBuyChicken(FowlFortuneChickenType) == true {
                    self?.updateFowlFortuneUI()
                    self?.showFowlFortuneNotification(title: "Chicken Purchased! 🐔", message: "You bought a \(FowlFortuneChickenType.rawValue)!", icon: "🐔")
                } else {
                    self?.showFowlFortuneNotification(title: "Not Enough Credits 💰", message: "You need \(FowlFortuneChickenType.FowlFortuneChickenCost) credits to buy this chicken.", icon: "💰")
                }
            },
            onCancel: nil
        )
        
        present(FowlFortuneBuyChickenViewController, animated: true)
    }
    
    @objc private func FowlFortuneTicTacToeButtonTapped() {
        let FowlFortuneTicTacToeViewController = FowlFortuneTicTacToeViewController()
        FowlFortuneTicTacToeViewController.modalPresentationStyle = .pageSheet
        FowlFortuneTicTacToeViewController.modalTransitionStyle = .coverVertical
        present(FowlFortuneTicTacToeViewController, animated: true)
    }
    
    @objc private func FowlFortuneShopButtonTapped() {
        let FowlFortuneShopViewController = FowlFortuneShopViewController()
        FowlFortuneShopViewController.modalPresentationStyle = .pageSheet
        FowlFortuneShopViewController.modalTransitionStyle = .coverVertical
        present(FowlFortuneShopViewController, animated: true)
    }
    
    private func showFowlFortuneNotification(title: String, message: String, icon: String) {
        let FowlFortuneNotificationViewController = FowlFortuneNotificationViewController(
            title: title,
            message: message,
            icon: icon
        )
        
        present(FowlFortuneNotificationViewController, animated: true)
    }
    
    private func showFowlFortuneAlert(title: String, message: String) {
        let FowlFortuneAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        FowlFortuneAlert.addAction(UIAlertAction(title: "OK", style: .default))
        present(FowlFortuneAlert, animated: true)
    }
}
