//
//  LogInOutButton.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 03.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct LogInOutButton: View {
    var action: () -> Void
    var title: String
    var width: CGFloat?

    var body: some View {
        Button(action: {
            print(self.title)
            self.action()
        }, label: {
            Text(title).font(.title)
            })
            .frame(width: self.width)
        .padding()
            .background(Color.white)
        .cornerRadius(5)
        .padding(1)
            .background(Color.black)
        .cornerRadius(5)
    }
}

struct LogInOutButton_Previews: PreviewProvider {
    static var previews: some View {
        LogInOutButton(action: {
            
        }, title: "Log in")
    }
}
