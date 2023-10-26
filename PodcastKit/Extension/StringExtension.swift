//
//  StringExtension.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 11/01/23.
//

import Foundation


extension String {
    var isEmailValid: Bool {
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return predicate.evaluate(with: self)
    }
}
