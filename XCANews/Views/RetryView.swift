//
//  RetryView.swift
//  XCANews
//
//  Created by Roman Rybachenko on 09.06.2022.
//

import SwiftUI

struct RetryView: View {
    let infoText: String
    let buttonTitle: String
    let tapAction: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 8, content: {
            Text(infoText)
                .font(.callout)
                .multilineTextAlignment(.center)
            
            Button(action: tapAction, label: {
                Text(buttonTitle)
            })
        })
    }
}

struct RetryView_Previews: PreviewProvider {
    static var previews: some View {
        RetryView(infoText: "Error text bla-bla",
                  buttonTitle: "Try again",
                  tapAction: {
            pl("Retry button tapped")
        })
    }
}
