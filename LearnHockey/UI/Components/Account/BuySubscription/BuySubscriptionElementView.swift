//
//  BuySubscriptionView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 04.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct BuySubscriptionElementView: View {
    var subscriptionText: String = "Monthly Subscription"
    var amountText: String = "2.99 € / Month"
    var body: some View {
        HStack() {
            VStack(alignment:.leading) {
                Text(subscriptionText)
                .bold()
                .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(.systemBackground))
                    .padding(.bottom, 5)
                Text("Access to all exercises")
//                .fixedSize()
                    .foregroundColor(Color(.systemBackground))
            }
//            .padding(.vertical)
//            Spacer()
            VStack(alignment:.trailing) {
                Text("Subscribe")
                    .foregroundColor(Color.baseDark)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .padding(1)
                    .background(Color.black)
                    .cornerRadius(5)
                Text(amountText).bold()
                    .foregroundColor(Color(.systemBackground))
                    .padding(.top)
            }
            .frame(minWidth: 120)
            .padding(.leading)
            Spacer().frame(width: 5)
        }
        .padding()
        .background(Color.baseDark)
        .cornerRadius(5)
        .padding(1)
        .cornerRadius(5)
    }
}

struct BuySubscriptionElementView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            VStack(spacing: 70) {
                Spacer()
                Button(action: {
                    
                }, label: {
                    BuySubscriptionElementView(subscriptionText: "Monthly Subscription", amountText: "29.99€/month").frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.2, alignment: .center)
                })
                Button(action: {
                    
                }, label: {
                    BuySubscriptionElementView().frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.2, alignment: .center)
                })
            }
        }
    }
}
