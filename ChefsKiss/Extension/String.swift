//
//  String.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 4/8/24.
//

import Foundation

extension String {
    func stringByStrippingHTMLTags() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    // for if I only expect title
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}


