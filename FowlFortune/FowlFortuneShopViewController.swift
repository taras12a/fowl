import UIKit

class FowlFortuneShopViewController: UIViewController {
    
    let FowlFortuneShopViewModelInstance = FowlFortuneShopViewModel()
    private var FowlFortuneUpgradesCollectionView: UICollectionView!
    private var FowlFortuneCreditsLabel: UILabel!
    private var FowlFortunePassiveIncomeLabel: UILabel!
    private var FowlFortuneCloseButton: UIButton!
    private var FowlFortuneShopTitleLabel: UILabel!
    private var FowlFortuneBackgroundView: UIView!
    private var FowlFortuneContainerView: UIView!
    private var FowlFortuneDragIndicator: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FowlFortuneSetupUI()
        FowlFortuneSetupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FowlFortuneShopViewModelInstance.FowlFortuneLoadShopData()
        FowlFortuneUpdateUI()
    }
    
    private func FowlFortuneSetupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        FowlFortuneSetupBackgroundView()
        FowlFortuneSetupContainerView()
        FowlFortuneSetupDragIndicator()
        FowlFortuneSetupTitle()
        FowlFortuneSetupCreditsSection()
        FowlFortuneSetupCollectionView()
        FowlFortuneSetupCloseButton()
        FowlFortuneSetupConstraints()
    }
    
    private func FowlFortuneSetupBackgroundView() {
        FowlFortuneBackgroundView = UIView()
        FowlFortuneBackgroundView.backgroundColor = UIColor.clear
        FowlFortuneBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        let FowlFortuneTapGesture = UITapGestureRecognizer(target: self, action: #selector(FowlFortuneBackgroundTapped))
        FowlFortuneBackgroundView.addGestureRecognizer(FowlFortuneTapGesture)
        
        let FowlFortuneSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(FowlFortuneSwipeDown))
        FowlFortuneSwipeGesture.direction = .down
        FowlFortuneBackgroundView.addGestureRecognizer(FowlFortuneSwipeGesture)
        
        view.addSubview(FowlFortuneBackgroundView)
    }
    
    private func FowlFortuneSetupContainerView() {
        FowlFortuneContainerView = UIView()
        FowlFortuneContainerView.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.95, alpha: 1.0)
        FowlFortuneContainerView.layer.cornerRadius = 20
        FowlFortuneContainerView.layer.shadowColor = UIColor.black.cgColor
        FowlFortuneContainerView.layer.shadowOffset = CGSize(width: 0, height: 10)
        FowlFortuneContainerView.layer.shadowOpacity = 0.3
        FowlFortuneContainerView.layer.shadowRadius = 15
        FowlFortuneContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneBackgroundView.addSubview(FowlFortuneContainerView)
    }
    
    private func FowlFortuneSetupDragIndicator() {
        FowlFortuneDragIndicator = UIView()
        FowlFortuneDragIndicator.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        FowlFortuneDragIndicator.layer.cornerRadius = 2.5
        FowlFortuneDragIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneContainerView.addSubview(FowlFortuneDragIndicator)
    }
    
    private func FowlFortuneSetupTitle() {
        FowlFortuneShopTitleLabel = UILabel()
        FowlFortuneShopTitleLabel.text = "🛒 FowlFortune Shop"
        FowlFortuneShopTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        FowlFortuneShopTitleLabel.textColor = UIColor(red: 0.1, green: 0.3, blue: 0.25, alpha: 1.0)
        FowlFortuneShopTitleLabel.textAlignment = .center
        FowlFortuneShopTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneContainerView.addSubview(FowlFortuneShopTitleLabel)
    }
    
    private func FowlFortuneSetupCreditsSection() {
        FowlFortuneCreditsLabel = UILabel()
        FowlFortuneCreditsLabel.text = "💰 Credits: 100"
        FowlFortuneCreditsLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        FowlFortuneCreditsLabel.textColor = UIColor(red: 0.2, green: 0.6, blue: 0.4, alpha: 1.0)
        FowlFortuneCreditsLabel.textAlignment = .center
        FowlFortuneCreditsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortunePassiveIncomeLabel = UILabel()
        FowlFortunePassiveIncomeLabel.text = "⚡ Passive Income: 0/min"
        FowlFortunePassiveIncomeLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        FowlFortunePassiveIncomeLabel.textColor = UIColor(red: 0.4, green: 0.7, blue: 0.5, alpha: 1.0)
        FowlFortunePassiveIncomeLabel.textAlignment = .center
        FowlFortunePassiveIncomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneContainerView.addSubview(FowlFortuneCreditsLabel)
        FowlFortuneContainerView.addSubview(FowlFortunePassiveIncomeLabel)
    }
    
    private func FowlFortuneSetupCollectionView() {
        let FowlFortuneLayout = UICollectionViewFlowLayout()
        FowlFortuneLayout.scrollDirection = .vertical
        FowlFortuneLayout.minimumLineSpacing = 15
        FowlFortuneLayout.minimumInteritemSpacing = 10
        FowlFortuneLayout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        
        FowlFortuneUpgradesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: FowlFortuneLayout)
        FowlFortuneUpgradesCollectionView.backgroundColor = UIColor.clear
        FowlFortuneUpgradesCollectionView.delegate = self
        FowlFortuneUpgradesCollectionView.dataSource = self
        FowlFortuneUpgradesCollectionView.register(FowlFortuneUpgradeCollectionViewCell.self, forCellWithReuseIdentifier: "FowlFortuneUpgradeCell")
        FowlFortuneUpgradesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneContainerView.addSubview(FowlFortuneUpgradesCollectionView)
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
        
        FowlFortuneContainerView.addSubview(FowlFortuneCloseButton)
    }
    
    private func FowlFortuneSetupConstraints() {
        NSLayoutConstraint.activate([
            FowlFortuneBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            FowlFortuneBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            FowlFortuneBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            FowlFortuneBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            FowlFortuneContainerView.centerXAnchor.constraint(equalTo: FowlFortuneBackgroundView.centerXAnchor),
            FowlFortuneContainerView.centerYAnchor.constraint(equalTo: FowlFortuneBackgroundView.centerYAnchor),
            FowlFortuneContainerView.widthAnchor.constraint(equalTo: FowlFortuneBackgroundView.widthAnchor, multiplier: 0.95),
            FowlFortuneContainerView.heightAnchor.constraint(equalTo: FowlFortuneBackgroundView.heightAnchor, multiplier: 0.75),
            
            FowlFortuneDragIndicator.topAnchor.constraint(equalTo: FowlFortuneContainerView.topAnchor, constant: 8),
            FowlFortuneDragIndicator.centerXAnchor.constraint(equalTo: FowlFortuneContainerView.centerXAnchor),
            FowlFortuneDragIndicator.widthAnchor.constraint(equalToConstant: 40),
            FowlFortuneDragIndicator.heightAnchor.constraint(equalToConstant: 5),
            
            FowlFortuneShopTitleLabel.topAnchor.constraint(equalTo: FowlFortuneDragIndicator.bottomAnchor, constant: 12),
            FowlFortuneShopTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneContainerView.leadingAnchor, constant: 20),
            FowlFortuneShopTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneContainerView.trailingAnchor, constant: -20),
            
            FowlFortuneCreditsLabel.topAnchor.constraint(equalTo: FowlFortuneShopTitleLabel.bottomAnchor, constant: 15),
            FowlFortuneCreditsLabel.leadingAnchor.constraint(equalTo: FowlFortuneContainerView.leadingAnchor, constant: 20),
            FowlFortuneCreditsLabel.trailingAnchor.constraint(equalTo: FowlFortuneContainerView.trailingAnchor, constant: -20),
            
            FowlFortunePassiveIncomeLabel.topAnchor.constraint(equalTo: FowlFortuneCreditsLabel.bottomAnchor, constant: 8),
            FowlFortunePassiveIncomeLabel.leadingAnchor.constraint(equalTo: FowlFortuneContainerView.leadingAnchor, constant: 20),
            FowlFortunePassiveIncomeLabel.trailingAnchor.constraint(equalTo: FowlFortuneContainerView.trailingAnchor, constant: -20),
            
            FowlFortuneUpgradesCollectionView.topAnchor.constraint(equalTo: FowlFortunePassiveIncomeLabel.bottomAnchor, constant: 20),
            FowlFortuneUpgradesCollectionView.leadingAnchor.constraint(equalTo: FowlFortuneContainerView.leadingAnchor),
            FowlFortuneUpgradesCollectionView.trailingAnchor.constraint(equalTo: FowlFortuneContainerView.trailingAnchor),
            FowlFortuneUpgradesCollectionView.bottomAnchor.constraint(equalTo: FowlFortuneCloseButton.topAnchor, constant: -20),
            
            FowlFortuneCloseButton.bottomAnchor.constraint(equalTo: FowlFortuneContainerView.bottomAnchor, constant: -20),
            FowlFortuneCloseButton.centerXAnchor.constraint(equalTo: FowlFortuneContainerView.centerXAnchor),
            FowlFortuneCloseButton.widthAnchor.constraint(equalToConstant: 120),
            FowlFortuneCloseButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func FowlFortuneSetupBindings() {
        FowlFortuneShopViewModelInstance.FowlFortuneShopUpdateCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.FowlFortuneUpdateUI()
            }
        }
        
        FowlFortuneShopViewModelInstance.FowlFortunePassiveIncomeCallback = { [weak self] earnedIncome in
            DispatchQueue.main.async {
                self?.FowlFortuneShowPassiveIncomeNotification(earnedIncome)
            }
        }
    }
    
    private func FowlFortuneUpdateUI() {
        FowlFortuneCreditsLabel.text = "💰 Credits: \(FowlFortuneShopViewModelInstance.FowlFortuneTotalCredits)"
        FowlFortunePassiveIncomeLabel.text = "⚡ Passive Income: \(FowlFortuneShopViewModelInstance.FowlFortuneTotalPassiveIncomePerMinute)/min"
        FowlFortuneUpgradesCollectionView.reloadData()
    }
    
    private func FowlFortuneShowPassiveIncomeNotification(_ FowlFortuneEarnedIncome: Int) {
        let FowlFortuneNotificationView = UIView()
        FowlFortuneNotificationView.backgroundColor = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 0.9)
        FowlFortuneNotificationView.layer.cornerRadius = 8
        FowlFortuneNotificationView.translatesAutoresizingMaskIntoConstraints = false
        
        let FowlFortuneNotificationLabel = UILabel()
        FowlFortuneNotificationLabel.text = "💰 +\(FowlFortuneEarnedIncome) Credits"
        FowlFortuneNotificationLabel.textColor = UIColor.white
        FowlFortuneNotificationLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        FowlFortuneNotificationLabel.textAlignment = .center
        FowlFortuneNotificationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneNotificationView.addSubview(FowlFortuneNotificationLabel)
        view.addSubview(FowlFortuneNotificationView)
        
        NSLayoutConstraint.activate([
            FowlFortuneNotificationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            FowlFortuneNotificationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            FowlFortuneNotificationView.widthAnchor.constraint(equalToConstant: 200),
            FowlFortuneNotificationView.heightAnchor.constraint(equalToConstant: 40),
            
            FowlFortuneNotificationLabel.centerXAnchor.constraint(equalTo: FowlFortuneNotificationView.centerXAnchor),
            FowlFortuneNotificationLabel.centerYAnchor.constraint(equalTo: FowlFortuneNotificationView.centerYAnchor)
        ])
        
        UIView.animate(withDuration: 0.3, animations: {
            FowlFortuneNotificationView.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 2.0, options: [], animations: {
                FowlFortuneNotificationView.alpha = 0.0
            }) { _ in
                FowlFortuneNotificationView.removeFromSuperview()
            }
        }
    }
    
    @objc private func FowlFortuneCloseButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func FowlFortuneBackgroundTapped() {
        dismiss(animated: true)
    }
    
    @objc private func FowlFortuneSwipeDown() {
        dismiss(animated: true)
    }
}

