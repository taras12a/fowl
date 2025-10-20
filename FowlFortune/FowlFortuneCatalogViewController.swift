import UIKit

class FowlFortuneCatalogViewController: UIViewController {
    
    private let FowlFortuneViewModel = FowlFortuneCatalogViewModel()
    
    private lazy var FowlFortuneSegmentedControl: UISegmentedControl = {
        let FowlFortuneSegmentedControl = UISegmentedControl(items: ["🐔 Chickens", "🏠 Buildings"])
        FowlFortuneSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneSegmentedControl.selectedSegmentIndex = 0
        FowlFortuneSegmentedControl.backgroundColor = UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0)
        FowlFortuneSegmentedControl.selectedSegmentTintColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)], for: .normal)
        FowlFortuneSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        FowlFortuneSegmentedControl.addTarget(self, action: #selector(FowlFortuneSegmentedControlChanged), for: .valueChanged)
        return FowlFortuneSegmentedControl
    }()
    
    private lazy var FowlFortuneCollectionView: UICollectionView = {
        let FowlFortuneLayout = UICollectionViewFlowLayout()
        FowlFortuneLayout.scrollDirection = .vertical
        FowlFortuneLayout.minimumLineSpacing = 16
        FowlFortuneLayout.minimumInteritemSpacing = 16
        FowlFortuneLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let FowlFortuneCollectionView = UICollectionView(frame: .zero, collectionViewLayout: FowlFortuneLayout)
        FowlFortuneCollectionView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneCollectionView.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneCollectionView.register(FowlFortuneCatalogCollectionViewCell.self, forCellWithReuseIdentifier: "FowlFortuneCatalogCell")
        return FowlFortuneCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFowlFortuneUI()
        setupFowlFortuneViewModel()
        setupFowlFortuneCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FowlFortuneViewModel.FowlFortuneLoadCatalog()
    }
    
    private func setupFowlFortuneUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        title = "📖 Catalog"
        
        view.addSubview(FowlFortuneSegmentedControl)
        view.addSubview(FowlFortuneCollectionView)
        
        setupFowlFortuneConstraints()
    }
    
    private func setupFowlFortuneConstraints() {
        NSLayoutConstraint.activate([
            FowlFortuneSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            FowlFortuneSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            FowlFortuneSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            FowlFortuneCollectionView.topAnchor.constraint(equalTo: FowlFortuneSegmentedControl.bottomAnchor, constant: 20),
            FowlFortuneCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            FowlFortuneCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            FowlFortuneCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupFowlFortuneViewModel() {
        FowlFortuneViewModel.FowlFortuneCatalogUpdateCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.FowlFortuneCollectionView.reloadData()
            }
        }
    }
    
    private func setupFowlFortuneCollectionView() {
        FowlFortuneCollectionView.delegate = self
        FowlFortuneCollectionView.dataSource = self
    }
    
    @objc private func FowlFortuneSegmentedControlChanged() {
        FowlFortuneCollectionView.reloadData()
    }
}

extension FowlFortuneCatalogViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if FowlFortuneSegmentedControl.selectedSegmentIndex == 0 {
            return FowlFortuneViewModel.FowlFortuneAvailableChickenTypes.count
        } else {
            return FowlFortuneViewModel.FowlFortuneAvailableBuildingTypes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let FowlFortuneCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FowlFortuneCatalogCell", for: indexPath) as! FowlFortuneCatalogCollectionViewCell
        
        if FowlFortuneSegmentedControl.selectedSegmentIndex == 0 {
            let FowlFortuneChickenType = FowlFortuneViewModel.FowlFortuneAvailableChickenTypes[indexPath.item]
            let FowlFortuneChickenDetails = FowlFortuneViewModel.FowlFortuneGetChickenDetails(for: FowlFortuneChickenType)
            FowlFortuneCell.configureFowlFortuneCell(with: FowlFortuneChickenDetails)
        } else {
            let FowlFortuneBuildingType = FowlFortuneViewModel.FowlFortuneAvailableBuildingTypes[indexPath.item]
            let FowlFortuneBuildingDetails = FowlFortuneViewModel.FowlFortuneGetBuildingDetails(for: FowlFortuneBuildingType)
            FowlFortuneCell.configureFowlFortuneCell(with: FowlFortuneBuildingDetails)
        }
        
        return FowlFortuneCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let FowlFortuneWidth = (collectionView.frame.width - 48) / 2
        return CGSize(width: FowlFortuneWidth, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if FowlFortuneSegmentedControl.selectedSegmentIndex == 0 {
            let FowlFortuneChickenType = FowlFortuneViewModel.FowlFortuneAvailableChickenTypes[indexPath.item]
            let FowlFortuneChickenDetails = FowlFortuneViewModel.FowlFortuneGetChickenDetails(for: FowlFortuneChickenType)
            showFowlFortuneDetailViewController(with: FowlFortuneChickenDetails)
        } else {
            let FowlFortuneBuildingType = FowlFortuneViewModel.FowlFortuneAvailableBuildingTypes[indexPath.item]
            let FowlFortuneBuildingDetails = FowlFortuneViewModel.FowlFortuneGetBuildingDetails(for: FowlFortuneBuildingType)
            showFowlFortuneDetailViewController(with: FowlFortuneBuildingDetails)
        }
    }
    
    private func showFowlFortuneDetailViewController(with FowlFortuneChickenDetails: FowlFortuneChickenDetails) {
        let FowlFortuneDetailVC = FowlFortuneCatalogDetailViewController()
        FowlFortuneDetailVC.configureFowlFortuneWithChickenDetails(FowlFortuneChickenDetails)
        navigationController?.pushViewController(FowlFortuneDetailVC, animated: true)
    }
    
    private func showFowlFortuneDetailViewController(with FowlFortuneBuildingDetails: FowlFortuneBuildingDetails) {
        let FowlFortuneDetailVC = FowlFortuneCatalogDetailViewController()
        FowlFortuneDetailVC.configureFowlFortuneWithBuildingDetails(FowlFortuneBuildingDetails)
        navigationController?.pushViewController(FowlFortuneDetailVC, animated: true)
    }
}

