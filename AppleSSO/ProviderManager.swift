//
//  ProviderManager.swift
//  AppleSSO
//
//  Created by Jose Antonio Trejo Flores on 26/11/20.
//

import Foundation

struct ProviderManager {
    let supportedProviders: [String]
    let featuredProviders: [String]
    
    init(supportedProviders: String, featuredProviders: String) {
        self.supportedProviders = supportedProviders.split(separator: ",").compactMap({ String($0.trimmingCharacters(in: .whitespacesAndNewlines)) })
        self.featuredProviders = featuredProviders.split(separator: ",").compactMap({ String($0.trimmingCharacters(in: .whitespacesAndNewlines)) })
    }    
}