extension FowlFortuneShopViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FowlFortuneShopViewModelInstance.FowlFortuneUpgrades.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FowlFortuneUpgradeCell", for: indexPath) as! FowlFortuneUpgradeCollectionViewCell
        let upgrade = FowlFortuneShopViewModelInstance.FowlFortuneUpgrades[indexPath.item]
        cell.FowlFortuneConfigure(with: upgrade, viewModel: FowlFortuneShopViewModelInstance)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let FowlFortuneCellWidth = (collectionView.frame.width - 50) / 2
        return CGSize(width: FowlFortuneCellWidth, height: 220)
    }
}

class FowlFortuneUpgradeCollectionViewCell: UICollectionViewCell {
    
    private let FowlFortuneCardView = UIView()
    private let FowlFortuneEmojiLabel = UILabel()
    private let FowlFortuneNameLabel = UILabel()
    private let FowlFortuneDescriptionLabel = UILabel()
    private let FowlFortuneLevelLabel = UILabel()
    private let FowlFortuneCostLabel = UILabel()
    private let FowlFortuneIncomeLabel = UILabel()
    private let FowlFortuneBuyButton = UIButton(type: .system)
    private let FowlFortuneMaxLevelLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        FowlFortuneSetupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func FowlFortuneSetupUI() {
        backgroundColor = UIColor.clear
        
        FowlFortuneCardView.backgroundColor = UIColor(red: 0.9, green: 0.95, blue: 0.9, alpha: 1.0)
        FowlFortuneCardView.layer.cornerRadius = 12
        FowlFortuneCardView.layer.shadowColor = UIColor.black.cgColor
        FowlFortuneCardView.layer.shadowOffset = CGSize(width: 0, height: 3)
        FowlFortuneCardView.layer.shadowOpacity = 0.15
        FowlFortuneCardView.layer.shadowRadius = 6
        FowlFortuneCardView.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneEmojiLabel.font = UIFont.systemFont(ofSize: 32)
        FowlFortuneEmojiLabel.textAlignment = .center
        FowlFortuneEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        FowlFortuneNameLabel.textColor = UIColor(red: 0.1, green: 0.3, blue: 0.25, alpha: 1.0)
        FowlFortuneNameLabel.textAlignment = .center
        FowlFortuneNameLabel.numberOfLines = 2
        FowlFortuneNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneDescriptionLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        FowlFortuneDescriptionLabel.textColor = UIColor(red: 0.3, green: 0.5, blue: 0.4, alpha: 1.0)
        FowlFortuneDescriptionLabel.textAlignment = .center
        FowlFortuneDescriptionLabel.numberOfLines = 3
        FowlFortuneDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneLevelLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        FowlFortuneLevelLabel.textColor = UIColor(red: 0.4, green: 0.6, blue: 0.5, alpha: 1.0)
        FowlFortuneLevelLabel.textAlignment = .center
        FowlFortuneLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneCostLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        FowlFortuneCostLabel.textColor = UIColor(red: 0.8, green: 0.4, blue: 0.0, alpha: 1.0)
        FowlFortuneCostLabel.textAlignment = .center
        FowlFortuneCostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneIncomeLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        FowlFortuneIncomeLabel.textColor = UIColor(red: 0.2, green: 0.6, blue: 0.4, alpha: 1.0)
        FowlFortuneIncomeLabel.textAlignment = .center
        FowlFortuneIncomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneBuyButton.setTitle("Buy", for: .normal)
        FowlFortuneBuyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        FowlFortuneBuyButton.setTitleColor(UIColor.white, for: .normal)
        FowlFortuneBuyButton.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.4, alpha: 1.0)
        FowlFortuneBuyButton.layer.cornerRadius = 8
        FowlFortuneBuyButton.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneMaxLevelLabel.text = "MAX LEVEL"
        FowlFortuneMaxLevelLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        FowlFortuneMaxLevelLabel.textColor = UIColor(red: 0.8, green: 0.4, blue: 0.0, alpha: 1.0)
        FowlFortuneMaxLevelLabel.textAlignment = .center
        FowlFortuneMaxLevelLabel.isHidden = true
        FowlFortuneMaxLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(FowlFortuneCardView)
        FowlFortuneCardView.addSubview(FowlFortuneEmojiLabel)
        FowlFortuneCardView.addSubview(FowlFortuneNameLabel)
        FowlFortuneCardView.addSubview(FowlFortuneDescriptionLabel)
        FowlFortuneCardView.addSubview(FowlFortuneLevelLabel)
        FowlFortuneCardView.addSubview(FowlFortuneCostLabel)
        FowlFortuneCardView.addSubview(FowlFortuneIncomeLabel)
        FowlFortuneCardView.addSubview(FowlFortuneBuyButton)
        FowlFortuneCardView.addSubview(FowlFortuneMaxLevelLabel)
        
