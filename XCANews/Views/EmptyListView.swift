//
//  EmptyListView.swift
//  XCANews
//
//  Created by Roman Rybachenko on 08.06.2022.
//

import SwiftUI

struct EmptyListView: View {
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(alignment: .center, spacing: 15, content: {
            Spacer()
            if let image = image {
                image
                    .resizable()
                    .imageScale(.large)
                    .scaledToFit()
                    .frame(maxWidth: 100, maxHeight: 100)
            }
            Text(text)
                .frame(alignment: .center)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.leading, 30)
                .padding(.trailing, 30)
            Spacer()
        })
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView(text: AppError.defaultError.localizedDescription, image: Image(systemName: "exclamationmark.square"))
    }
}
