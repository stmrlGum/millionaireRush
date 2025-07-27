//
//  UIButtonExtensions.swift
//  millionaireRush
//
//  Created by Danil on 23.07.2025.
//

import UIKit

extension UIButton {
    func changeState() {
        let originalImage = self.backgroundImage(for: .normal)
        self.setBackgroundImage(UIImage(named: "yellowButton"), for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.setBackgroundImage(originalImage, for: .normal)
        }
    }
}
