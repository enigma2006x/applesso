//
//  ViewController.swift
//  AppleSSO
//
//  Created by Jose Antonio Trejo Flores on 12/11/20.
//

import UIKit
import VideoSubscriberAccount

final class ViewController: UIViewController {

    private let accountManager = VSAccountManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction private func checkStatusAction(_ sender: Any) {
        accountManager.checkAccessStatus(options: [.prompt: true]) { (status, error) in
            print(status)
        }
    }
}
