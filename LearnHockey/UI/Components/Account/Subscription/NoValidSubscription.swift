//
//  NoValidSubscription.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 06.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct NoValidSubscription: View {
    let valid: SubscriptionView.Subscription.Valid
    
    var body: some View {
        VStack {
            title
            validText
        }
    }
    
    private var title: AnyView {
        switch valid {
        case .neverSubscribed:
            return AnyView(Text("You do not have any subscription."))
        case .expired:
            return AnyView(Text("Your subscription expired!"))
        default:
            return AnyView(EmptyView())
        }
    }
    
    private var validText: AnyView {
        switch valid {
        case .expired(let date):
            return AnyView(Text("Your subscription has expired on".addSpace() + date.addComma().addSpace() + "please renew your subscription."))
        default:
            return AnyView(EmptyView())
        }
    }
}

struct NoValidSubscription_Previews: PreviewProvider {
    static var previews: some View {
        NoValidSubscription(valid: .expired("14. Mai"))
    }
}
