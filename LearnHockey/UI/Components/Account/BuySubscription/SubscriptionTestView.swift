//
//  SubscriptionTestView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 06.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct SubscriptionTestView: View {
    var testing: () -> Void
    var notNow: () -> Void
    var body: some View {
        VStack(spacing: 20) {
            ActionButton(action: {
                self.testing()
            }, title: "Free testing", width: 150)
            ActionButton(action: {
                self.notNow()
            }, title: "Not now", width: 150)
        }
    }
}

struct SubscriptionTestView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionTestView(testing: {
            
        }, notNow: {
            
        })
    }
}
