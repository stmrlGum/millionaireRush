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
    let container = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)
        backgroundColor = .clear
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
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 2),

            numberLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24),
            numberLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),

            prizeLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24),
            prizeLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
        ])
    }

    func configure(number: Int, prize: String, isCurrent: Bool, isGuaranteed: Bool, isSelected: Bool) {
        numberLabel.text = "\(number):"
        prizeLabel.text = prize

        if isSelected {
            container.image = UIImage(named: "yellowCell")
        } else if isCurrent {
            container.image = UIImage(named: "greenCell")
        } else if isGuaranteed {
            container.image = UIImage(named: "cyanCell")
        } else {
            container.image = UIImage(named: "blueCell")
        }
    }
}
