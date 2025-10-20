import UIKit

class FowlFortuneFactsViewController: UIViewController {
    
    private let FowlFortuneViewModel = FowlFortuneFactsViewModel()
    private var FowlFortuneFactsTableView: UITableView!
    private var FowlFortuneSegmentedControl: UISegmentedControl!
    private var FowlFortuneSearchBar: UISearchBar!
    private var FowlFortuneTitleLabel: UILabel!
    private var FowlFortuneHeaderView: UIView!
    private var FowlFortuneTestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FowlFortuneSetupUI()
        FowlFortuneSetupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FowlFortuneViewModel.FowlFortuneFilterByCategory(nil)
    }
    
    private func FowlFortuneSetupUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        
        FowlFortuneSetupHeaderView()
        FowlFortuneSetupSegmentedControl()
        FowlFortuneSetupSearchBar()
        FowlFortuneSetupTestButton()
        FowlFortuneSetupTableView()
        FowlFortuneSetupConstraints()
    }
    
    private func FowlFortuneSetupHeaderView() {
        FowlFortuneHeaderView = UIView()
        FowlFortuneHeaderView.backgroundColor = UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0)
        FowlFortuneHeaderView.layer.cornerRadius = 12
        FowlFortuneHeaderView.layer.shadowOpacity = 0.15
        FowlFortuneHeaderView.layer.shadowRadius = 6
        FowlFortuneHeaderView.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneTitleLabel = UILabel()
        FowlFortuneTitleLabel.text = "📚 Chicken Facts"
        FowlFortuneTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        FowlFortuneTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneTitleLabel.textAlignment = .center
        FowlFortuneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(FowlFortuneHeaderView)
        FowlFortuneHeaderView.addSubview(FowlFortuneTitleLabel)
    }
    
    private func FowlFortuneSetupSegmentedControl() {
        let FowlFortuneCategories = FowlFortuneViewModel.FowlFortuneGetCategories()
        let FowlFortuneCategoryTitles = FowlFortuneCategories.map { "\($0.FowlFortuneCategoryEmoji) \($0.FowlFortuneCategoryName)" }
        
        FowlFortuneSegmentedControl = UISegmentedControl(items: FowlFortuneCategoryTitles)
        FowlFortuneSegmentedControl.selectedSegmentIndex = 0
        FowlFortuneSegmentedControl.backgroundColor = UIColor(red: 0.85, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneSegmentedControl.selectedSegmentTintColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        FowlFortuneSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)], for: .normal)
        FowlFortuneSegmentedControl.addTarget(self, action: #selector(FowlFortuneSegmentedControlChanged), for: .valueChanged)
        FowlFortuneSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(FowlFortuneSegmentedControl)
    }
    
    private func FowlFortuneSetupSearchBar() {
        FowlFortuneSearchBar = UISearchBar()
        FowlFortuneSearchBar.placeholder = "Search facts..."
        FowlFortuneSearchBar.searchBarStyle = .minimal
        FowlFortuneSearchBar.backgroundColor = UIColor.clear
        FowlFortuneSearchBar.delegate = self
        FowlFortuneSearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        if let FowlFortuneTextField = FowlFortuneSearchBar.value(forKey: "searchField") as? UITextField {
            FowlFortuneTextField.backgroundColor = UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0)
            FowlFortuneTextField.layer.cornerRadius = 8
            FowlFortuneTextField.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        }
        
        view.addSubview(FowlFortuneSearchBar)
    }
    
    private func FowlFortuneSetupTestButton() {
        FowlFortuneTestButton = UIButton(type: .system)
        FowlFortuneTestButton.setTitle("🧠 Take Quiz", for: .normal)
        FowlFortuneTestButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        FowlFortuneTestButton.setTitleColor(UIColor.white, for: .normal)
        FowlFortuneTestButton.backgroundColor = UIColor(red: 0.6, green: 0.4, blue: 0.8, alpha: 1.0)
        FowlFortuneTestButton.layer.cornerRadius = 12
        FowlFortuneTestButton.layer.shadowColor = UIColor.black.cgColor
        FowlFortuneTestButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        FowlFortuneTestButton.layer.shadowOpacity = 0.2
        FowlFortuneTestButton.layer.shadowRadius = 6
        FowlFortuneTestButton.layer.borderWidth = 2
        FowlFortuneTestButton.layer.borderColor = UIColor(red: 0.7, green: 0.5, blue: 0.9, alpha: 1.0).cgColor
        FowlFortuneTestButton.addTarget(self, action: #selector(FowlFortuneTestButtonTapped), for: .touchUpInside)
        FowlFortuneTestButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(FowlFortuneTestButton)
    }
    
    private func FowlFortuneSetupTableView() {
        FowlFortuneFactsTableView = UITableView()
        FowlFortuneFactsTableView.backgroundColor = UIColor.clear
        FowlFortuneFactsTableView.separatorStyle = .none
        FowlFortuneFactsTableView.delegate = self
        FowlFortuneFactsTableView.dataSource = self
        FowlFortuneFactsTableView.register(FowlFortuneFactTableViewCell.self, forCellReuseIdentifier: "FowlFortuneFactCell")
        FowlFortuneFactsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(FowlFortuneFactsTableView)
    }
    
    private func FowlFortuneSetupConstraints() {
        NSLayoutConstraint.activate([
            FowlFortuneHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            FowlFortuneHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            FowlFortuneHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            FowlFortuneHeaderView.heightAnchor.constraint(equalToConstant: 60),
            
            FowlFortuneTitleLabel.centerXAnchor.constraint(equalTo: FowlFortuneHeaderView.centerXAnchor),
            FowlFortuneTitleLabel.centerYAnchor.constraint(equalTo: FowlFortuneHeaderView.centerYAnchor),
            
            FowlFortuneSegmentedControl.topAnchor.constraint(equalTo: FowlFortuneHeaderView.bottomAnchor, constant: 15),
            FowlFortuneSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            FowlFortuneSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            FowlFortuneSegmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
            FowlFortuneSearchBar.topAnchor.constraint(equalTo: FowlFortuneSegmentedControl.bottomAnchor, constant: 10),
            FowlFortuneSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            FowlFortuneSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            FowlFortuneSearchBar.heightAnchor.constraint(equalToConstant: 50),
            
            FowlFortuneTestButton.topAnchor.constraint(equalTo: FowlFortuneSearchBar.bottomAnchor, constant: 15),
            FowlFortuneTestButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            FowlFortuneTestButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            FowlFortuneTestButton.heightAnchor.constraint(equalToConstant: 50),
            
            FowlFortuneFactsTableView.topAnchor.constraint(equalTo: FowlFortuneTestButton.bottomAnchor, constant: 15),
            FowlFortuneFactsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            FowlFortuneFactsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            FowlFortuneFactsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func FowlFortuneSetupBindings() {
        FowlFortuneViewModel.FowlFortuneFactsUpdateCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.FowlFortuneFactsTableView.reloadData()
            }
        }
    }
    
    @objc private func FowlFortuneSegmentedControlChanged() {
        let FowlFortuneCategories = FowlFortuneViewModel.FowlFortuneGetCategories()
        let FowlFortuneSelectedIndex = FowlFortuneSegmentedControl.selectedSegmentIndex
        
        if FowlFortuneSelectedIndex == 0 {
            FowlFortuneViewModel.FowlFortuneFilterByCategory(nil)
        } else {
            let FowlFortuneCategory = FowlFortuneCategories[FowlFortuneSelectedIndex - 1]
            FowlFortuneViewModel.FowlFortuneFilterByCategory(FowlFortuneCategory)
        }
    }
    
    @objc private func FowlFortuneTestButtonTapped() {
        let FowlFortuneQuizViewController = FowlFortuneQuizViewController()
        FowlFortuneQuizViewController.modalPresentationStyle = .fullScreen
        FowlFortuneQuizViewController.modalTransitionStyle = .coverVertical
        present(FowlFortuneQuizViewController, animated: true)
    }
}

extension FowlFortuneFactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FowlFortuneViewModel.FowlFortuneGetFactCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FowlFortuneFactCell", for: indexPath) as! FowlFortuneFactTableViewCell
        let facts = FowlFortuneViewModel.FowlFortuneGetAllFacts()
        let fact = facts[indexPath.row]
        cell.FowlFortuneConfigure(with: fact)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let facts = FowlFortuneViewModel.FowlFortuneGetAllFacts()
        let fact = facts[indexPath.row]
        
        let FowlFortuneDetailViewController = FowlFortuneFactDetailViewController()
        FowlFortuneDetailViewController.FowlFortuneConfigure(with: fact)
        FowlFortuneDetailViewController.modalPresentationStyle = .pageSheet
        FowlFortuneDetailViewController.modalTransitionStyle = .coverVertical
        present(FowlFortuneDetailViewController, animated: true)
    }
}

