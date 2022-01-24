//
//  Timer.swift
//  MultiTimers
//
//  Created by Jerry Cox on 1/19/22.
//

import Foundation
import SwiftUI

struct CountdownTimer: Identifiable {
    let id = UUID()
    let name: String
    var minutes: Int
    var seconds: Int
    
    var countdown: Int  {
        let totalTime = seconds + (minutes * 60)
            return totalTime
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func timeString(time: Int) -> String {
        return String(format: "%01i:%02i", minutes, seconds)
    }
}

class CountdownTimers: ObservableObject {
    @Published var timers = [CountdownTimer]()
}
