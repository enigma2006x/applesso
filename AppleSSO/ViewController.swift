//
//  ViewController.swift
//  AppleSSO
//
//  Created by Jose Antonio Trejo Flores on 12/11/20.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var supportedTextView: UITextView?
    @IBOutlet private weak var featuredTextView: UITextView?
   
    private var providerManager: ProviderManager {
        guard let supportedProviders = supportedTextView?.text,
              let featuredProviders = featuredTextView?.text else {
            preconditionFailure("Provider resources could not be found.")
        }
        
        let manager = ProviderManager(supportedProviders: supportedProviders,
                                      featuredProviders: featuredProviders)
        return manager
    }
    
    private lazy var appleSSOHandler: AppleSSOHandler = {
        let handler = AppleSSOHandler(providerManager: providerManager)
        handler.presentInViewController = self
        return handler
    }()
    
    @IBAction private func checkStatusAction(_ sender: Any) {
        appleSSOHandler.checkAccessStatus()
    }
    
    @IBAction func metadataRequestAction(_ sender: Any) {
        appleSSOHandler.requestMetadata()
    }
}
