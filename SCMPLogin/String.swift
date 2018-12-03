//
//  String.swift
//  SCMPLogin
//
//  Created by Norman Lim on 3/12/2018.
//  Copyright © 2018 Norman Lim. All rights reserved.
//

import Foundation

extension String {
    func isAlphanumeric() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-z0-9]*$")
        let range = NSRange(location: 0, length: self.utf16.count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
}
