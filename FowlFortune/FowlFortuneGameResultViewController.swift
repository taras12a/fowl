import UIKit

class FowlFortuneGameResultViewController: UIViewController {
    
    enum FowlFortuneGameResultType {
        case chickenWon
        case eggWon
        case draw
    }
    
    private let FowlFortuneResultType: FowlFortuneGameResultType
    private var FowlFortuneOnPlayAgain: (() -> Void)?
    private var FowlFortuneOnClose: (() -> Void)?
    
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
    
    private lazy var FowlFortuneResultIconLabel: UILabel = {
        let FowlFortuneLabel = UILabel()
        FowlFortuneLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLabel.font = UIFont.systemFont(ofSize: 80, weight: .bold)
        FowlFortuneLabel.textAlignment = .center
        return FowlFortuneLabel
    }()
    
    private lazy var FowlFortuneResultTitleLabel: UILabel = {
        let FowlFortuneLabel = UILabel()
        FowlFortuneLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        FowlFortuneLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneLabel.textAlignment = .center
        return FowlFortuneLabel
    }()
    
    private lazy var FowlFortuneResultMessageLabel: UILabel = {
        let FowlFortuneLabel = UILabel()
        FowlFortuneLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        FowlFortuneLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        FowlFortuneLabel.textAlignment = .center
        FowlFortuneLabel.numberOfLines = 0
        return FowlFortuneLabel
    }()
    
    private lazy var FowlFortuneButtonsStackView: UIStackView = {
        let FowlFortuneStackView = UIStackView()
        FowlFortuneStackView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneStackView.axis = .horizontal
        FowlFortuneStackView.spacing = 16
        FowlFortuneStackView.distribution = .fillEqually
        return FowlFortuneStackView
    }()
    
    private lazy var FowlFortunePlayAgainButton: UIButton = {
        let FowlFortuneButton = UIButton(type: .system)
        FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneButton.setTitle("🔄 Play Again", for: .normal)
        FowlFortuneButton.backgroundColor = UIColor(red: 0.85, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneButton.setTitleColor(UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0), for: .normal)
        FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        FowlFortuneButton.layer.cornerRadius = 12
        FowlFortuneButton.layer.shadowOpacity = 0.15
        FowlFortuneButton.layer.shadowRadius = 6
        FowlFortuneButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneButton.addTarget(self, action: #selector(FowlFortunePlayAgainButtonTapped), for: .touchUpInside)
        return FowlFortuneButton
    }()
    
    private lazy var FowlFortuneCloseButton: UIButton = {
        let FowlFortuneButton = UIButton(type: .system)
        FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneButton.setTitle("✖️ Close", for: .normal)
        FowlFortuneButton.backgroundColor = UIColor(red: 0.9, green: 0.85, blue: 0.9, alpha: 1.0)
        FowlFortuneButton.setTitleColor(UIColor(red: 0.6, green: 0.2, blue: 0.6, alpha: 1.0), for: .normal)
        FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        FowlFortuneButton.layer.cornerRadius = 12
        FowlFortuneButton.layer.shadowOpacity = 0.15
        FowlFortuneButton.layer.shadowRadius = 6
        FowlFortuneButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneButton.addTarget(self, action: #selector(FowlFortuneCloseButtonTapped), for: .touchUpInside)
        return FowlFortuneButton
    }()
    
    init(resultType: FowlFortuneGameResultType, onPlayAgain: (() -> Void)? = nil, onClose: (() -> Void)? = nil) {
        self.FowlFortuneResultType = resultType
        self.FowlFortuneOnPlayAgain = onPlayAgain
        self.FowlFortuneOnClose = onClose
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
        setupFowlFortuneContent()
        FowlFortuneAnimateIn()
    }
    
    private func setupFowlFortuneUI() {
        view.backgroundColor = UIColor.clear
        
        view.addSubview(FowlFortuneBackgroundView)
        FowlFortuneBackgroundView.addSubview(FowlFortuneContentView)
        
        FowlFortuneContentView.addSubview(FowlFortuneResultIconLabel)
        FowlFortuneContentView.addSubview(FowlFortuneResultTitleLabel)
        FowlFortuneContentView.addSubview(FowlFortuneResultMessageLabel)
        FowlFortuneContentView.addSubview(FowlFortuneButtonsStackView)
        
        FowlFortuneButtonsStackView.addArrangedSubview(FowlFortunePlayAgainButton)
        FowlFortuneButtonsStackView.addArrangedSubview(FowlFortuneCloseButton)
        
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
            FowlFortuneContentView.leadingAnchor.constraint(equalTo: FowlFortuneBackgroundView.leadingAnchor, constant: 40),
            FowlFortuneContentView.trailingAnchor.constraint(equalTo: FowlFortuneBackgroundView.trailingAnchor, constant: -40),
            
            FowlFortuneResultIconLabel.topAnchor.constraint(equalTo: FowlFortuneContentView.topAnchor, constant: 30),
            FowlFortuneResultIconLabel.centerXAnchor.constraint(equalTo: FowlFortuneContentView.centerXAnchor),
            
            FowlFortuneResultTitleLabel.topAnchor.constraint(equalTo: FowlFortuneResultIconLabel.bottomAnchor, constant: 16),
            FowlFortuneResultTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneResultTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            
            FowlFortuneResultMessageLabel.topAnchor.constraint(equalTo: FowlFortuneResultTitleLabel.bottomAnchor, constant: 12),
            FowlFortuneResultMessageLabel.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneResultMessageLabel.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            
            FowlFortuneButtonsStackView.topAnchor.constraint(equalTo: FowlFortuneResultMessageLabel.bottomAnchor, constant: 30),
            FowlFortuneButtonsStackView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneButtonsStackView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            FowlFortuneButtonsStackView.bottomAnchor.constraint(equalTo: FowlFortuneContentView.bottomAnchor, constant: -30),
            
            FowlFortunePlayAgainButton.heightAnchor.constraint(equalToConstant: 50),
            FowlFortuneCloseButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupFowlFortuneContent() {
        switch FowlFortuneResultType {
        case .chickenWon:
            FowlFortuneResultIconLabel.text = "🐔"
            FowlFortuneResultTitleLabel.text = "Chicken Won!"
            FowlFortuneResultMessageLabel.text = "Congratulations! The chicken defeated the egg and proved its superiority!"
            
        case .eggWon:
            FowlFortuneResultIconLabel.text = "🥚"
            FowlFortuneResultTitleLabel.text = "Egg Won!"
            FowlFortuneResultMessageLabel.text = "The egg was too clever this time! Better luck next round!"
            
        case .draw:
            FowlFortuneResultIconLabel.text = "🤝"
            FowlFortuneResultTitleLabel.text = "It's a Draw!"
            FowlFortuneResultMessageLabel.text = "Both chicken and egg are equally matched! A perfect stalemate!"
        }
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
    
    @objc private func FowlFortunePlayAgainButtonTapped() {
        FowlFortuneAnimateOut {
            self.dismiss(animated: false) {
                self.FowlFortuneOnPlayAgain?()
            }
        }
    }
    
    @objc private func FowlFortuneCloseButtonTapped() {
        FowlFortuneAnimateOut {
            self.dismiss(animated: false) {
                self.FowlFortuneOnClose?()
            }
        }
    }
}
