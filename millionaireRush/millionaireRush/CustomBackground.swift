//
//  CustomBackground.swift
//  millionaireRush
//
//  Created by Alexander Ischenko on 21.07.2025.
//
//
import Foundation
import UIKit

class CustomBackground: UIView {
    
    let glowImageView2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Ellipse 7"))
//        imageView.frame = CGRect(x: 0, y: 70, width: 321, height: 321)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let glowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Ellipse 6"))
//        imageView.frame = CGRect(x: 280, y: 459, width: 179, height: 179)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
        setupGlowImage()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
        setupGlowImage()
    }

    private func setupGradient() {
        guard let gradient = layer as? CAGradientLayer else { return }
        gradient.colors = [
            UIColor(red: 55/255, green: 76/255, blue: 148/255, alpha: 1).cgColor,
            UIColor(red: 16/255, green: 14/255, blue: 2/255, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
    }
    
    private func setupGlowImage() {
        addSubview(glowImageView)
        addSubview(glowImageView2)
        
        NSLayoutConstraint.activate([
                    // Ellipse 7 (top left)
                    glowImageView2.topAnchor.constraint(equalTo: topAnchor, constant: 70),
                    glowImageView2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                    glowImageView2.widthAnchor.constraint(equalToConstant: 321),
                    glowImageView2.heightAnchor.constraint(equalToConstant: 321),
                    
                    // Ellipse 6 (bottom right)
                    glowImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200),
                    glowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                    glowImageView.widthAnchor.constraint(equalToConstant: 179),
                    glowImageView.heightAnchor.constraint(equalToConstant: 179)
                ])
    }
}


