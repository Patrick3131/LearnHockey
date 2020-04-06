//
//  LogInOutButton.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 03.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct ActionButton: View {
    var action: () -> Void
    var title: String
    var width: CGFloat?

    var body: some View {
        Button(action: {
            print(self.title)
            self.action()
        }, label: {
            Text(title).font(.title)
                .foregroundColor(Color.baseDark)
            })
            .frame(width: self.width)
        .padding()
            .background(Color(.systemBackground))
        .cornerRadius(5)
        .padding(1)
            .background(Color.black)
        .cornerRadius(5)
    }
}

struct LogInOutButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(action: {
            
        }, title: "Log in")
    }
}
