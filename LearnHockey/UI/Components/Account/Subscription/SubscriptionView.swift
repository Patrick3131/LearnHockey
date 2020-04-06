//
//  SubscriptionView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 06.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct SubscriptionView: View {
    let subscription: Subscription
    var body: some View {
        content
    }
    
    private var content: AnyView {
        switch subscription {
        case .noSubscription(let valid):
            return AnyView(NoValidSubscription(valid: valid))
        case .validSubscription(let period,let cost,let valid):
            return AnyView(HasSubscription(period: period, cost: cost, valid: valid))
        }
    }
}

extension SubscriptionView {
    enum Subscription {
        case noSubscription(valid: Valid)
        /**
         - Parameters:
         - type: Type of subscription: daily, monthly, yearly etc.
         - cost: the cost of subscription
         - validTill: till the subsciption is valid
         */
        case validSubscription(period: Period, cost: String, valid: Valid)
        enum Period {
            case monthly
            case yearly
            
            var title: String {
                switch self {
                case .monthly:
                    return "Monthly"
                case .yearly:
                    return "Yearly"
                }
            }
            
            var costTitle: String {
                switch self {
                case .monthly:
                    return "Month"
                case .yearly:
                    return "Year"
                }
            }
        }
        
        enum Valid {
            case expired(_ date:String)
            case canceled(_ date:String)
            case renew(_ date:String)
            case neverSubscribed
        }
    }
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SubscriptionView(subscription: SubscriptionView.Subscription.noSubscription(valid: .canceled("14. Mai")))
            SubscriptionView(subscription: SubscriptionView.Subscription.validSubscription(period: SubscriptionView.Subscription.Period.monthly, cost: "19€", valid: SubscriptionView.Subscription.Valid.renew("30. April")))
        }
        
    }
}

