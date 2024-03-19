//
//  UIApplication.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 3/18/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