extension FowlFortuneFactsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        FowlFortuneViewModel.FowlFortuneSearchFacts(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

class FowlFortuneFactTableViewCell: UITableViewCell {
    
    private let FowlFortuneCardView = UIView()
    private let FowlFortuneEmojiLabel = UILabel()
    private let FowlFortuneTitleLabel = UILabel()
    private let FowlFortuneDescriptionLabel = UILabel()
    private let FowlFortuneCategoryLabel = UILabel()
    private let FowlFortuneArrowImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        FowlFortuneSetupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func FowlFortuneSetupUI() {
        backgroundColor = UIColor.clear
        selectionStyle = .none
        
        FowlFortuneCardView.backgroundColor = UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0)
        FowlFortuneCardView.layer.cornerRadius = 12
        FowlFortuneCardView.layer.shadowColor = UIColor.black.cgColor
        FowlFortuneCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneCardView.layer.shadowOpacity = 0.1
        FowlFortuneCardView.layer.shadowRadius = 4
        FowlFortuneCardView.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneEmojiLabel.font = UIFont.systemFont(ofSize: 40)
        FowlFortuneEmojiLabel.textAlignment = .center
        FowlFortuneEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        FowlFortuneTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneTitleLabel.numberOfLines = 2
        FowlFortuneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneDescriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        FowlFortuneDescriptionLabel.textColor = UIColor(red: 0.3, green: 0.5, blue: 0.4, alpha: 1.0)
        FowlFortuneDescriptionLabel.numberOfLines = 3
        FowlFortuneDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneCategoryLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        FowlFortuneCategoryLabel.textColor = UIColor(red: 0.6, green: 0.7, blue: 0.6, alpha: 1.0)
        FowlFortuneCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneArrowImageView.image = UIImage(systemName: "chevron.right")
        FowlFortuneArrowImageView.tintColor = UIColor(red: 0.4, green: 0.6, blue: 0.5, alpha: 1.0)
        FowlFortuneArrowImageView.contentMode = .scaleAspectFit
        FowlFortuneArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(FowlFortuneCardView)
        FowlFortuneCardView.addSubview(FowlFortuneEmojiLabel)
        FowlFortuneCardView.addSubview(FowlFortuneTitleLabel)
        FowlFortuneCardView.addSubview(FowlFortuneDescriptionLabel)
        FowlFortuneCardView.addSubview(FowlFortuneCategoryLabel)
        FowlFortuneCardView.addSubview(FowlFortuneArrowImageView)
        
        FowlFortuneSetupConstraints()
    }
    
    private func FowlFortuneSetupConstraints() {
        NSLayoutConstraint.activate([
            FowlFortuneCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            FowlFortuneCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            FowlFortuneCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            FowlFortuneCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            FowlFortuneEmojiLabel.leadingAnchor.constraint(equalTo: FowlFortuneCardView.leadingAnchor, constant: 15),
            FowlFortuneEmojiLabel.centerYAnchor.constraint(equalTo: FowlFortuneCardView.centerYAnchor),
            FowlFortuneEmojiLabel.widthAnchor.constraint(equalToConstant: 50),
            FowlFortuneEmojiLabel.heightAnchor.constraint(equalToConstant: 50),
            
            FowlFortuneTitleLabel.topAnchor.constraint(equalTo: FowlFortuneCardView.topAnchor, constant: 12),
            FowlFortuneTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneEmojiLabel.trailingAnchor, constant: 12),
            FowlFortuneTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneArrowImageView.leadingAnchor, constant: -12),
            
            FowlFortuneDescriptionLabel.topAnchor.constraint(equalTo: FowlFortuneTitleLabel.bottomAnchor, constant: 4),
            FowlFortuneDescriptionLabel.leadingAnchor.constraint(equalTo: FowlFortuneTitleLabel.leadingAnchor),
            FowlFortuneDescriptionLabel.trailingAnchor.constraint(equalTo: FowlFortuneTitleLabel.trailingAnchor),
            
            FowlFortuneCategoryLabel.topAnchor.constraint(equalTo: FowlFortuneDescriptionLabel.bottomAnchor, constant: 4),
            FowlFortuneCategoryLabel.leadingAnchor.constraint(equalTo: FowlFortuneTitleLabel.leadingAnchor),
            FowlFortuneCategoryLabel.bottomAnchor.constraint(equalTo: FowlFortuneCardView.bottomAnchor, constant: -12),
            
            FowlFortuneArrowImageView.trailingAnchor.constraint(equalTo: FowlFortuneCardView.trailingAnchor, constant: -15),
            FowlFortuneArrowImageView.centerYAnchor.constraint(equalTo: FowlFortuneCardView.centerYAnchor),
            FowlFortuneArrowImageView.widthAnchor.constraint(equalToConstant: 20),
            FowlFortuneArrowImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func FowlFortuneConfigure(with fact: FowlFortuneChickenFact) {
        FowlFortuneEmojiLabel.text = fact.FowlFortuneFactEmoji
        FowlFortuneTitleLabel.text = fact.FowlFortuneFactTitle
        FowlFortuneDescriptionLabel.text = fact.FowlFortuneFactShortDescription
        FowlFortuneCategoryLabel.text = fact.FowlFortuneFactCategory.FowlFortuneCategoryEmoji + " " + fact.FowlFortuneFactCategory.FowlFortuneCategoryName
    }
}
