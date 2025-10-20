import UIKit

class FowlFortuneBuyChickenViewController: UIViewController {
    
    private var FowlFortuneOnChickenSelected: ((FowlFortuneChickenType) -> Void)?
    private var FowlFortuneOnCancel: (() -> Void)?
    
    private lazy var FowlFortuneBackgroundView: UIView = {
        let FowlFortuneView = UIView()
        FowlFortuneView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return FowlFortuneView
    }()
    
    private lazy var FowlFortuneContentView: UIView = {
        let FowlFortuneView = UIView()
        FowlFortuneView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneView.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneView.layer.cornerRadius = 20
        FowlFortuneView.layer.shadowOpacity = 0.3
        FowlFortuneView.layer.shadowRadius = 15
        FowlFortuneView.layer.shadowOffset = CGSize(width: 0, height: 8)
        return FowlFortuneView
    }()
    
    private lazy var FowlFortuneTitleLabel: UILabel = {
        let FowlFortuneLabel = UILabel()
        FowlFortuneLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLabel.text = "🐔 Buy Chicken"
        FowlFortuneLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        FowlFortuneLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneLabel.textAlignment = .center
        return FowlFortuneLabel
    }()
    
    private lazy var FowlFortuneSubtitleLabel: UILabel = {
        let FowlFortuneLabel = UILabel()
        FowlFortuneLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLabel.text = "Choose a chicken to add to your farm:"
        FowlFortuneLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        FowlFortuneLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        FowlFortuneLabel.textAlignment = .center
        return FowlFortuneLabel
    }()
    
    private lazy var FowlFortuneScrollView: UIScrollView = {
        let FowlFortuneScrollView = UIScrollView()
        FowlFortuneScrollView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneScrollView.showsVerticalScrollIndicator = false
        return FowlFortuneScrollView
    }()
    
    private lazy var FowlFortuneChickensStackView: UIStackView = {
        let FowlFortuneStackView = UIStackView()
        FowlFortuneStackView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneStackView.axis = .vertical
        FowlFortuneStackView.spacing = 12
        FowlFortuneStackView.distribution = .fillEqually
        return FowlFortuneStackView
    }()
    
