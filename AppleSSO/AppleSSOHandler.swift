//
//  AppleSSOHandler.swift
//  AppleSSO
//
//  Created by Jose Antonio Trejo Flores on 26/11/20.
//

import UIKit
import VideoSubscriberAccount

final class AppleSSOHandler: NSObject {
    private lazy var accountManager: VSAccountManager = {
        let accountManager = VSAccountManager()
        accountManager.delegate = self
        return accountManager
    }()
    
    private let providerManager: ProviderManager
    
    weak var presentInViewController: UIViewController?
    
    required init(providerManager: ProviderManager) {
        self.providerManager = providerManager
    }
    
    func requestMetadata() {
        checkAccessStatus { (status) in

            guard status == .granted else {
                return
            }
            
            self.enqueueMetadataRequest()
        }
    }
    
    func checkAccessStatus(accessStatus: ((VSAccountAccessStatus) -> Void)? = nil) {
        accountManager.checkAccessStatus(options: [.prompt: true]) { (status, error) in
            if let error = error {
                preconditionFailure(error.localizedDescription)
            }
            
            accessStatus?(status)
        }
    }
    
    private func enqueueMetadataRequest() {
        let includeAccountProviderIdentifier = true
        let includeAuthenticationExpirationDate = true
        let isInterruptionAllowed = true
               
        let metadataRequest = VSAccountMetadataRequest()
        metadataRequest.supportedAccountProviderIdentifiers = providerManager.supportedProviders
        metadataRequest.featuredAccountProviderIdentifiers = providerManager.featuredProviders
        metadataRequest.includeAccountProviderIdentifier = includeAccountProviderIdentifier
        metadataRequest.includeAuthenticationExpirationDate = includeAuthenticationExpirationDate
        metadataRequest.isInterruptionAllowed = isInterruptionAllowed
        
        accountManager.enqueue(metadataRequest) { (metadata, error) in
            
            if let error = error {
                preconditionFailure(error.localizedDescription)
            }
        }
    }
}

// MARK: - VSAccountManagerDelegate
extension AppleSSOHandler: VSAccountManagerDelegate {
    
    func accountManager(_ accountManager: VSAccountManager,
                        present viewController: UIViewController) {
        presentInViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func accountManager(_ accountManager: VSAccountManager,
                        dismiss viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func accountManager(_ accountManager: VSAccountManager,
                        shouldAuthenticateAccountProviderWithIdentifier accountProviderIdentifier: String) -> Bool {
        return true
    }
}
