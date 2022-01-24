//
//  CardView.swift
//  MultiTimers
//
//  Created by Jerry Cox on 1/21/22.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(width: 300, height: 150)
            .foregroundColor(.cream)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.1), radius: 5, x: -5, y: -5)
            .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
