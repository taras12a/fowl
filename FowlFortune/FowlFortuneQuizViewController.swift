import UIKit

class FowlFortuneQuizViewController: UIViewController {
    
    private let FowlFortuneViewModel = FowlFortuneQuizViewModel()
    private var FowlFortuneProgressView: UIProgressView!
    private var FowlFortuneQuestionNumberLabel: UILabel!
    private var FowlFortuneQuestionLabel: UILabel!
    private var FowlFortuneOptionsStackView: UIStackView!
    private var FowlFortuneOptionButtons: [UIButton] = []
    private var FowlFortuneExplanationView: UIView!
    private var FowlFortuneExplanationLabel: UILabel!
    private var FowlFortuneNextButton: UIButton!
    private var FowlFortuneHeaderView: UIView!
    private var FowlFortuneExitButton: UIButton!
    private var FowlFortuneCurrentAnswerIndex: Int = -1
    private var FowlFortuneIsAnswerSubmitted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FowlFortuneSetupUI()
        FowlFortuneSetupBindings()
        FowlFortuneStartQuiz()
    }
    
    private func FowlFortuneSetupUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.92, blue: 0.85, alpha: 1.0)
        
        FowlFortuneSetupHeaderView()
        FowlFortuneSetupProgressView()
        FowlFortuneSetupQuestionView()
        FowlFortuneSetupOptionsView()
        FowlFortuneSetupExplanationView()
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
        
        FowlFortuneQuestionNumberLabel = UILabel()
        FowlFortuneQuestionNumberLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        FowlFortuneQuestionNumberLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.36, alpha: 1.0)
        FowlFortuneQuestionNumberLabel.textAlignment = .center
        FowlFortuneQuestionNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneExitButton = UIButton(type: .system)
        FowlFortuneExitButton.setTitle("❌", for: .normal)
        FowlFortuneExitButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        FowlFortuneExitButton.setTitleColor(UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0), for: .normal)
        FowlFortuneExitButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        FowlFortuneExitButton.layer.cornerRadius = 15
        FowlFortuneExitButton.layer.shadowColor = UIColor.black.cgColor
        FowlFortuneExitButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        FowlFortuneExitButton.layer.shadowOpacity = 0.2
        FowlFortuneExitButton.layer.shadowRadius = 2
        FowlFortuneExitButton.addTarget(self, action: #selector(FowlFortuneExitButtonTapped), for: .touchUpInside)
        FowlFortuneExitButton.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneHeaderView.addSubview(FowlFortuneQuestionNumberLabel)
        FowlFortuneHeaderView.addSubview(FowlFortuneExitButton)
        view.addSubview(FowlFortuneHeaderView)
    }
    
    private func FowlFortuneSetupProgressView() {
        FowlFortuneProgressView = UIProgressView(progressViewStyle: .default)
        FowlFortuneProgressView.progressTintColor = UIColor(red: 0.2, green: 0.6, blue: 0.4, alpha: 1.0)
        FowlFortuneProgressView.trackTintColor = UIColor(red: 0.8, green: 0.9, blue: 0.8, alpha: 1.0)
        FowlFortuneProgressView.layer.cornerRadius = 4
        FowlFortuneProgressView.clipsToBounds = true
        FowlFortuneProgressView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(FowlFortuneProgressView)
    }
    
    private func FowlFortuneSetupQuestionView() {
        FowlFortuneQuestionLabel = UILabel()
        FowlFortuneQuestionLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        FowlFortuneQuestionLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        FowlFortuneQuestionLabel.numberOfLines = 0
        FowlFortuneQuestionLabel.textAlignment = .center
        FowlFortuneQuestionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(FowlFortuneQuestionLabel)
    }
    
    private func FowlFortuneSetupOptionsView() {
        FowlFortuneOptionsStackView = UIStackView()
        FowlFortuneOptionsStackView.axis = .vertical
        FowlFortuneOptionsStackView.spacing = 12
        FowlFortuneOptionsStackView.distribution = .fillEqually
        FowlFortuneOptionsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for i in 0..<4 {
            let FowlFortuneOptionButton = UIButton(type: .system)
            FowlFortuneOptionButton.backgroundColor = UIColor(red: 0.88, green: 0.94, blue: 0.88, alpha: 1.0)
            FowlFortuneOptionButton.setTitleColor(UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0), for: .normal)
            FowlFortuneOptionButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            FowlFortuneOptionButton.titleLabel?.numberOfLines = 0
            FowlFortuneOptionButton.titleLabel?.textAlignment = .left
            FowlFortuneOptionButton.contentHorizontalAlignment = .left
            FowlFortuneOptionButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
            FowlFortuneOptionButton.layer.cornerRadius = 12
            FowlFortuneOptionButton.layer.shadowColor = UIColor.black.cgColor
            FowlFortuneOptionButton.layer.shadowOffset = CGSize(width: 0, height: 2)
            FowlFortuneOptionButton.layer.shadowOpacity = 0.1
            FowlFortuneOptionButton.layer.shadowRadius = 4
            FowlFortuneOptionButton.tag = i
            FowlFortuneOptionButton.addTarget(self, action: #selector(FowlFortuneOptionButtonTapped(_:)), for: .touchUpInside)
            FowlFortuneOptionButton.translatesAutoresizingMaskIntoConstraints = false
            
            FowlFortuneOptionButtons.append(FowlFortuneOptionButton)
            FowlFortuneOptionsStackView.addArrangedSubview(FowlFortuneOptionButton)
        }
        
        view.addSubview(FowlFortuneOptionsStackView)
    }
    
    private func FowlFortuneSetupExplanationView() {
        FowlFortuneExplanationView = UIView()
        FowlFortuneExplanationView.backgroundColor = UIColor(red: 0.85, green: 0.92, blue: 0.85, alpha: 1.0)
        FowlFortuneExplanationView.layer.cornerRadius = 12
        FowlFortuneExplanationView.layer.shadowColor = UIColor.black.cgColor
        FowlFortuneExplanationView.layer.shadowOffset = CGSize(width: 0, height: 2)
        FowlFortuneExplanationView.layer.shadowOpacity = 0.1
        FowlFortuneExplanationView.layer.shadowRadius = 4
        FowlFortuneExplanationView.isHidden = true
        FowlFortuneExplanationView.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneExplanationLabel = UILabel()
        FowlFortuneExplanationLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        FowlFortuneExplanationLabel.textColor = UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0)
        FowlFortuneExplanationLabel.numberOfLines = 0
        FowlFortuneExplanationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneNextButton = UIButton(type: .system)
        FowlFortuneNextButton.setTitle("Next Question", for: .normal)
        FowlFortuneNextButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        FowlFortuneNextButton.setTitleColor(UIColor.white, for: .normal)
        FowlFortuneNextButton.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.4, alpha: 1.0)
        FowlFortuneNextButton.layer.cornerRadius = 8
        FowlFortuneNextButton.addTarget(self, action: #selector(FowlFortuneNextButtonTapped), for: .touchUpInside)
        FowlFortuneNextButton.translatesAutoresizingMaskIntoConstraints = false
        
        FowlFortuneExplanationView.addSubview(FowlFortuneExplanationLabel)
        FowlFortuneExplanationView.addSubview(FowlFortuneNextButton)
        view.addSubview(FowlFortuneExplanationView)
    }
    
    private func FowlFortuneSetupConstraints() {
        NSLayoutConstraint.activate([
            FowlFortuneHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            FowlFortuneHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            FowlFortuneHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            FowlFortuneHeaderView.heightAnchor.constraint(equalToConstant: 60),
            
            FowlFortuneQuestionNumberLabel.centerXAnchor.constraint(equalTo: FowlFortuneHeaderView.centerXAnchor),
            FowlFortuneQuestionNumberLabel.centerYAnchor.constraint(equalTo: FowlFortuneHeaderView.centerYAnchor),
            
            FowlFortuneExitButton.trailingAnchor.constraint(equalTo: FowlFortuneHeaderView.trailingAnchor, constant: -15),
            FowlFortuneExitButton.centerYAnchor.constraint(equalTo: FowlFortuneHeaderView.centerYAnchor),
            FowlFortuneExitButton.widthAnchor.constraint(equalToConstant: 30),
            FowlFortuneExitButton.heightAnchor.constraint(equalToConstant: 30),
            
            FowlFortuneProgressView.topAnchor.constraint(equalTo: FowlFortuneHeaderView.bottomAnchor, constant: 20),
            FowlFortuneProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            FowlFortuneProgressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            FowlFortuneProgressView.heightAnchor.constraint(equalToConstant: 8),
            
            FowlFortuneQuestionLabel.topAnchor.constraint(equalTo: FowlFortuneProgressView.bottomAnchor, constant: 30),
            FowlFortuneQuestionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            FowlFortuneQuestionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            FowlFortuneOptionsStackView.topAnchor.constraint(equalTo: FowlFortuneQuestionLabel.bottomAnchor, constant: 30),
            FowlFortuneOptionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            FowlFortuneOptionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            FowlFortuneExplanationView.topAnchor.constraint(equalTo: FowlFortuneOptionsStackView.bottomAnchor, constant: 20),
            FowlFortuneExplanationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            FowlFortuneExplanationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            FowlFortuneExplanationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            FowlFortuneExplanationLabel.topAnchor.constraint(equalTo: FowlFortuneExplanationView.topAnchor, constant: 15),
            FowlFortuneExplanationLabel.leadingAnchor.constraint(equalTo: FowlFortuneExplanationView.leadingAnchor, constant: 15),
            FowlFortuneExplanationLabel.trailingAnchor.constraint(equalTo: FowlFortuneExplanationView.trailingAnchor, constant: -15),
            
            FowlFortuneNextButton.topAnchor.constraint(equalTo: FowlFortuneExplanationLabel.bottomAnchor, constant: 15),
            FowlFortuneNextButton.centerXAnchor.constraint(equalTo: FowlFortuneExplanationView.centerXAnchor),
            FowlFortuneNextButton.widthAnchor.constraint(equalToConstant: 150),
            FowlFortuneNextButton.heightAnchor.constraint(equalToConstant: 44),
            FowlFortuneNextButton.bottomAnchor.constraint(equalTo: FowlFortuneExplanationView.bottomAnchor, constant: -15)
        ])
    }
    
    private func FowlFortuneSetupBindings() {
        FowlFortuneViewModel.FowlFortuneQuizUpdateCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.FowlFortuneUpdateUI()
            }
        }
        
        FowlFortuneViewModel.FowlFortuneQuizCompletionCallback = { [weak self] session in
            DispatchQueue.main.async {
                self?.FowlFortuneShowResults(session: session)
            }
        }
    }
    
    private func FowlFortuneStartQuiz() {
        _ = FowlFortuneViewModel.FowlFortuneStartNewQuiz()
        FowlFortuneUpdateUI()
    }
    
    private func FowlFortuneUpdateUI() {
        guard let question = FowlFortuneViewModel.FowlFortuneGetCurrentQuestion() else { return }
        
        let FowlFortuneQuestionNumber = FowlFortuneViewModel.FowlFortuneGetCurrentQuestionNumber()
        let FowlFortuneTotalQuestions = FowlFortuneViewModel.FowlFortuneGetTotalQuestions()
        
        FowlFortuneQuestionNumberLabel.text = "Question \(FowlFortuneQuestionNumber) of \(FowlFortuneTotalQuestions)"
        FowlFortuneQuestionLabel.text = question.FowlFortuneQuestionText
        
        let FowlFortuneProgress = FowlFortuneViewModel.FowlFortuneGetQuizProgress()
        FowlFortuneProgressView.setProgress(Float(FowlFortuneProgress), animated: true)
        
        for (index, button) in FowlFortuneOptionButtons.enumerated() {
            if index < question.FowlFortuneQuestionOptions.count {
                button.setTitle(question.FowlFortuneQuestionOptions[index], for: .normal)
                button.isHidden = false
                FowlFortuneResetButtonAppearance(button)
            } else {
                button.isHidden = true
            }
        }
        
        FowlFortuneExplanationView.isHidden = true
        FowlFortuneIsAnswerSubmitted = false
        FowlFortuneCurrentAnswerIndex = -1
    }
    
    @objc private func FowlFortuneOptionButtonTapped(_ sender: UIButton) {
        guard !FowlFortuneIsAnswerSubmitted else { return }
        
        FowlFortuneCurrentAnswerIndex = sender.tag
        FowlFortuneSubmitAnswer()
    }
    
    private func FowlFortuneSubmitAnswer() {
        guard FowlFortuneCurrentAnswerIndex >= 0 else { return }
        
        let FowlFortuneIsCompleted = FowlFortuneViewModel.FowlFortuneSubmitAnswer(FowlFortuneCurrentAnswerIndex)
        
        if !FowlFortuneIsCompleted {
            FowlFortuneShowAnswerResult()
        }
        
        FowlFortuneIsAnswerSubmitted = true
    }
    
    private func FowlFortuneShowAnswerResult() {
        guard let question = FowlFortuneViewModel.FowlFortuneGetCurrentQuestion(),
              let previousQuestion = FowlFortuneViewModel.FowlFortuneGetCurrentSession()?.FowlFortuneQuestions[FowlFortuneViewModel.FowlFortuneGetCurrentQuestionNumber() - 2] else { return }
        
        let FowlFortuneCorrectIndex = previousQuestion.FowlFortuneCorrectAnswerIndex
        let FowlFortuneUserAnswerIndex = FowlFortuneCurrentAnswerIndex
        
        for (index, button) in FowlFortuneOptionButtons.enumerated() {
            if index == FowlFortuneCorrectIndex {
                button.backgroundColor = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1.0)
                button.setTitleColor(UIColor.white, for: .normal)
            } else if index == FowlFortuneUserAnswerIndex && FowlFortuneUserAnswerIndex != FowlFortuneCorrectIndex {
                button.backgroundColor = UIColor(red: 0.8, green: 0.3, blue: 0.3, alpha: 1.0)
                button.setTitleColor(UIColor.white, for: .normal)
            } else {
                button.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
                button.setTitleColor(UIColor.white, for: .normal)
            }
        }
        
        FowlFortuneExplanationLabel.text = "💡 \(previousQuestion.FowlFortuneQuestionExplanation)"
        
        // Обновляем текст кнопки в зависимости от того, последний ли это вопрос
        if FowlFortuneViewModel.FowlFortuneIsQuizCompleted() {
            FowlFortuneNextButton.setTitle("Finish Quiz 🏁", for: .normal)
        } else {
            FowlFortuneNextButton.setTitle("Next Question", for: .normal)
        }
        
        FowlFortuneExplanationView.isHidden = false
    }
    
    @objc private func FowlFortuneNextButtonTapped() {
        if FowlFortuneViewModel.FowlFortuneIsQuizCompleted() {
            FowlFortuneShowResults()
        } else {
            FowlFortuneUpdateUI()
        }
    }
    
    @objc private func FowlFortuneExitButtonTapped() {
        let alert = UIAlertController(title: "Exit Quiz", message: "Are you sure you want to exit the quiz? Your progress will be lost.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Exit", style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        
        present(alert, animated: true)
    }
    
    private func FowlFortuneShowResults(session: FowlFortuneQuizSession? = nil) {
        let FowlFortuneQuizSession = session ?? FowlFortuneViewModel.FowlFortuneGetCurrentSession()
        guard let session = FowlFortuneQuizSession else { return }
        
        let FowlFortuneResultsViewController = FowlFortuneQuizResultsViewController()
        FowlFortuneResultsViewController.FowlFortuneConfigure(with: session)
        FowlFortuneResultsViewController.modalPresentationStyle = .fullScreen
        FowlFortuneResultsViewController.modalTransitionStyle = .coverVertical
        present(FowlFortuneResultsViewController, animated: true)
    }
    
    private func FowlFortuneResetButtonAppearance(_ button: UIButton) {
        button.backgroundColor = UIColor(red: 0.88, green: 0.94, blue: 0.88, alpha: 1.0)
        button.setTitleColor(UIColor(red: 0.06, green: 0.23, blue: 0.24, alpha: 1.0), for: .normal)
    }
}
