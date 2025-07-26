import UIKit

class ResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let backgroundImageView = UIImageView()
    let tableView = UITableView()
    let logoImageView = UIImageView()
    let helpButton = UIButton()

    let levels: [(number: Int, prize: String)] = [
        (15, "$1,000,000"),
        (14, "$500,000"),
        (13, "$250,000"),
        (12, "$100,000"),
        (11, "$50,000"),
        (10, "$25,000"),
        (9, "$15,000"),
        (8, "$12,500"),
        (7, "$10,000"),
        (6, "$7,500"),
        (5, "$5,000"),
        (4, "$3,000"),
        (3, "$2,000"),
        (2, "$1,000"),
        (1, "$500")
    ]
    
    let guaranteedLevels = [15]
    var currentLevels = [10, 5]
    var selectedLevel: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        selectedLevel = currentQuestionIndex + 1
        setupBackground()
        setupLogoAndHelp()
        setupTableView()
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
        
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        helpButton.setImage(UIImage(named: "withdrawal"), for: .normal)
        helpButton.tintColor = .white
        helpButton.addTarget(self, action: #selector(helpButtonTapped), for: .touchUpInside)
        view.addSubview(helpButton)

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 85),
            logoImageView.widthAnchor.constraint(equalToConstant: 85),

            helpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            helpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            helpButton.heightAnchor.constraint(equalToConstant: 30),
            helpButton.widthAnchor.constraint(equalToConstant: 30),
        ])
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .blue
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
        tableView.backgroundColor = .clear
    }


    @objc func helpButtonTapped() {
        let endVC = EndScreenVC()
        endVC.modalPresentationStyle = .fullScreen
        present(endVC, animated: true)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LevelCell", for: indexPath) as! LevelCell
        let level = levels[indexPath.row]
        let isCurrent = currentLevels.contains(level.number)
        let isGuaranteed = guaranteedLevels.contains(level.number)
        let isSelected = level.number == selectedLevel
        cell.configure(number: level.number, prize: level.prize, isCurrent: isCurrent, isGuaranteed: isGuaranteed, isSelected: isSelected)
        return cell
    }
    
    // MARK: - UITableViewDelegate

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let level = levels[indexPath.row]
//        selectedLevel = level.number
//        tableView.reloadData()
//    }
}

