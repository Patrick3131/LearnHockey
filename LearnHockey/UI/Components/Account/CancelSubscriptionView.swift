//
//  CancelSubscriptionView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 06.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct CancelSubscriptionView: View {
    var subscription: SubscriptionView.Subscription
    var cancel: () -> Void
    
    var body: some View {
        VStack {
            SubscriptionView(subscription: subscription)
            Spacer().frame(height: 50)
            ActionButton(action: {
                self.cancel()
            }, title: "Cancel Subscription", width: 300)
        }
    }
}

struct CancelSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        CancelSubscriptionView(subscription: SubscriptionView.Subscription.validSubscription(period: .monthly, cost: "15", valid: .renew("15 Mai")), cancel: {
            
        })
    }
}
