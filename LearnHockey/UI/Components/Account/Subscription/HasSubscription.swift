//
//  HasSubscription.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 06.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct HasSubscription: View {
    let period: SubscriptionView.Subscription.Period
    let cost: String
    let valid: SubscriptionView.Subscription.Valid
    var body: some View {
        VStack {
            Text(period.title.addSpace() + "Subscription").font(.title)
            Text("You currently have a subcription for".addSpace() + cost + "/" + period.costTitle.addPoint())
            validText
        }
    }
    
    private var validText: AnyView {
        switch valid {
        case .canceled(let date):
            return AnyView(Text("Your subscription was canceled and will expire on".addSpace() + date.addPoint()))
        case .renew(let date):
            return AnyView(Text("Your subscription will be extended on".addSpace() + date.addPoint()))
        default:
            return AnyView(EmptyView())
        }
    }
}

struct HasSubscription_Previews: PreviewProvider {
    static var previews: some View {
        HasSubscription(period: .monthly, cost: "15€", valid: .renew("15. Mai"))
    }
}
