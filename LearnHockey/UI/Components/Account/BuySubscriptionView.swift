//
//  BuySubscriptionView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 04.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct BuySubscriptionView: View {
    
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                Text("Monthly Subscribtion")
                .bold()
                    .foregroundColor(Color.white)
                    .padding(.bottom, 5)
                
                Text("Access to all exercises")
                    .foregroundColor(Color.white)
            }.padding(.vertical)
            VStack(alignment:.trailing) {
                Text("Subscribe")
                    .foregroundColor(Color.green)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .padding(1)
                    .background(Color.black)
                    .cornerRadius(5)
                Text("2.99 € / Month").bold()
                    .foregroundColor(Color.white)
                    .padding(.top)
            }
        }.padding()
            .background(Color.green)
        .cornerRadius(5)
        .padding(1)
        .cornerRadius(5)
    }
}

struct BuySubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            BuySubscriptionView().frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.2, alignment: .center)
        }
    }
}
