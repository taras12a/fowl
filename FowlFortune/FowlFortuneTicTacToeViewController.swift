import UIKit

class FowlFortuneTicTacToeViewController: UIViewController {
    
    private let FowlFortuneGame = FowlFortuneTicTacToeGame()
    private var FowlFortuneGameButtons: [UIButton] = []
    
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
        FowlFortuneHeaderView.backgroundColor = UIColor(red: 0.90, green: 0.95, blue: 0.90, alpha: 1.0)
        FowlFortuneHeaderView.layer.cornerRadius = 12
        FowlFortuneHeaderView.layer.shadowOpacity = 0.15
        FowlFortuneHeaderView.layer.shadowRadius = 6
        FowlFortuneHeaderView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return FowlFortuneHeaderView
    }()
    
    private lazy var FowlFortuneTitleLabel: UILabel = {
        let FowlFortuneTitleLabel = UILabel()
        FowlFortuneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneTitleLabel.text = "🐔 Chicken vs Egg 🥚"
        FowlFortuneTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        FowlFortuneTitleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneTitleLabel.textAlignment = .center
        return FowlFortuneTitleLabel
    }()
    
    private lazy var FowlFortuneCurrentPlayerLabel: UILabel = {
        let FowlFortuneLabel = UILabel()
        FowlFortuneLabel.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneLabel.text = "🐔 Your turn!"
        FowlFortuneLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        FowlFortuneLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneLabel.textAlignment = .center
        return FowlFortuneLabel
    }()
    
    private lazy var FowlFortuneGameBoardView: UIView = {
        let FowlFortuneBoardView = UIView()
        FowlFortuneBoardView.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneBoardView.backgroundColor = UIColor.white
        FowlFortuneBoardView.layer.cornerRadius = 12
        FowlFortuneBoardView.layer.shadowOpacity = 0.15
        FowlFortuneBoardView.layer.shadowRadius = 6
        FowlFortuneBoardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        return FowlFortuneBoardView
    }()
    
    private lazy var FowlFortuneResetButton: UIButton = {
        let FowlFortuneButton = UIButton(type: .system)
        FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
        FowlFortuneButton.setTitle("🔄 New Game", for: .normal)
        FowlFortuneButton.backgroundColor = UIColor(red: 0.85, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneButton.setTitleColor(UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0), for: .normal)
        FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        FowlFortuneButton.layer.cornerRadius = 12
        FowlFortuneButton.layer.shadowOpacity = 0.15
        FowlFortuneButton.layer.shadowRadius = 6
        FowlFortuneButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneButton.addTarget(self, action: #selector(FowlFortuneResetButtonTapped), for: .touchUpInside)
        return FowlFortuneButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFowlFortuneUI()
        setupFowlFortuneGameBoard()
    }
    
    private func setupFowlFortuneUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        title = "Tic Tac Toe"
        
        view.addSubview(FowlFortuneScrollView)
        FowlFortuneScrollView.addSubview(FowlFortuneContentView)
        
        FowlFortuneContentView.addSubview(FowlFortuneHeaderView)
        FowlFortuneContentView.addSubview(FowlFortuneGameBoardView)
        FowlFortuneContentView.addSubview(FowlFortuneResetButton)
        
        FowlFortuneHeaderView.addSubview(FowlFortuneTitleLabel)
        FowlFortuneHeaderView.addSubview(FowlFortuneCurrentPlayerLabel)
        
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
            FowlFortuneHeaderView.heightAnchor.constraint(equalToConstant: 100),
            
            FowlFortuneTitleLabel.topAnchor.constraint(equalTo: FowlFortuneHeaderView.topAnchor, constant: 16),
            FowlFortuneTitleLabel.leadingAnchor.constraint(equalTo: FowlFortuneHeaderView.leadingAnchor, constant: 16),
            FowlFortuneTitleLabel.trailingAnchor.constraint(equalTo: FowlFortuneHeaderView.trailingAnchor, constant: -16),
            
            FowlFortuneCurrentPlayerLabel.topAnchor.constraint(equalTo: FowlFortuneTitleLabel.bottomAnchor, constant: 8),
            FowlFortuneCurrentPlayerLabel.leadingAnchor.constraint(equalTo: FowlFortuneHeaderView.leadingAnchor, constant: 16),
            FowlFortuneCurrentPlayerLabel.trailingAnchor.constraint(equalTo: FowlFortuneHeaderView.trailingAnchor, constant: -16),
            
            FowlFortuneGameBoardView.topAnchor.constraint(equalTo: FowlFortuneHeaderView.bottomAnchor, constant: 20),
            FowlFortuneGameBoardView.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneGameBoardView.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            FowlFortuneGameBoardView.heightAnchor.constraint(equalTo: FowlFortuneGameBoardView.widthAnchor),
            
            FowlFortuneResetButton.topAnchor.constraint(equalTo: FowlFortuneGameBoardView.bottomAnchor, constant: 20),
            FowlFortuneResetButton.leadingAnchor.constraint(equalTo: FowlFortuneContentView.leadingAnchor, constant: 20),
            FowlFortuneResetButton.trailingAnchor.constraint(equalTo: FowlFortuneContentView.trailingAnchor, constant: -20),
            FowlFortuneResetButton.heightAnchor.constraint(equalToConstant: 50),
            FowlFortuneResetButton.bottomAnchor.constraint(equalTo: FowlFortuneContentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupFowlFortuneGameBoard() {
        FowlFortuneGameButtons.removeAll()
        
        let FowlFortuneButtonSize: CGFloat = 80
        let FowlFortuneSpacing: CGFloat = 10
        let FowlFortuneTotalWidth = (FowlFortuneButtonSize * 3) + (FowlFortuneSpacing * 2)
        let FowlFortuneStartX = (FowlFortuneGameBoardView.frame.width - FowlFortuneTotalWidth) / 2
        
        for row in 0..<3 {
            for col in 0..<3 {
                let FowlFortuneButton = UIButton(type: .system)
                FowlFortuneButton.translatesAutoresizingMaskIntoConstraints = false
                FowlFortuneButton.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
                FowlFortuneButton.layer.cornerRadius = 8
                FowlFortuneButton.layer.borderWidth = 2
                FowlFortuneButton.layer.borderColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 0.3).cgColor
                FowlFortuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
                FowlFortuneButton.setTitleColor(UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0), for: .normal)
                FowlFortuneButton.tag = row * 3 + col
                FowlFortuneButton.addTarget(self, action: #selector(FowlFortuneGameButtonTapped(_:)), for: .touchUpInside)
                
                FowlFortuneGameBoardView.addSubview(FowlFortuneButton)
                FowlFortuneGameButtons.append(FowlFortuneButton)
                
                NSLayoutConstraint.activate([
                    FowlFortuneButton.widthAnchor.constraint(equalToConstant: FowlFortuneButtonSize),
                    FowlFortuneButton.heightAnchor.constraint(equalToConstant: FowlFortuneButtonSize),
                    FowlFortuneButton.centerXAnchor.constraint(equalTo: FowlFortuneGameBoardView.centerXAnchor, constant: CGFloat(col - 1) * (FowlFortuneButtonSize + FowlFortuneSpacing)),
                    FowlFortuneButton.centerYAnchor.constraint(equalTo: FowlFortuneGameBoardView.centerYAnchor, constant: CGFloat(row - 1) * (FowlFortuneButtonSize + FowlFortuneSpacing))
                ])
            }
        }
    }
    
    @objc private func FowlFortuneGameButtonTapped(_ sender: UIButton) {
        let FowlFortuneIndex = sender.tag
        
        guard FowlFortuneGame.FowlFortuneCurrentPlayerTurn == .chicken else {
            return
        }
        
        if FowlFortuneGame.FowlFortuneMakeMove(at: FowlFortuneIndex) {
            FowlFortuneUpdateGameBoard()
            FowlFortuneUpdateCurrentPlayerLabel()
            
            if FowlFortuneGame.FowlFortuneCurrentGameState == .playing && FowlFortuneGame.FowlFortuneCurrentPlayerTurn == .egg {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.FowlFortuneMakeBotMove()
                }
            } else {
                FowlFortuneCheckGameEnd()
            }
        }
    }
    
    private func FowlFortuneMakeBotMove() {
        if let FowlFortuneBotMove = FowlFortuneGame.FowlFortuneMakeBotMove() {
            FowlFortuneUpdateGameBoard()
            FowlFortuneUpdateCurrentPlayerLabel()
            FowlFortuneCheckGameEnd()
        }
    }
    
    private func FowlFortuneUpdateGameBoard() {
        let FowlFortuneBoard = FowlFortuneGame.FowlFortuneGameBoard
        
        for (index, player) in FowlFortuneBoard.enumerated() {
            let FowlFortuneButton = FowlFortuneGameButtons[index]
            
            if let player = player {
                FowlFortuneButton.setTitle(player.rawValue, for: .normal)
                FowlFortuneButton.isEnabled = false
                FowlFortuneButton.backgroundColor = player == .chicken ? UIColor(red: 0.85, green: 0.92, blue: 0.85, alpha: 1.0) : UIColor(red: 0.95, green: 0.95, blue: 0.85, alpha: 1.0)
            } else {
                FowlFortuneButton.setTitle("", for: .normal)
                FowlFortuneButton.isEnabled = FowlFortuneGame.FowlFortuneCurrentPlayerTurn == .chicken
                FowlFortuneButton.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
            }
        }
    }
    
    private func FowlFortuneUpdateCurrentPlayerLabel() {
        let FowlFortuneCurrentPlayer = FowlFortuneGame.FowlFortuneCurrentPlayerTurn
        
        switch FowlFortuneCurrentPlayer {
        case .chicken:
            FowlFortuneCurrentPlayerLabel.text = "🐔 Your turn!"
        case .egg:
            FowlFortuneCurrentPlayerLabel.text = "🥚 Bot's turn..."
        }
    }
    
    private func FowlFortuneCheckGameEnd() {
        let FowlFortuneGameState = FowlFortuneGame.FowlFortuneCurrentGameState
        
        switch FowlFortuneGameState {
        case .chickenWon:
            FowlFortuneShowGameResult(title: "🐔 You Won!", message: "Congratulations! The chicken defeated the egg!")
        case .eggWon:
            FowlFortuneShowGameResult(title: "🥚 Bot Won!", message: "The egg was too clever this time!")
        case .draw:
            FowlFortuneShowGameResult(title: "🤝 It's a Draw!", message: "Both chicken and egg are equally matched!")
        case .playing:
            break
        }
    }
    
    private func FowlFortuneShowGameResult(title: String, message: String) {
        let FowlFortuneResultType: FowlFortuneGameResultViewController.FowlFortuneGameResultType
        
        switch FowlFortuneGame.FowlFortuneCurrentGameState {
        case .chickenWon:
            FowlFortuneResultType = .chickenWon
        case .eggWon:
            FowlFortuneResultType = .eggWon
        case .draw:
            FowlFortuneResultType = .draw
        case .playing:
            return
        }
        
        let FowlFortuneResultViewController = FowlFortuneGameResultViewController(
            resultType: FowlFortuneResultType,
            onPlayAgain: { [weak self] in
                self?.FowlFortuneResetGame()
            },
            onClose: nil
        )
        
        present(FowlFortuneResultViewController, animated: true)
    }
    
    @objc private func FowlFortuneResetButtonTapped() {
        FowlFortuneResetGame()
    }
    
    private func FowlFortuneResetGame() {
        FowlFortuneGame.FowlFortuneResetGame()
        FowlFortuneUpdateGameBoard()
        FowlFortuneUpdateCurrentPlayerLabel()
    }
}
