import UIKit

class FowlFortuneBuildingViewController: UIViewController {
    
    private let FowlFortuneViewModel = FowlFortuneBuildingViewModel()
    
    private lazy var FowlFortuneCreditsLabel: UILabel = {
        let FowlFortuneCreditsLabel = UILabel()
        FowlFortuneCreditsLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneCreditsLabel.text = "💰 Credits: 100"
        FowlFortuneCreditsLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        FowlFortuneCreditsLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneCreditsLabel.textAlignment = .center
        return FowlFortuneCreditsLabel
    }()
    
    private lazy var FowlFortuneBuildingsCollectionView: UICollectionView = {
        let FowlFortuneLayout = UICollectionViewFlowLayout()
        FowlFortuneLayout.scrollDirection = .vertical
        FowlFortuneLayout.minimumLineSpacing = 16
        FowlFortuneLayout.minimumInteritemSpacing = 16
        FowlFortuneLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let FowlFortuneCollectionView = UICollectionView(frame: .zero, collectionViewLayout: FowlFortuneLayout)
        FowlFortuneCollectionView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneCollectionView.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneCollectionView.register(FowlFortuneBuildingCollectionViewCell.self, forCellWithReuseIdentifier: "FowlFortuneBuildingCell")
        return FowlFortuneCollectionView
    }()
    
    private lazy var FowlFortuneBuyBuildingButton: UIButton = {
        let FowlFortuneButton = UIButton(type: .system)
        FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneButton.setTitle("🔨 Buy New Building", for: .normal)
        FowlFortuneButton.backgroundColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneButton.setTitleColor(.white, for: .normal)
        FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        FowlFortuneButton.layer.cornerRadius = 12
        FowlFortuneButton.layer.shadowOpacity = 0.15
        FowlFortuneButton.layer.shadowRadius = 6
        FowlFortuneButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneButton.addTarget(self, action: #selector(FowlFortuneBuyBuildingButtonTapped), for: .touchUpInside)
        return FowlFortuneButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFowlFortuneUI()
        setupFowlFortuneViewModel()
        setupFowlFortuneCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FowlFortuneViewModel.FowlFortuneLoadBuildings()
    }
    
    private func setupFowlFortuneUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        title = "🔨 Building"
        
        view.addSubview(FowlFortuneCreditsLabel)
        view.addSubview(FowlFortuneBuildingsCollectionView)
        view.addSubview(FowlFortuneBuyBuildingButton)
        
        setupFowlFortuneConstraints()
    }
    
    private func setupFowlFortuneConstraints() {
        NSLayoutConstraint.activate([
            FowlFortuneCreditsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            FowlFortuneCreditsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            FowlFortuneCreditsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            FowlFortuneBuildingsCollectionView.topAnchor.constraint(equalTo: FowlFortuneCreditsLabel.bottomAnchor, constant: 20),
            FowlFortuneBuildingsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            FowlFortuneBuildingsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            FowlFortuneBuildingsCollectionView.bottomAnchor.constraint(equalTo: FowlFortuneBuyBuildingButton.topAnchor, constant: -20),
            
            FowlFortuneBuyBuildingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            FowlFortuneBuyBuildingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            FowlFortuneBuyBuildingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            FowlFortuneBuyBuildingButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupFowlFortuneViewModel() {
        FowlFortuneViewModel.FowlFortuneBuildingsUpdateCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.updateFowlFortuneUI()
            }
        }
    }
    
    private func setupFowlFortuneCollectionView() {
        FowlFortuneBuildingsCollectionView.delegate = self
        FowlFortuneBuildingsCollectionView.dataSource = self
    }
    
    private func updateFowlFortuneUI() {
        let FowlFortuneTotalIncome = FowlFortuneViewModel.FowlFortuneGetTotalBuildingIncome()
        FowlFortuneCreditsLabel.text = "💰 Credits: \(FowlFortuneViewModel.FowlFortuneTotalCredits) | +\(FowlFortuneTotalIncome)/min"
        FowlFortuneBuildingsCollectionView.reloadData()
    }
    
    @objc private func FowlFortuneBuyBuildingButtonTapped() {
        let FowlFortuneAlert = UIAlertController(title: "Buy Building 🔨", message: "Choose a building to construct:", preferredStyle: .actionSheet)
        
        for FowlFortuneBuildingType in FowlFortuneViewModel.FowlFortuneAvailableBuildingTypes {
            let FowlFortuneCost = FowlFortuneViewModel.FowlFortuneGetBuildingCost(FowlFortuneBuildingType)
            let FowlFortuneCanAfford = FowlFortuneViewModel.FowlFortuneCanBuyBuilding(FowlFortuneBuildingType)
            let FowlFortuneTitle = FowlFortuneCanAfford ? "\(FowlFortuneBuildingType.FowlFortuneBuildingEmoji) \(FowlFortuneBuildingType.rawValue) - \(FowlFortuneCost) credits" : "❌ \(FowlFortuneBuildingType.rawValue) - \(FowlFortuneCost) credits (Insufficient funds)"
            
            let FowlFortuneAction = UIAlertAction(title: FowlFortuneTitle, style: .default) { [weak self] _ in
                if FowlFortuneCanAfford {
                    if self?.FowlFortuneViewModel.FowlFortuneBuyBuilding(FowlFortuneBuildingType) == true {
                        self?.showFowlFortuneAlert(title: "Building Constructed! 🏠", message: "You built a \(FowlFortuneBuildingType.rawValue)!")
                    }
                } else {
                    self?.showFowlFortuneAlert(title: "Not Enough Credits 💰", message: "You need \(FowlFortuneCost) credits to build this.")
                }
            }
            FowlFortuneAction.isEnabled = FowlFortuneCanAfford
            FowlFortuneAlert.addAction(FowlFortuneAction)
        }
        
        FowlFortuneAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let FowlFortunePopover = FowlFortuneAlert.popoverPresentationController {
            FowlFortunePopover.sourceView = FowlFortuneBuyBuildingButton
            FowlFortunePopover.sourceRect = FowlFortuneBuyBuildingButton.bounds
        }
        
        present(FowlFortuneAlert, animated: true)
    }
    
    private func showFowlFortuneAlert(title: String, message: String) {
        let FowlFortuneAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        FowlFortuneAlert.addAction(UIAlertAction(title: "OK", style: .default))
        present(FowlFortuneAlert, animated: true)
    }
}

extension FowlFortuneBuildingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FowlFortuneViewModel.FowlFortuneBuildings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let FowlFortuneCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FowlFortuneBuildingCell", for: indexPath) as! FowlFortuneBuildingCollectionViewCell
        