        FowlFortuneSetupConstraints()
    }
    
    private func FowlFortuneSetupConstraints() {
        NSLayoutConstraint.activate([
            FowlFortuneCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            FowlFortuneCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            FowlFortuneCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            FowlFortuneCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            FowlFortuneEmojiLabel.topAnchor.constraint(equalTo: FowlFortuneCardView.topAnchor, constant: 8),
            FowlFortuneEmojiLabel.centerXAnchor.constraint(equalTo: FowlFortuneCardView.centerXAnchor),
            
            FowlFortuneNameLabel.topAnchor.constraint(equalTo: FowlFortuneEmojiLabel.bottomAnchor, constant: 6),
            FowlFortuneNameLabel.leadingAnchor.constraint(equalTo: FowlFortuneCardView.leadingAnchor, constant: 8),
            FowlFortuneNameLabel.trailingAnchor.constraint(equalTo: FowlFortuneCardView.trailingAnchor, constant: -8),
            
            FowlFortuneDescriptionLabel.topAnchor.constraint(equalTo: FowlFortuneNameLabel.bottomAnchor, constant: 6),
            FowlFortuneDescriptionLabel.leadingAnchor.constraint(equalTo: FowlFortuneCardView.leadingAnchor, constant: 8),
            FowlFortuneDescriptionLabel.trailingAnchor.constraint(equalTo: FowlFortuneCardView.trailingAnchor, constant: -8),
            
            FowlFortuneLevelLabel.topAnchor.constraint(equalTo: FowlFortuneDescriptionLabel.bottomAnchor, constant: 8),
            FowlFortuneLevelLabel.centerXAnchor.constraint(equalTo: FowlFortuneCardView.centerXAnchor),
            
            FowlFortuneCostLabel.topAnchor.constraint(equalTo: FowlFortuneLevelLabel.bottomAnchor, constant: 4),
            FowlFortuneCostLabel.centerXAnchor.constraint(equalTo: FowlFortuneCardView.centerXAnchor),
            
            FowlFortuneIncomeLabel.topAnchor.constraint(equalTo: FowlFortuneCostLabel.bottomAnchor, constant: 4),
            FowlFortuneIncomeLabel.centerXAnchor.constraint(equalTo: FowlFortuneCardView.centerXAnchor),
            
            FowlFortuneBuyButton.bottomAnchor.constraint(equalTo: FowlFortuneCardView.bottomAnchor, constant: -8),
            FowlFortuneBuyButton.centerXAnchor.constraint(equalTo: FowlFortuneCardView.centerXAnchor),
            FowlFortuneBuyButton.widthAnchor.constraint(equalToConstant: 80),
            FowlFortuneBuyButton.heightAnchor.constraint(equalToConstant: 28),
            
            FowlFortuneMaxLevelLabel.bottomAnchor.constraint(equalTo: FowlFortuneCardView.bottomAnchor, constant: -8),
            FowlFortuneMaxLevelLabel.centerXAnchor.constraint(equalTo: FowlFortuneCardView.centerXAnchor)
        ])
    }
    
    func FowlFortuneConfigure(with upgrade: FowlFortuneShopUpgrade, viewModel: FowlFortuneShopViewModel) {
        FowlFortuneEmojiLabel.text = upgrade.FowlFortuneUpgradeEmoji
        FowlFortuneNameLabel.text = upgrade.FowlFortuneUpgradeName
        FowlFortuneDescriptionLabel.text = upgrade.FowlFortuneUpgradeDescription
        FowlFortuneLevelLabel.text = "Level \(upgrade.FowlFortuneUpgradeCurrentLevel)/\(upgrade.FowlFortuneUpgradeMaxLevel)"
        
        let FowlFortuneUpgradeCost = viewModel.FowlFortuneGetUpgradeCost(upgrade.FowlFortuneUpgradeID)
        FowlFortuneCostLabel.text = "💰 \(FowlFortuneUpgradeCost)"
        
        let FowlFortuneIncomePerMinute = upgrade.FowlFortuneUpgradePassiveIncomePerMinute * upgrade.FowlFortuneUpgradeCurrentLevel
        FowlFortuneIncomeLabel.text = "⚡ +\(FowlFortuneIncomePerMinute)/min"
        
        let FowlFortuneCanAfford = viewModel.FowlFortuneCanAffordUpgrade(upgrade.FowlFortuneUpgradeID)
        let FowlFortuneIsMaxLevel = viewModel.FowlFortuneIsUpgradeMaxLevel(upgrade.FowlFortuneUpgradeID)
        
        FowlFortuneBuyButton.isHidden = FowlFortuneIsMaxLevel
        FowlFortuneMaxLevelLabel.isHidden = !FowlFortuneIsMaxLevel
        
        if FowlFortuneIsMaxLevel {
            FowlFortuneCardView.alpha = 0.8
        } else {
            FowlFortuneCardView.alpha = FowlFortuneCanAfford ? 1.0 : 0.6
            FowlFortuneBuyButton.backgroundColor = FowlFortuneCanAfford ? 
                UIColor(red: 0.2, green: 0.6, blue: 0.4, alpha: 1.0) : 
                UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        }
        
        FowlFortuneBuyButton.removeTarget(nil, action: nil, for: .allEvents)
        if !FowlFortuneIsMaxLevel {
            FowlFortuneBuyButton.addTarget(self, action: #selector(FowlFortuneBuyButtonTapped), for: .touchUpInside)
            FowlFortuneBuyButton.tag = viewModel.FowlFortuneUpgrades.firstIndex(where: { $0.FowlFortuneUpgradeID == upgrade.FowlFortuneUpgradeID }) ?? 0
        }
    }
    
    @objc func FowlFortuneBuyButtonTapped(_ sender: UIButton) {
        guard let FowlFortuneShopViewController = FowlFortuneFindViewController() as? FowlFortuneShopViewController else { return }
        
        let FowlFortuneUpgrade = FowlFortuneShopViewController.FowlFortuneShopViewModelInstance.FowlFortuneUpgrades[sender.tag]
        
        if FowlFortuneShopViewController.FowlFortuneShopViewModelInstance.FowlFortuneBuyUpgrade(FowlFortuneUpgrade.FowlFortuneUpgradeID) {
            FowlFortuneShowPurchaseAnimation()
        }
    }
    
    private func FowlFortuneShowPurchaseAnimation() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
    
    private func FowlFortuneFindViewController() -> UIViewController? {
        var FowlFortuneResponder: UIResponder? = self
        while FowlFortuneResponder != nil {
            FowlFortuneResponder = FowlFortuneResponder?.next
            if let FowlFortuneViewController = FowlFortuneResponder as? UIViewController {
                return FowlFortuneViewController
            }
        }
        return nil
    }
}
