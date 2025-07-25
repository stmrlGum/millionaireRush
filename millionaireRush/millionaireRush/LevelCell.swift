//
//  LevelCell.swift
//  millionaireRush
//
//  Created by Rustam on 22.07.2025.
//

import UIKit

class LevelCell: UITableViewCell {
    
    let numberLabel = UILabel()
    let prizeLabel = UILabel()
    let container = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 10
        container.layer.masksToBounds = true
        contentView.addSubview(container)

        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        prizeLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.font = UIFont.boldSystemFont(ofSize: 16)
        prizeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        numberLabel.textColor = .white
        prizeLabel.textColor = .white

        container.addSubview(numberLabel)
        container.addSubview(prizeLabel)

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),

            numberLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            numberLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),

            prizeLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            prizeLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
        ])
    }

    func configure(number: Int, prize: String, isCurrent: Bool, isGuaranteed: Bool, isSelected: Bool) {
        numberLabel.text = "\(number):"
        prizeLabel.text = prize

        if isSelected {
            container.backgroundColor = UIColor.systemGreen
        } else if isCurrent {
            container.backgroundColor = UIColor.systemCyan
        } else if isGuaranteed {
            container.backgroundColor = UIColor(red: 1.0, green: 0.75, blue: 0.0, alpha: 1.0)
        } else {
            container.backgroundColor = UIColor(red: 10/255, green: 80/255, blue: 180/255, alpha: 1)
        }
    }
}
