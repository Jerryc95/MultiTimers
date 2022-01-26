//
//  AddView.swift
//  MultiTimers
//
//  Created by Jerry Cox on 1/20/22.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var countdownTimers: CountdownTimers
    
    @State private var minuteSelection = 0
    @State private var secondSelection = 0
    @State private var timerName = ""
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var minutes = [Int](0..<60)
    var seconds = [Int](0..<60)
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack {
                    Text("Select time:")
                        .padding([.top, .horizontal], 15)
                    
                    Spacer()
                }
                HStack(spacing: 0) {
                    Picker(selection: $minuteSelection, label: Text("")) {
                        ForEach(0..<minutes.count) { index in
                            Text("\(minutes[index]) m")
                        }
                    }
                    .frame(width: geometry.size.width/2.2, alignment: .center)
                    .compositingGroup()
                    .clipped()
                    
                    Picker(selection: $secondSelection, label: Text("")) {
                        ForEach(0..<seconds.count) { index in
                            Text("\(seconds[index]) s")
                        }
                    }
                    .frame(width: geometry.size.width/2.2, alignment: .center)
                    .compositingGroup()
                    .clipped()
                }
                .pickerStyle(.wheel)
                Divider()
                TextField("Name", text: $timerName)
                    .padding()
                
                Spacer()
                Button {
                    let newTimer = CountdownTimer(
                        name: timerName,
                        minutes: minuteSelection,
                        seconds: secondSelection,
                        progressTotalTime: (minuteSelection * 60) + secondSelection,
                        timer: timer,
                        counter: 0
                    )
                    countdownTimers.timers.append(newTimer)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Create")
                }
                .buttonStyle(CustomButtonStyle())
                
            }
        }
        .font(.custom("Quicksand-Bold", size: 25))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(countdownTimers: CountdownTimers())
    }
}
