//
//  AuthViewController+Extension.swift
//  Vinder
//
//  Created by Patrick Fischer on 17.10.19.
//  Copyright © 2019 Patrick Fischer. All rights reserved.
//

import Foundation
import FirebaseUI
import Firebase
import SwiftUI

final class FUIAuthBaseViewControllerWrapper: NSObject, UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    
    var cancel: () -> Void
    
    init(_ cancel: @escaping () -> Void) {
        self.cancel = cancel
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<FUIAuthBaseViewControllerWrapper>) -> UIViewController {
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        
        let providers: [FUIAuthProvider] = [FUIEmailAuth(),
//                         FUIGoogleAuth(),
//                         FUIFacebookAuth(),
                         FUIOAuth.appleAuthProvider()
        ]
        
        authUI?.privacyPolicyURL = URL(string: "www.google.de")
        authUI?.tosurl = URL(string: "www.google.de")
        authUI?.providers = providers
        let authViewController = (authUI?.authViewController())!
        return authViewController
    }
    
    @objc func cancelClicked() {
        cancel()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<FUIAuthBaseViewControllerWrapper>) {
        
    }
    
}

extension FUIAuthBaseViewControllerWrapper: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            if let errorCode = AuthErrorCode(rawValue: error._code) {
                switch errorCode.rawValue {
                case 1:
                    cancel()
                default:
                    print("Error not catched")
                }
                
            }
        }
    }
    
}
