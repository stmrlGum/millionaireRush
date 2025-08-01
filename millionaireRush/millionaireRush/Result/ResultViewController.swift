import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let backgroundImageView = UIImageView()
    let tableView = UITableView()
    let logoImageView = UIImageView()
    let putMoneyButton = UIButton()
    
    let viewModel = ResultViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.selectedLevel = currentQuestionIndex! + 1
        setupBackground()
        setupLogoAndHelp()
        setupTableView()
        print("Hello world")
    }

    // MARK: - UI Setup

    func setupBackground() {
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    func setupLogoAndHelp() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "logo")
        logoImageView.layer.zPosition = 60
        view.addSubview(logoImageView)
        
        putMoneyButton.translatesAutoresizingMaskIntoConstraints = false
        putMoneyButton.setImage(UIImage(named: "withdrawal"), for: .normal)
        putMoneyButton.tintColor = .white
        putMoneyButton.addTarget(self, action: #selector(putMoneyButtonTapped), for: .touchUpInside)
        view.addSubview(putMoneyButton)

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 85),
            logoImageView.widthAnchor.constraint(equalToConstant: 85),

            putMoneyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            putMoneyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            putMoneyButton.heightAnchor.constraint(equalToConstant: 30),
            putMoneyButton.widthAnchor.constraint(equalToConstant: 30),
        ])
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 99),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        tableView.contentInset.top = 60
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LevelCell.self, forCellReuseIdentifier: "LevelCell")
        tableView.rowHeight = 44
        tableView.separatorStyle = .none
    }

    @objc func putMoneyButtonTapped() {
        guard
            let selectedLevel = viewModel.selectedLevel,
            let prizeString = viewModel.prizeForSelectedLevel(),
            let numericValue = Int(prizeString.filter("0123456789".contains)) // Strip "$" and ","
        else { return }

        let endVM = EndScreenViewModel(score: numericValue, level: selectedLevel)
        let endVC = EndScreenVC(viewModel: endVM)
        endVC.modalPresentationStyle = .fullScreen
        present(endVC, animated: true)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfLevels()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LevelCell", for: indexPath) as? LevelCell else {
            return UITableViewCell()
        }

        let level = viewModel.level(at: indexPath.row)
        let isCurrent = viewModel.isCurrent(level: level.number)
        let isGuaranteed = viewModel.isGuaranteed(level: level.number)
        let isSelected = viewModel.selectedLevel == level.number

        cell.configure(number: level.number, prize: level.prize, isCurrent: isCurrent, isGuaranteed: isGuaranteed, isSelected: isSelected)
        return cell
    }
}

