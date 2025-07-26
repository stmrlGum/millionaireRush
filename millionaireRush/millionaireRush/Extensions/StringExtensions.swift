//
//  StringExtensions.swift
//  millionaireRush
//
//  Created by Danil on 26.07.2025.
//

import Foundation

extension String {
    func removingHTMLEntities() -> String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html
        ]
        if let attributed = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributed.string
        }
        return self
    }
}
