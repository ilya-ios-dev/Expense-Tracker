//
//  ScrollView-Extensions.swift
//  Expense Tracker
//
//  Created by isEmpty on 01.12.2020.
//

import UIKit

extension UIScrollView {
    /// Returns true if the scrollview bounces off the top.
    var isBouncingTop: Bool {
        return contentOffset.y < topInsetForBouncing - contentInset.top
    }
    
    /// Returns true if the scrollview bounces off the bottom.
    var isBouncingBottom: Bool {
        let threshold: CGFloat
        if contentSize.height > frame.size.height {
            threshold = (contentSize.height - frame.size.height + contentInset.bottom + bottomInsetForBouncing)
        } else {
            threshold = topInsetForBouncing
        }
        return contentOffset.y > threshold
    }
    
    private var topInsetForBouncing: CGFloat {
        return safeAreaInsets.top != 0.0 ? -safeAreaInsets.top : 0.0
    }
    
    private var bottomInsetForBouncing: CGFloat {
        return safeAreaInsets.bottom
    }
}
