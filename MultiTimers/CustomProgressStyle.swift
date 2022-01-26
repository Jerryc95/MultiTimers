//
//  CustomerProgressStyle.swift
//  MultiTimers
//
//  Created by Jerry Cox on 1/24/22.
//

import SwiftUI

struct CustomProgressStyle: ProgressViewStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(.gray.opacity(0.3))
                .frame(width: 300, height: 15)
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(.blue)
                .frame(width: 300 * fractionCompleted, height: 15)
        }
    }
}

