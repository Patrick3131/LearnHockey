//
//  String+Extensions.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 06.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation

extension String {
    /// Add a space at the end of the String
    func addSpace() -> String {
        return self + " "
    }
    
    /// Add a . at the end of the String
    func addPoint() -> String {
        return self + "."
    }
    
    /// Add a ? at the end of the String
    func addQuestionMark() -> String {
        return self + "?"
    }
    
    /// Add a ! at the end of the String
    func addExclamationMark() -> String {
        return self + "!"
    }
    
    /// Add a , at the end of the String
    func addComma() -> String {
        return self + ","
    }
}

extension String {
    func localized(_ locale: Locale) -> String {
        let localeId = String(locale.identifier.prefix(2))
        guard let path = Bundle.main.path(forResource: localeId, ofType: "lproj"),
            let bundle = Bundle(path: path) else {
            return NSLocalizedString(self, comment: "")
        }
        return bundle.localizedString(forKey: self, value: nil, table: nil)
    }
}
