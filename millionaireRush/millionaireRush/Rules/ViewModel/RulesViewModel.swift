//
//  RulesViewModel.swift
//  millionaireRush
//
//  Created by Ilnur on 30.07.2025.
//

import Foundation

class RulesViewModel {

    let ruleText: RuleText
        
    init(rulesService: RulesService) {
        self.ruleText = rulesService.mockData()
    }
    
    
}
