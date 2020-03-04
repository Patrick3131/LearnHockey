//
//  AccountNotLoggedIn.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 03.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct AccountNotLoggedIn: View {
    
    var loginButtonClicked: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("You are currently not logged in. Do you want to log in or create a new account?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, geometry.size.width * 0.2)
                Spacer().frame(height: geometry.size.height * 0.25)
                LogInOutButton(action: {
                    self.loginButtonClicked()
                }, title: "Yes!", width: geometry.size.width * 0.7)
            }
        }
        
    }
}

struct AccountNotLoggedIn_Previews: PreviewProvider {
    static var previews: some View {
        AccountNotLoggedIn(loginButtonClicked: {
            
        })
    }
}
