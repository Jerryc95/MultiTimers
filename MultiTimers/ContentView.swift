//
//  ContentView.swift
//  MultiTimers
//
//  Created by Jerry Cox on 1/19/22.
//

import SwiftUI
import AVFoundation


struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var countdownTimers = CountdownTimers()
    @State private var showingAddSheet = false
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                if countdownTimers.timers.count == 0 {
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            Spacer()
                            Text("No active")
                                .offset(y: -150)
                            Text("timers")
                                .offset(y: -150)
                            Spacer()
                            Button("New timer") {
                                
                                showingAddSheet = true
                            }
                            .buttonStyle(CustomButtonStyle())
                            .fullScreenCover(isPresented: $showingAddSheet, content: {
                                AddView(countdownTimers: countdownTimers)
                            })
                        }
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.secondary.opacity(0.5))
                        Spacer()
                    }

                } else {
                    VStack {
                        List {
                            ForEach($countdownTimers.timers) { $item in
                                VStack(alignment: .trailing) {
                                    HStack {
                                        Text("\(item.name)")
                                            .font(.system(size: 25, weight: .bold))
                                        Spacer()
                                        Text(" \(item.timeString(time: item.progressTotalTime))")
                                            .font(.system(size: 30, weight: .heavy))
                                    }
                                    .padding(15)
                                    
                                    Spacer()
                                    
                                    if item.countdown > 0 {
                                        HStack {
                                            Spacer()
                                            ProgressView(value: item.counter, total: CGFloat(item.progressTotalTime))
                                                .progressViewStyle(CustomProgressStyle())
                                                .padding(.bottom, 5)
                                            Spacer()
                                        }
                                    } else {
                                        Text("Done!")
                                            .font(.title3)
                                    }
                                }
                                .onReceive(item.timer) { _ in
                                    if countdownTimers.timers.count > 0 {
                                        if item.seconds > 0 {
                                            item.seconds -= 1
                                            item.counter += 1
                                        } else if item.countdown > 0 && item.seconds == 0 {
                                            item.minutes -= 1
                                            item.seconds += 59
                                            
                                        } else if item.countdown == 0 {
                                            AudioServicesPlayAlertSound(1005)
                                        }
                                    }
                                }
                            }
                            .onDelete { indexSet in
                                countdownTimers.timers.remove(atOffsets: indexSet)
                            }
                        }
                        .listStyle(InsetListStyle())
                        Button("New timer") {
                            
                            showingAddSheet = true
                        }
                        .buttonStyle(CustomButtonStyle())
                        .fullScreenCover(isPresented: $showingAddSheet, content: {
                            AddView(countdownTimers: countdownTimers)
                        })
                    }
                }
            }
            .navigationTitle("Timers")
            .toolbar {
                Menu {
                    Button(action:  {
                        countdownTimers.timers.sort(by: { $0.name < $1.name })
                    }) {
                        Label("Name", systemImage: "character")
                    }
                    Button(action:  {
                        countdownTimers.timers.sort()
                    }) {
                        Label("Time Remaining", systemImage: "timer")
                    }
                }
            label: {
                Label("Sort", systemImage: "arrow.up.arrow.down")
            }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