class FowlFortuneCatalogCollectionViewCell: UICollectionViewCell {
    
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
        FowlFortuneNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        FowlFortuneNameLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneNameLabel.textAlignment = .center
        FowlFortuneNameLabel.numberOfLines = 2
        return FowlFortuneNameLabel
    }()
    
    private lazy var FowlFortuneOwnedLabel: UILabel = {
        let FowlFortuneOwnedLabel = UILabel()
        FowlFortuneOwnedLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneOwnedLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        FowlFortuneOwnedLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 0.8)
        FowlFortuneOwnedLabel.textAlignment = .center
        return FowlFortuneOwnedLabel
    }()
    
    private lazy var FowlFortuneCostLabel: UILabel = {
        let FowlFortuneCostLabel = UILabel()
        FowlFortuneCostLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneCostLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        FowlFortuneCostLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneCostLabel.textAlignment = .center
        return FowlFortuneCostLabel
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
        contentView.addSubview(FowlFortuneOwnedLabel)
        contentView.addSubview(FowlFortuneCostLabel)
        
        NSLayoutConstraint.activate([
            FowlFortuneEmojiLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            FowlFortuneEmojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            FowlFortuneNameLabel.topAnchor.constraint(equalTo: FowlFortuneEmojiLabel.bottomAnchor, constant: 8),
            FowlFortuneNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            FowlFortuneNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            FowlFortuneOwnedLabel.topAnchor.constraint(equalTo: FowlFortuneNameLabel.bottomAnchor, constant: 8),
            FowlFortuneOwnedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            FowlFortuneOwnedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            FowlFortuneCostLabel.topAnchor.constraint(equalTo: FowlFortuneOwnedLabel.bottomAnchor, constant: 4),
            FowlFortuneCostLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            FowlFortuneCostLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            FowlFortuneCostLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configureFowlFortuneCell(with FowlFortuneChickenDetails: FowlFortuneChickenDetails) {
        FowlFortuneEmojiLabel.text = FowlFortuneChickenDetails.FowlFortuneChickenType.FowlFortuneChickenEmoji
        FowlFortuneNameLabel.text = FowlFortuneChickenDetails.FowlFortuneChickenType.rawValue
        FowlFortuneOwnedLabel.text = "Owned: \(FowlFortuneChickenDetails.FowlFortuneOwnedCount)"
        FowlFortuneCostLabel.text = "💰 \(FowlFortuneChickenDetails.FowlFortuneCost) credits"
    }
    
    func configureFowlFortuneCell(with FowlFortuneBuildingDetails: FowlFortuneBuildingDetails) {
        FowlFortuneEmojiLabel.text = FowlFortuneBuildingDetails.FowlFortuneBuildingType.FowlFortuneBuildingEmoji
        FowlFortuneNameLabel.text = FowlFortuneBuildingDetails.FowlFortuneBuildingType.rawValue
        FowlFortuneOwnedLabel.text = "Built: \(FowlFortuneBuildingDetails.FowlFortuneOwnedCount)"
        FowlFortuneCostLabel.text = "💰 \(FowlFortuneBuildingDetails.FowlFortuneCost) credits"
    }
}

class FowlFortuneCatalogDetailViewController: UIViewController {
    
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
    
    private lazy var FowlFortuneDetailView: UIView = {
        let FowlFortuneDetailView = UIView()
        FowlFortuneDetailView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneDetailView.backgroundColor = UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0)
        FowlFortuneDetailView.layer.cornerRadius = 16
        FowlFortuneDetailView.layer.shadowOpacity = 0.15
        FowlFortuneDetailView.layer.shadowRadius = 8
        FowlFortuneDetailView.layer.shadowOffset = CGSize(width: 0, height: 4)
        return FowlFortuneDetailView
    }()
    
    private lazy var FowlFortuneEmojiLabel: UILabel = {
        let FowlFortuneEmojiLabel = UILabel()
        FowlFortuneEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneEmojiLabel.font = UIFont.systemFont(ofSize: 64)
        FowlFortuneEmojiLabel.textAlignment = .center
        return FowlFortuneEmojiLabel
    }()
    
    private lazy var FowlFortuneTitleLabel: UILabel = {
        let FowlFortuneTitleLabel = UILabel()
        FowlFortuneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        FowlFortuneTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneTitleLabel.textAlignment = .center
        return FowlFortuneTitleLabel
    }()
    
    private lazy var FowlFortuneDescriptionLabel: UILabel = {
        let FowlFortuneDescriptionLabel = UILabel()
        FowlFortuneDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneDescriptionLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        FowlFortuneDescriptionLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        FowlFortuneDescriptionLabel.textAlignment = .center
        FowlFortuneDescriptionLabel.numberOfLines = 0
        return FowlFortuneDescriptionLabel
    }()
    
    private lazy var FowlFortuneCostLabel: UILabel = {
        let FowlFortuneCostLabel = UILabel()
        FowlFortuneCostLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneCostLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        FowlFortuneCostLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneCostLabel.textAlignment = .center
        return FowlFortuneCostLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFowlFortuneUI()
    }
    
    private func setupFowlFortuneUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        
        view.addSubview(FowlFortuneScrollView)
        FowlFortuneScrollView.addSubview(FowlFortuneContentView)
        FowlFortuneContentView.addSubview(FowlFortuneDetailView)
        
        FowlFortuneDetailView.addSubview(FowlFortuneEmojiLabel)
        FowlFortuneDetailView.addSubview(FowlFortuneTitleLabel)
        FowlFortuneDetailView.addSubview(FowlFortuneDescriptionLabel)
        FowlFortuneDetailView.addSubview(FowlFortuneCostLabel)
        
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
            
            FowlFortuneDetailView.topAnchor.constraint(equalTo: FowlFortuneContentView.topAnchor, constant: 20),
            FowlFortuneDetailView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneDetailView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            FowlFortuneDetailView.bottomAnchor.constraint(equalTo: FowlFortuneContentView.bottomAnchor, constant: -20),
            
            FowlFortuneEmojiLabel.topAnchor.constraint(equalTo: FowlFortuneDetailView.topAnchor, constant: 24),
            FowlFortuneEmojiLabel.centerXAnchor.constraint(equalTo: FowlFortuneDetailView.centerXAnchor),
            
            FowlFortuneTitleLabel.topAnchor.constraint(equalTo: FowlFortuneEmojiLabel.bottomAnchor, constant: 16),
            FowlFortuneTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneDetailView.leadingAnchor, constant: 20),
            FowlFortuneTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneDetailView.trailingAnchor, constant: -20),
            
            FowlFortuneDescriptionLabel.topAnchor.constraint(equalTo: FowlFortuneTitleLabel.bottomAnchor, constant: 16),
            FowlFortuneDescriptionLabel.leadingAnchor.constraint(equalTo: FowlFortuneDetailView.leadingAnchor, constant: 20),
            FowlFortuneDescriptionLabel.trailingAnchor.constraint(equalTo: FowlFortuneDetailView.trailingAnchor, constant: -20),
            
            FowlFortuneCostLabel.topAnchor.constraint(equalTo: FowlFortuneDescriptionLabel.bottomAnchor, constant: 24),
            FowlFortuneCostLabel.leadingAnchor.constraint(equalTo: FowlFortuneDetailView.leadingAnchor, constant: 20),
            FowlFortuneCostLabel.trailingAnchor.constraint(equalTo: FowlFortuneDetailView.trailingAnchor, constant: -20),
            FowlFortuneCostLabel.bottomAnchor.constraint(equalTo: FowlFortuneDetailView.bottomAnchor, constant: -24)
        ])
    }
    
    func configureFowlFortuneWithChickenDetails(_ FowlFortuneChickenDetails: FowlFortuneChickenDetails) {
        FowlFortuneEmojiLabel.text = FowlFortuneChickenDetails.FowlFortuneChickenType.FowlFortuneChickenEmoji
        FowlFortuneTitleLabel.text = FowlFortuneChickenDetails.FowlFortuneChickenType.rawValue
        FowlFortuneDescriptionLabel.text = FowlFortuneChickenDetails.FowlFortuneDescription
        FowlFortuneCostLabel.text = "💰 Cost: \(FowlFortuneChickenDetails.FowlFortuneCost) credits"
    }
    
    func configureFowlFortuneWithBuildingDetails(_ FowlFortuneBuildingDetails: FowlFortuneBuildingDetails) {
        FowlFortuneEmojiLabel.text = FowlFortuneBuildingDetails.FowlFortuneBuildingType.FowlFortuneBuildingEmoji
        FowlFortuneTitleLabel.text = FowlFortuneBuildingDetails.FowlFortuneBuildingType.rawValue
        FowlFortuneDescriptionLabel.text = FowlFortuneBuildingDetails.FowlFortuneDescription
        FowlFortuneCostLabel.text = "💰 Cost: \(FowlFortuneBuildingDetails.FowlFortuneCost) credits"
    }
}
