import UIKit

class FowlFortuneAchievementsViewController: UIViewController {
    
    private let FowlFortuneViewModel = FowlFortuneAchievementsViewModel()
    
    private lazy var FowlFortuneTableView: UITableView = {
        let FowlFortuneTableView = UITableView(frame: .zero, style: .grouped)
        FowlFortuneTableView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneTableView.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneTableView.separatorStyle = .none
        FowlFortuneTableView.register(FowlFortuneAchievementTableViewCell.self, forCellReuseIdentifier: "FowlFortuneAchievementCell")
        return FowlFortuneTableView
    }()
    
    private lazy var FowlFortuneProgressView: UIProgressView = {
        let FowlFortuneProgressView = UIProgressView(progressViewStyle: .default)
        FowlFortuneProgressView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneProgressView.progressTintColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneProgressView.trackTintColor = UIColor(red: 0.85, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneProgressView.layer.cornerRadius = 4
        FowlFortuneProgressView.clipsToBounds = true
        return FowlFortuneProgressView
    }()
    
    private lazy var FowlFortuneProgressLabel: UILabel = {
        let FowlFortuneProgressLabel = UILabel()
        FowlFortuneProgressLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneProgressLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        FowlFortuneProgressLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneProgressLabel.textAlignment = .center
        return FowlFortuneProgressLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFowlFortuneUI()
        setupFowlFortuneViewModel()
        setupFowlFortuneTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FowlFortuneViewModel.FowlFortuneUpdateAllAchievements()
    }
    
    private func setupFowlFortuneUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        title = "🏆 Achievements"
        
        view.addSubview(FowlFortuneProgressView)
        view.addSubview(FowlFortuneProgressLabel)
        view.addSubview(FowlFortuneTableView)
        
        setupFowlFortuneConstraints()
    }
    
