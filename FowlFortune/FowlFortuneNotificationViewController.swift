import UIKit

class FowlFortuneNotificationViewController: UIViewController {
    
    private let FowlFortuneTitle: String
    private let FowlFortuneMessage: String
    private let FowlFortuneIcon: String
    private var FowlFortuneOnDismiss: (() -> Void)?
    
    private lazy var FowlFortuneBackgroundView: UIView = {
        let FowlFortuneView = UIView()
        FowlFortuneView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return FowlFortuneView
    }()
    
    private lazy var FowlFortuneContentView: UIView = {
        let FowlFortuneView = UIView()
        FowlFortuneView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneView.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneView.layer.cornerRadius = 16
        FowlFortuneView.layer.shadowOpacity = 0.25
        FowlFortuneView.layer.shadowRadius = 10
        FowlFortuneView.layer.shadowOffset = CGSize(width: 0, height: 5)
        return FowlFortuneView
    }()
    
    private lazy var FowlFortuneIconLabel: UILabel = {
        let FowlFortuneLabel = UILabel()
        FowlFortuneLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLabel.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        FowlFortuneLabel.textAlignment = .center
        return FowlFortuneLabel
    }()
    
    private lazy var FowlFortuneTitleLabel: UILabel = {
        let FowlFortuneLabel = UILabel()
        FowlFortuneLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        FowlFortuneLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneLabel.textAlignment = .center
        return FowlFortuneLabel
    }()
    
    private lazy var FowlFortuneMessageLabel: UILabel = {
        let FowlFortuneLabel = UILabel()
        FowlFortuneLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        FowlFortuneLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        FowlFortuneLabel.textAlignment = .center
        FowlFortuneLabel.numberOfLines = 0
        return FowlFortuneLabel
    }()
    
    private lazy var FowlFortuneOKButton: UIButton = {
        let FowlFortuneButton = UIButton(type: .system)
        FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneButton.setTitle("✓ OK", for: .normal)
        FowlFortuneButton.backgroundColor = UIColor(red: 0.85, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneButton.setTitleColor(UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0), for: .normal)
        FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        FowlFortuneButton.layer.cornerRadius = 12
        FowlFortuneButton.layer.shadowOpacity = 0.15
        FowlFortuneButton.layer.shadowRadius = 6
        FowlFortuneButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneButton.addTarget(self, action: #selector(FowlFortuneOKButtonTapped), for: .touchUpInside)
        return FowlFortuneButton
    }()
    
    init(title: String, message: String, icon: String, onDismiss: (() -> Void)? = nil) {
        self.FowlFortuneTitle = title
        self.FowlFortuneMessage = message
        self.FowlFortuneIcon = icon
        self.FowlFortuneOnDismiss = onDismiss
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
        FowlFortuneAnimateIn()
    }
    
    private func setupFowlFortuneUI() {
        view.backgroundColor = UIColor.clear
        
        view.addSubview(FowlFortuneBackgroundView)
        FowlFortuneBackgroundView.addSubview(FowlFortuneContentView)
        
        FowlFortuneContentView.addSubview(FowlFortuneIconLabel)
        FowlFortuneContentView.addSubview(FowlFortuneTitleLabel)
        FowlFortuneContentView.addSubview(FowlFortuneMessageLabel)
        FowlFortuneContentView.addSubview(FowlFortuneOKButton)
        
        FowlFortuneIconLabel.text = FowlFortuneIcon
        FowlFortuneTitleLabel.text = FowlFortuneTitle
        FowlFortuneMessageLabel.text = FowlFortuneMessage
        
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
            
            FowlFortuneIconLabel.topAnchor.constraint(equalTo: FowlFortuneContentView.topAnchor, constant: 20),
            FowlFortuneIconLabel.centerXAnchor.constraint(equalTo: FowlFortuneContentView.centerXAnchor),
            
            FowlFortuneTitleLabel.topAnchor.constraint(equalTo: FowlFortuneIconLabel.bottomAnchor, constant: 12),
            FowlFortuneTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            
            FowlFortuneMessageLabel.topAnchor.constraint(equalTo: FowlFortuneTitleLabel.bottomAnchor, constant: 8),
            FowlFortuneMessageLabel.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneMessageLabel.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            
            FowlFortuneOKButton.topAnchor.constraint(equalTo: FowlFortuneMessageLabel.bottomAnchor, constant: 20),
            FowlFortuneOKButton.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneOKButton.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            FowlFortuneOKButton.bottomAnchor.constraint(equalTo: FowlFortuneContentView.bottomAnchor, constant: -20),
            FowlFortuneOKButton.heightAnchor.constraint(equalToConstant: 50)
        ])
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
    
    @objc private func FowlFortuneOKButtonTapped() {
        FowlFortuneAnimateOut {
            self.dismiss(animated: false) {
                self.FowlFortuneOnDismiss?()
            }
        }
    }
}
