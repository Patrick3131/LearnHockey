//
//  ProfilView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 06.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct ProfilView: View {
    var body: some View {
        VStack {
            ProfilOverviewView()
            FeedbackView(action: {
                
            })
            Spacer().frame(height: 50)
            Button(action: {
                
            }, label: {
                Text("I want to delete my profil")
            })
        }
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
