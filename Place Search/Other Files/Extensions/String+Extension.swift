//
//  String+Extension.swift
//  Place Search
//
//  Created by Everson Trindade on 28/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

extension String {
    func formatFilterValue() -> String {
        return self.replacingOccurrences(of: "_", with: " ", options: NSString.CompareOptions.literal, range:nil).uppercased()
    }
    
    func formatSeachValue() -> String {
        return self.replacingOccurrences(of: " ", with: "+", options: NSString.CompareOptions.literal, range:nil).uppercased()
    }
}
