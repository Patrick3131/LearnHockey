//
//  AccountNotLoggedIn.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 03.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct NotLoggedInView: View {
    @Environment(\.locale) private var locale: Locale
    var loginButtonClicked: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("You are currently not logged in. Do you want to log in or create a new account?".localized(self.locale))
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, geometry.size.width * 0.2)
                Spacer().frame(height: geometry.size.height * 0.25)
                ActionButton(action: {
                    self.loginButtonClicked()
                }, title: "Login/Signup".localized(self.locale), width: geometry.size.width * 0.7)
            }
        }
        
    }
}


struct NotLoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        NotLoggedInView(loginButtonClicked: {
            
        }).environment(\.locale, .init(identifier: "de"))
    }
}
