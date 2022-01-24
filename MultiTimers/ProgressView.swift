//
//  ProgressView.swift
//  MultiTimers
//
//  Created by Jerry Cox on 1/20/22.
//

import SwiftUI

struct ProgressView: View {
    var body: some View {
        ZStack {
            Circle()
               
               .stroke(Color.newRed.opacity(0.5), style: StrokeStyle(lineWidth: CGFloat(15), lineCap: .round))
           
           Circle()
             
              .stroke(Color.newRed, style: StrokeStyle(lineWidth: CGFloat(15), lineCap: .round))
        }
        .frame(width: 75)
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
