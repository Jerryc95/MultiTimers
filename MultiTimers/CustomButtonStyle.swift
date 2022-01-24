//
//  CustomButtonStyle.swift
//  MultiTimers
//
//  Created by Jerry Cox on 1/20/22.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("Quicksand-Bold", size: 25))
            .frame(width: 150, height: 50)
            .background(Color.cream)
            .foregroundColor(.newRed)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .overlay(
                Color.black
                    .opacity(configuration.isPressed ? 0.3 : 0.0)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            )
            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 6, y: 6)

    }
}
   
