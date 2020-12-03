//
//  ScrollView-Extensions.swift
//  Expense Tracker
//
//  Created by isEmpty on 01.12.2020.
//

import UIKit

extension UIScrollView {
    var isBouncingTop: Bool {
        return contentOffset.y < topInsetForBouncing - contentInset.top
    }
    
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
