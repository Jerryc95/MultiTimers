//
//  Timer.swift
//  MultiTimers
//
//  Created by Jerry Cox on 1/19/22.
//

import Foundation
import SwiftUI
import Combine
import UIKit

struct CountdownTimer: Identifiable, Comparable {
    let id = UUID()
    let name: String
    var minutes: Int
    var seconds: Int
    var progressTotalTime: Int
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    var counter: CGFloat
    
    var countdown: Int  {
        let totalTime = seconds + (minutes * 60)
            return totalTime
    }
    
    func timeString(time: Int) -> String {
        return String(format: "%01i:%02i", minutes, seconds)
    }
        
    func progress() -> CGFloat {
        return (CGFloat(counter) / CGFloat(progressTotalTime))
    }
    
    static func == (lhs: CountdownTimer, rhs: CountdownTimer) -> Bool {
        return lhs.countdown == rhs.countdown
    }
    
    static func < (lhs: CountdownTimer, rhs: CountdownTimer) -> Bool {
        return lhs.countdown < rhs.countdown
    }
}

class CountdownTimers: ObservableObject {
    @Published var timers = [CountdownTimer]()
    
}