        let FowlFortuneBuilding = FowlFortuneViewModel.FowlFortuneBuildings[indexPath.item]
        FowlFortuneCell.configureFowlFortuneCell(with: FowlFortuneBuilding)
        
        return FowlFortuneCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let FowlFortuneWidth = (collectionView.frame.width - 48) / 2
        return CGSize(width: FowlFortuneWidth, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let FowlFortuneBuilding = FowlFortuneViewModel.FowlFortuneBuildings[indexPath.item]
        showFowlFortuneBuildingOptions(for: FowlFortuneBuilding)
    }
    
    private func showFowlFortuneBuildingOptions(for FowlFortuneBuilding: FowlFortuneBuilding) {
        let FowlFortuneAlert = UIAlertController(title: "\(FowlFortuneBuilding.FowlFortuneBuildingType.FowlFortuneBuildingEmoji) \(FowlFortuneBuilding.FowlFortuneBuildingType.rawValue)", message: "Level: \(FowlFortuneBuilding.FowlFortuneBuildingLevel)\nCapacity: \(FowlFortuneBuilding.FowlFortuneBuildingCapacity)\nProtection: \(FowlFortuneBuilding.FowlFortuneBuildingProtection)\nIncome: +💰\(FowlFortuneBuilding.FowlFortuneBuildingPassiveIncome)/min", preferredStyle: .actionSheet)
        
        let FowlFortuneUpgradeCost = FowlFortuneViewModel.FowlFortuneGetUpgradeCost(for: FowlFortuneBuilding)
        let FowlFortuneCanUpgrade = FowlFortuneViewModel.FowlFortuneTotalCredits >= FowlFortuneUpgradeCost
        
        let FowlFortuneUpgradeAction = UIAlertAction(title: FowlFortuneCanUpgrade ? "⬆️ Upgrade - \(FowlFortuneUpgradeCost) credits" : "❌ Upgrade - \(FowlFortuneUpgradeCost) credits (Insufficient funds)", style: .default) { [weak self] _ in
            if FowlFortuneCanUpgrade {
                if self?.FowlFortuneViewModel.FowlFortuneUpgradeBuilding(FowlFortuneBuilding.FowlFortuneBuildingID) == true {
                    self?.showFowlFortuneAlert(title: "Building Upgraded! ⬆️", message: "Your \(FowlFortuneBuilding.FowlFortuneBuildingType.rawValue) is now level \(FowlFortuneBuilding.FowlFortuneBuildingLevel + 1)!")
                }
            } else {
                self?.showFowlFortuneAlert(title: "Not Enough Credits 💰", message: "You need \(FowlFortuneUpgradeCost) credits to upgrade this building.")
            }
        }
        FowlFortuneUpgradeAction.isEnabled = FowlFortuneCanUpgrade
        FowlFortuneAlert.addAction(FowlFortuneUpgradeAction)
        
        let FowlFortuneRemoveAction = UIAlertAction(title: "🗑️ Remove Building", style: .destructive) { [weak self] _ in
            let FowlFortuneConfirmAlert = UIAlertController(title: "Remove Building", message: "Are you sure you want to remove this building? You'll get a partial refund.", preferredStyle: .alert)
            FowlFortuneConfirmAlert.addAction(UIAlertAction(title: "Remove", style: .destructive) { _ in
                if self?.FowlFortuneViewModel.FowlFortuneRemoveBuilding(FowlFortuneBuilding.FowlFortuneBuildingID) == true {
                    self?.showFowlFortuneAlert(title: "Building Removed 🗑️", message: "You received a refund for the building.")
                }
            })
            FowlFortuneConfirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(FowlFortuneConfirmAlert, animated: true)
        }
        FowlFortuneAlert.addAction(FowlFortuneRemoveAction)
        
        FowlFortuneAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let FowlFortunePopover = FowlFortuneAlert.popoverPresentationController {
            FowlFortunePopover.sourceView = view
            FowlFortunePopover.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            FowlFortunePopover.permittedArrowDirections = []
        }
        
        present(FowlFortuneAlert, animated: true)
    }
}