    private func setupFowlFortuneConstraints() {
        NSLayoutConstraint.activate([
            FowlFortuneProgressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            FowlFortuneProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            FowlFortuneProgressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            FowlFortuneProgressView.heightAnchor.constraint(equalToConstant: 8),
            
            FowlFortuneProgressLabel.topAnchor.constraint(equalTo: FowlFortuneProgressView.bottomAnchor, constant: 8),
            FowlFortuneProgressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            FowlFortuneProgressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            FowlFortuneTableView.topAnchor.constraint(equalTo: FowlFortuneProgressLabel.bottomAnchor, constant: 20),
            FowlFortuneTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            FowlFortuneTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            FowlFortuneTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupFowlFortuneViewModel() {
        FowlFortuneViewModel.FowlFortuneAchievementsUpdateCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.updateFowlFortuneUI()
            }
        }
    }
    
    private func setupFowlFortuneTableView() {
        FowlFortuneTableView.delegate = self
        FowlFortuneTableView.dataSource = self
    }
    
    private func updateFowlFortuneUI() {
        FowlFortuneProgressView.progress = Float(FowlFortuneViewModel.FowlFortuneAchievementProgress)
        FowlFortuneProgressLabel.text = "\(FowlFortuneViewModel.FowlFortuneUnlockedCount) of \(FowlFortuneViewModel.FowlFortuneTotalAchievements) achievements unlocked"
        FowlFortuneTableView.reloadData()
    }
}

extension FowlFortuneAchievementsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return FowlFortuneViewModel.FowlFortuneUnlockedAchievements.count
        } else {
            return FowlFortuneViewModel.FowlFortuneLockedAchievements.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return FowlFortuneViewModel.FowlFortuneUnlockedAchievements.isEmpty ? nil : "🏆 Unlocked"
        } else {
            return FowlFortuneViewModel.FowlFortuneLockedAchievements.isEmpty ? nil : "🔒 Locked"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let FowlFortuneCell = tableView.dequeueReusableCell(withIdentifier: "FowlFortuneAchievementCell", for: indexPath) as! FowlFortuneAchievementTableViewCell
        
        let FowlFortuneAchievement: FowlFortuneAchievement
        if indexPath.section == 0 {
            FowlFortuneAchievement = FowlFortuneViewModel.FowlFortuneUnlockedAchievements[indexPath.row]
        } else {
            FowlFortuneAchievement = FowlFortuneViewModel.FowlFortuneLockedAchievements[indexPath.row]
        }
        
        FowlFortuneCell.configureFowlFortuneCell(with: FowlFortuneAchievement, isUnlocked: indexPath.section == 0)
        return FowlFortuneCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let FowlFortuneAchievement = FowlFortuneViewModel.FowlFortuneUnlockedAchievements[indexPath.row]
            if FowlFortuneViewModel.FowlFortuneClaimAchievementReward(FowlFortuneAchievement.FowlFortuneAchievementID) {
                showFowlFortuneAlert(title: "Reward Claimed! 🎉", message: "You received \(FowlFortuneAchievement.FowlFortuneAchievementReward) credits!")
            } else {
                showFowlFortuneAlert(title: "Already Claimed", message: "You've already claimed this reward.")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    private func showFowlFortuneAlert(title: String, message: String) {
        let FowlFortuneAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        FowlFortuneAlert.addAction(UIAlertAction(title: "OK", style: .default))
        present(FowlFortuneAlert, animated: true)
    }
}

class FowlFortuneAchievementTableViewCell: UITableViewCell {
    
    private lazy var FowlFortuneEmojiLabel: UILabel = {
        let FowlFortuneEmojiLabel = UILabel()
        FowlFortuneEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneEmojiLabel.font = UIFont.systemFont(ofSize: 32)
        FowlFortuneEmojiLabel.textAlignment = .center
        return FowlFortuneEmojiLabel
    }()
    
    private lazy var FowlFortuneTitleLabel: UILabel = {
        let FowlFortuneTitleLabel = UILabel()
        FowlFortuneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        FowlFortuneTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        return FowlFortuneTitleLabel
    }()
    
    private lazy var FowlFortuneDescriptionLabel: UILabel = {
        let FowlFortuneDescriptionLabel = UILabel()
        FowlFortuneDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneDescriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        FowlFortuneDescriptionLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 0.8)
        FowlFortuneDescriptionLabel.numberOfLines = 2
        return FowlFortuneDescriptionLabel
    }()
    
    private lazy var FowlFortuneRewardLabel: UILabel = {
        let FowlFortuneRewardLabel = UILabel()
        FowlFortuneRewardLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneRewardLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        FowlFortuneRewardLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        return FowlFortuneRewardLabel
    }()
    
    private lazy var FowlFortuneProgressBar: UIProgressView = {
        let FowlFortuneProgressBar = UIProgressView(progressViewStyle: .default)
        FowlFortuneProgressBar.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneProgressBar.progressTintColor = UIColor(red: 0.2, green: 0.6, blue: 0.4, alpha: 1.0)
        FowlFortuneProgressBar.trackTintColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        FowlFortuneProgressBar.layer.cornerRadius = 3
        FowlFortuneProgressBar.clipsToBounds = true
        return FowlFortuneProgressBar
    }()
    
    private lazy var FowlFortuneProgressLabel: UILabel = {
        let FowlFortuneProgressLabel = UILabel()
        FowlFortuneProgressLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneProgressLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        FowlFortuneProgressLabel.textColor = UIColor(red: 0.3, green: 0.5, blue: 0.4, alpha: 1.0)
        FowlFortuneProgressLabel.textAlignment = .right
        return FowlFortuneProgressLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        contentView.addSubview(FowlFortuneTitleLabel)
        contentView.addSubview(FowlFortuneDescriptionLabel)
        contentView.addSubview(FowlFortuneRewardLabel)
        contentView.addSubview(FowlFortuneProgressBar)
        contentView.addSubview(FowlFortuneProgressLabel)
        
        NSLayoutConstraint.activate([
            FowlFortuneEmojiLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            FowlFortuneEmojiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            FowlFortuneEmojiLabel.widthAnchor.constraint(equalToConstant: 50),
            
            FowlFortuneTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            FowlFortuneTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneEmojiLabel.trailingAnchor, constant: 12),
            FowlFortuneTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneRewardLabel.leadingAnchor, constant: -8),
            
            FowlFortuneDescriptionLabel.topAnchor.constraint(equalTo: FowlFortuneTitleLabel.bottomAnchor, constant: 4),
            FowlFortuneDescriptionLabel.leadingAnchor.constraint(equalTo: FowlFortuneEmojiLabel.trailingAnchor, constant: 12),
            FowlFortuneDescriptionLabel.trailingAnchor.constraint(equalTo: FowlFortuneRewardLabel.leadingAnchor, constant: -8),
            
            FowlFortuneRewardLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            FowlFortuneRewardLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            FowlFortuneRewardLabel.widthAnchor.constraint(equalToConstant: 80),
            
            FowlFortuneProgressBar.topAnchor.constraint(equalTo: FowlFortuneDescriptionLabel.bottomAnchor, constant: 8),
            FowlFortuneProgressBar.leadingAnchor.constraint(equalTo: FowlFortuneEmojiLabel.trailingAnchor, constant: 12),
            FowlFortuneProgressBar.trailingAnchor.constraint(equalTo: FowlFortuneProgressLabel.leadingAnchor, constant: -8),
            FowlFortuneProgressBar.heightAnchor.constraint(equalToConstant: 6),
            FowlFortuneProgressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            FowlFortuneProgressLabel.centerYAnchor.constraint(equalTo: FowlFortuneProgressBar.centerYAnchor),
            FowlFortuneProgressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            FowlFortuneProgressLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureFowlFortuneCell(with FowlFortuneAchievement: FowlFortuneAchievement, isUnlocked: Bool) {
        FowlFortuneEmojiLabel.text = FowlFortuneAchievement.FowlFortuneAchievementEmoji
        FowlFortuneTitleLabel.text = FowlFortuneAchievement.FowlFortuneAchievementTitle
        FowlFortuneDescriptionLabel.text = FowlFortuneAchievement.FowlFortuneAchievementDescription
        FowlFortuneRewardLabel.text = "💰 \(FowlFortuneAchievement.FowlFortuneAchievementReward)"
        
        let progress = Float(FowlFortuneAchievement.FowlFortuneAchievementProgress) / Float(FowlFortuneAchievement.FowlFortuneAchievementTarget)
        FowlFortuneProgressBar.progress = progress
        FowlFortuneProgressLabel.text = "\(FowlFortuneAchievement.FowlFortuneAchievementProgress)/\(FowlFortuneAchievement.FowlFortuneAchievementTarget)"
        
        if isUnlocked {
            alpha = 1.0
            FowlFortuneRewardLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
            FowlFortuneProgressBar.progressTintColor = UIColor(red: 0.2, green: 0.6, blue: 0.4, alpha: 1.0)
        } else {
            alpha = 0.7
            FowlFortuneRewardLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 0.5)
            FowlFortuneProgressBar.progressTintColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        }
    }
}
