//
//  UISegmentControl.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 26/05/2021.
//

import UIKit

extension UISegmentedControl {
    /// Tint color doesn't have any effect on iOS 13.
    
    func ensureiOS12Style() {
        if #available(iOS 13, *) {
            self.backgroundColor = UIColor.clear
            self.layer.borderColor = UIColor.init(named: STRINGS.COLORS.NAVIGATION)?.cgColor
            self.selectedSegmentTintColor = UIColor.init(named: STRINGS.COLORS.NAVIGATION)
            self.layer.borderWidth = 0.5

            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(named: STRINGS.COLORS.NAVIGATION)]
            self.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key : Any], for:.normal)

            let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black]
            self.setTitleTextAttributes(titleTextAttributes1, for:.selected)
              
        }
    }
}
