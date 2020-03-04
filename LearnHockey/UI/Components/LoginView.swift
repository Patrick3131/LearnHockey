//
//  LoginView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 01.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    var cancel: () -> Void
    var body: some View {
        FUIAuthBaseViewControllerWrapper() {
            self.cancel()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(cancel: {
            
        })
    }
}
