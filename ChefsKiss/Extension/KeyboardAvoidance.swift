//
//  KeyboardAvoidance.swift
//  ChefsKiss
//
//  Created by Dominique Strachan on 10/11/24.
//

import Combine
import Foundation
import SwiftUI

extension Publishers {
    // Declare a keyboard height publisher that emits values of type CGFloat and can never fail with an error
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        // the notification center broadcasts a willShow or willHide notification, the corresponding publisher will also emit the notification as its value
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            // use the map operator since we are only interested in keyboard height
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        // Combine multiple publishers into one by merging their emitted values
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    // uses notification’s userInfo to get keyboard height
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

// used to avoid unnecessary scroll if keyboard isn't blocking view
extension UIResponder {
    // there can be at most one first responder in an iOS application, calling the UApplications sendAction() method directs the invocation to the correct responder (if any)
    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }
    
    private static weak var _currentFirstResponder: UIResponder?
    
    @objc private func findFirstResponder(_sender: Any) {
        UIResponder._currentFirstResponder = self
    }
    
    // globalFrame property calculates the responder frame in the global coordinate space
    var globalFrame: CGRect? {
        guard let view = self as? UIView else { return nil }
        return view.superview?.convert(view.frame, to: nil)
    }
}
