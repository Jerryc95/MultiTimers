//
//  ContentView.swift
//  MultiTimers
//
//  Created by Jerry Cox on 1/19/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var countdownTimers = CountdownTimers()

    @State private var showingAddSheet = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                List {
                    ForEach($countdownTimers.timers) { $item in
                        ZStack {
                            CardView()
                                .overlay(
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("\(item.name)")
                                                .font(.custom("Quicksand-Bold", size: 30))
                                            Text(" \(item.timeString(time: item.countdown))")
                                                .font(.custom("Quicksand-Bold", size: 40))
                                                .onReceive(item.timer){ _ in
                                                    if  item.countdown > 0 && item.seconds > 0 {
                                                        item.seconds -= 1
                                                    } else if item.countdown > 0 && item.seconds == 0 {
                                                        item.minutes -= 1
                                                        item.seconds += 59
                                                    } else {
                                                        timer.upstream.connect().cancel()
                                                    }
                                                }
                                            Spacer()
                                        }
                                        .padding(.leading, 40)
                                        .padding(.top, 25)
                                        
                                        Spacer()
                                        if item.countdown > 0 {
                                            ProgressView()
                                                .padding(.trailing, 50)
                                        }
                                    }
                                )
                        }
                    }
                    //.onDelete(perform: removeTimer)
                    .onDelete { indexSet in
                        countdownTimers.timers.remove(atOffsets: indexSet)
                    }
                }
                Button("New timer") {
                    
                    showingAddSheet = true
                }
                .buttonStyle(CustomButtonStyle())
                .fullScreenCover(isPresented: $showingAddSheet, content: {
                    AddView(countdownTimers: countdownTimers)
                })
            }
            .listStyle(InsetListStyle())
        }
    }
//    func removeTimer(at offsets: IndexSet) {
//        countdownTimers.timers.remove(atOffsets: offsets)
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
