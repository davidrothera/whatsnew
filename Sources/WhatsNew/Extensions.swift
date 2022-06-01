//
//  Extensions.swift
//  
//
//  Created by David Rothera on 01/06/2022.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
