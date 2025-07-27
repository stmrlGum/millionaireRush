//
//  BoolExtension.swift
//  millionaireRush
//
//  Created by Danil on 27.07.2025.
//

extension Bool {
    static func random(probability: Double) -> Bool {
        return Double.random(in: 0...1) < probability
    }
}
