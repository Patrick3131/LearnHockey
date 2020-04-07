//
//  FeedbackView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 06.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct FeedbackView: View {
    
    var colorText = Color(.label)
    var colorButton = Color(.button)
    var action: () -> Void
    var body: some View {
        VStack(spacing: 20) {
            Text("Do you have Feedback?")
                .foregroundColor(colorText)
            Button(action: {
                self.action()
            }, label: {
                Text("Please let us know :)")
                    .foregroundColor(colorButton)
            })
        }
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView(action: {
            
        })
    }
}
