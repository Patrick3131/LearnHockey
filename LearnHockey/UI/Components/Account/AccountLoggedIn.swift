//
//  AccountLoggedIn.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 03.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct AccountLoggedIn: View {
    var userName: String
    var logOut: () -> Void
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Hello " + self.userName + "!" ).font(.title)
                Text("You currently have a monthly membership for 10$ a month.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer().frame(height: geometry.size.height * 0.1)
                LogInOutButton(action: {
                    self.logOut()
                }, title: "Log out", width: geometry.size.width * 0.7)
            }
            
        }
        
    }
}

struct AccountLoggedIn_Previews: PreviewProvider {
    static var previews: some View {
        AccountLoggedIn(userName: "Patrick Fischer", logOut: {
            
        })
    }
}