class FowlFortuneBuildingCollectionViewCell: UICollectionViewCell {
    
    private lazy var FowlFortuneEmojiLabel: UILabel = {
        let FowlFortuneEmojiLabel = UILabel()
        FowlFortuneEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneEmojiLabel.font = UIFont.systemFont(ofSize: 32)
        FowlFortuneEmojiLabel.textAlignment = .center
        return FowlFortuneEmojiLabel
    }()
    
    private lazy var FowlFortuneNameLabel: UILabel = {
        let FowlFortuneNameLabel = UILabel()
        FowlFortuneNameLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        FowlFortuneNameLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneNameLabel.textAlignment = .center
        FowlFortuneNameLabel.numberOfLines = 2
        return FowlFortuneNameLabel
    }()
    
    private lazy var FowlFortuneLevelLabel: UILabel = {
        let FowlFortuneLevelLabel = UILabel()
        FowlFortuneLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLevelLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        FowlFortuneLevelLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 0.8)
        FowlFortuneLevelLabel.textAlignment = .center
        return FowlFortuneLevelLabel
    }()
    
    private lazy var FowlFortuneIncomeLabel: UILabel = {
        let FowlFortuneIncomeLabel = UILabel()
        FowlFortuneIncomeLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneIncomeLabel.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        FowlFortuneIncomeLabel.textColor = UIColor(red: 0.0, green: 0.7, blue: 0.0, alpha: 1.0)
        FowlFortuneIncomeLabel.textAlignment = .center
        return FowlFortuneIncomeLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFowlFortuneCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFowlFortuneCellUI() {
        backgroundColor = UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0)
        layer.cornerRadius = 12
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        contentView.addSubview(FowlFortuneEmojiLabel)
        contentView.addSubview(FowlFortuneNameLabel)
        contentView.addSubview(FowlFortuneLevelLabel)
        contentView.addSubview(FowlFortuneIncomeLabel)
        
        NSLayoutConstraint.activate([
            FowlFortuneEmojiLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            FowlFortuneEmojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            FowlFortuneNameLabel.topAnchor.constraint(equalTo: FowlFortuneEmojiLabel.bottomAnchor, constant: 8),
            FowlFortuneNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            FowlFortuneNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            FowlFortuneLevelLabel.topAnchor.constraint(equalTo: FowlFortuneNameLabel.bottomAnchor, constant: 4),
            FowlFortuneLevelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            FowlFortuneLevelLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            FowlFortuneIncomeLabel.topAnchor.constraint(equalTo: FowlFortuneLevelLabel.bottomAnchor, constant: 4),
            FowlFortuneIncomeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            FowlFortuneIncomeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            FowlFortuneIncomeLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configureFowlFortuneCell(with FowlFortuneBuilding: FowlFortuneBuilding) {
        FowlFortuneEmojiLabel.text = FowlFortuneBuilding.FowlFortuneBuildingType.FowlFortuneBuildingEmoji
        FowlFortuneNameLabel.text = FowlFortuneBuilding.FowlFortuneBuildingType.rawValue
        FowlFortuneLevelLabel.text = "Level \(FowlFortuneBuilding.FowlFortuneBuildingLevel)"
        FowlFortuneIncomeLabel.text = "+💰\(FowlFortuneBuilding.FowlFortuneBuildingPassiveIncome)/min"
    }
}