    private lazy var FowlFortuneCancelButton: UIButton = {
        let FowlFortuneButton = UIButton(type: .system)
        FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneButton.setTitle("✖️ Cancel", for: .normal)
        FowlFortuneButton.backgroundColor = UIColor(red: 0.9, green: 0.85, blue: 0.9, alpha: 1.0)
        FowlFortuneButton.setTitleColor(UIColor(red: 0.6, green: 0.2, blue: 0.6, alpha: 1.0), for: .normal)
        FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        FowlFortuneButton.layer.cornerRadius = 12
        FowlFortuneButton.layer.shadowOpacity = 0.15
        FowlFortuneButton.layer.shadowRadius = 6
        FowlFortuneButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneButton.addTarget(self, action: #selector(FowlFortuneCancelButtonTapped), for: .touchUpInside)
        return FowlFortuneButton
    }()
    
    init(onChickenSelected: @escaping (FowlFortuneChickenType) -> Void, onCancel: (() -> Void)? = nil) {
        self.FowlFortuneOnChickenSelected = onChickenSelected
        self.FowlFortuneOnCancel = onCancel
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFowlFortuneUI()
        setupFowlFortuneChickens()
        FowlFortuneAnimateIn()
    }
    
    private func setupFowlFortuneUI() {
        view.backgroundColor = UIColor.clear
        
        view.addSubview(FowlFortuneBackgroundView)
        FowlFortuneBackgroundView.addSubview(FowlFortuneContentView)
        
        FowlFortuneContentView.addSubview(FowlFortuneTitleLabel)
        FowlFortuneContentView.addSubview(FowlFortuneSubtitleLabel)
        FowlFortuneContentView.addSubview(FowlFortuneScrollView)
        FowlFortuneContentView.addSubview(FowlFortuneCancelButton)
        
        FowlFortuneScrollView.addSubview(FowlFortuneChickensStackView)
        
        setupFowlFortuneConstraints()
    }
    
    private func setupFowlFortuneConstraints() {
        NSLayoutConstraint.activate([
            FowlFortuneBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            FowlFortuneBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            FowlFortuneBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            FowlFortuneBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            FowlFortuneContentView.centerXAnchor.constraint(equalTo: FowlFortuneBackgroundView.centerXAnchor),
            FowlFortuneContentView.centerYAnchor.constraint(equalTo: FowlFortuneBackgroundView.centerYAnchor),
            FowlFortuneContentView.leadingAnchor.constraint(equalTo: FowlFortuneBackgroundView.leadingAnchor, constant: 20),
            FowlFortuneContentView.trailingAnchor.constraint(equalTo: FowlFortuneBackgroundView.trailingAnchor, constant: -20),
            FowlFortuneContentView.heightAnchor.constraint(lessThanOrEqualToConstant: 600),
            
            FowlFortuneTitleLabel.topAnchor.constraint(equalTo: FowlFortuneContentView.topAnchor, constant: 20),
            FowlFortuneTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            
            FowlFortuneSubtitleLabel.topAnchor.constraint(equalTo: FowlFortuneTitleLabel.bottomAnchor, constant: 8),
            FowlFortuneSubtitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneSubtitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            
            FowlFortuneScrollView.topAnchor.constraint(equalTo: FowlFortuneSubtitleLabel.bottomAnchor, constant: 20),
            FowlFortuneScrollView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneScrollView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            FowlFortuneScrollView.bottomAnchor.constraint(equalTo: FowlFortuneCancelButton.topAnchor, constant: -20),
            FowlFortuneScrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
            FowlFortuneChickensStackView.topAnchor.constraint(equalTo: FowlFortuneScrollView.topAnchor),
            FowlFortuneChickensStackView.leadingAnchor.constraint(equalTo: FowlFortuneScrollView.leadingAnchor),
            FowlFortuneChickensStackView.trailingAnchor.constraint(equalTo: FowlFortuneScrollView.trailingAnchor),
            FowlFortuneChickensStackView.bottomAnchor.constraint(equalTo: FowlFortuneScrollView.bottomAnchor),
            FowlFortuneChickensStackView.widthAnchor.constraint(equalTo: FowlFortuneScrollView.widthAnchor),
            
            FowlFortuneCancelButton.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneCancelButton.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            FowlFortuneCancelButton.bottomAnchor.constraint(equalTo: FowlFortuneContentView.bottomAnchor, constant: -20),
            FowlFortuneCancelButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupFowlFortuneChickens() {
        print("Setting up chickens, count: \(FowlFortuneChickenType.allCases.count)")
        
        for FowlFortuneChickenType in FowlFortuneChickenType.allCases {
            let FowlFortuneChickenButton = createFowlFortuneChickenButton(for: FowlFortuneChickenType)
            FowlFortuneChickensStackView.addArrangedSubview(FowlFortuneChickenButton)
            print("Added button for: \(FowlFortuneChickenType.rawValue)")
        }
        
        DispatchQueue.main.async {
            self.FowlFortuneChickensStackView.layoutIfNeeded()
            print("Stack view arranged subviews count: \(self.FowlFortuneChickensStackView.arrangedSubviews.count)")
        }
    }
    
    private func createFowlFortuneChickenButton(for chickenType: FowlFortuneChickenType) -> UIButton {
        let FowlFortuneButton = UIButton(type: .system)
        FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
        
        let FowlFortuneTitle = "\(chickenType.FowlFortuneChickenEmoji) \(chickenType.rawValue)"
        let FowlFortuneSubtitle = "💰 \(chickenType.FowlFortuneChickenCost) credits"
        
        FowlFortuneButton.setTitle("\(FowlFortuneTitle)\n\(FowlFortuneSubtitle)", for: .normal)
        FowlFortuneButton.titleLabel?.numberOfLines = 0
        FowlFortuneButton.titleLabel?.textAlignment = .center
        FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        FowlFortuneButton.setTitleColor(UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0), for: .normal)
        FowlFortuneButton.backgroundColor = UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0)
        FowlFortuneButton.layer.cornerRadius = 12
        FowlFortuneButton.layer.shadowOpacity = 0.1
        FowlFortuneButton.layer.shadowRadius = 4
        FowlFortuneButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneButton.layer.borderWidth = 1
        FowlFortuneButton.layer.borderColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 0.2).cgColor
        FowlFortuneButton.addTarget(self, action: #selector(FowlFortuneChickenButtonTapped(_:)), for: .touchUpInside)
        FowlFortuneButton.tag = FowlFortuneChickenType.allCases.firstIndex(of: chickenType) ?? 0
        
        NSLayoutConstraint.activate([
            FowlFortuneButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        print("Created button for \(chickenType.rawValue) with tag \(FowlFortuneButton.tag)")
        
        return FowlFortuneButton
    }
    
    private func FowlFortuneAnimateIn() {
        FowlFortuneBackgroundView.alpha = 0
        FowlFortuneContentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        FowlFortuneContentView.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.FowlFortuneBackgroundView.alpha = 1
            self.FowlFortuneContentView.transform = .identity
            self.FowlFortuneContentView.alpha = 1
        }
    }
    
    private func FowlFortuneAnimateOut(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.FowlFortuneBackgroundView.alpha = 0
            self.FowlFortuneContentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.FowlFortuneContentView.alpha = 0
        } completion: { _ in
            completion()
        }
    }
    
    @objc private func FowlFortuneChickenButtonTapped(_ sender: UIButton) {
        print("Button tapped with tag: \(sender.tag)")
        let FowlFortuneChickenType = FowlFortuneChickenType.allCases[sender.tag]
        print("Selected chicken type: \(FowlFortuneChickenType.rawValue)")
        
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.FowlFortuneAnimateOut {
                self.dismiss(animated: false) {
                    self.FowlFortuneOnChickenSelected?(FowlFortuneChickenType)
                }
            }
        }
    }
    
    @objc private func FowlFortuneCancelButtonTapped() {
        FowlFortuneAnimateOut {
            self.dismiss(animated: false) {
                self.FowlFortuneOnCancel?()
            }
        }
    }
}
