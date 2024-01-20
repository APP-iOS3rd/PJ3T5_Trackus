//
//  RunningRecordView.swift
//  Trackus
//
//  Created by SeokKi Kwon on 2024/01/20.
//

import SwiftUI

struct RunningRecordView: View {
    @State private var isFullScreen = false
    @GestureState var press = false
    @State private var isShowingResultView = false
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.gray
                .edgesIgnoringSafeArea(.all)
            VStack {
                BottomSheet(isFullScreen: $isFullScreen) {
                    VStack {
                        if isFullScreen {
                            VStack {
                                NavigationLink(destination: RunningResultView().navigationBarBackButtonHidden(true), isActive: $isShowingResultView) {
                                    EmptyView()
                                }
                                Text("일시정지!")
                                    .font(.title)
                                    .foregroundColor(.white)
                                HStack {
                                    Image(systemName: "stop.circle")
                                        .font(.system(size: 116))
                                        .foregroundColor(.white)
                                        .gesture(
                                            LongPressGesture(minimumDuration: 2)
                                                .updating($press) { currentState, gestureState, transaction in
                                                    gestureState = currentState
                                                }
                                                .onEnded(stopButtonPressed)
                                        )
                                    
                                    Spacer()
                                    Button(action: pauseButtonPressed) {
                                        Image(systemName: "play.circle")
                                            .font(.system(size: 116))
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(32)
                            }
                        } else {
                            VStack {
                                Text("기록")
                                    .font(.title)
                                    .foregroundColor(.white)
                                Button(action: pauseButtonPressed) {
                                    Image(systemName: "pause.circle")
                                        .font(.system(size: 116))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                }
            }
            
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func pauseButtonPressed() {
        withAnimation {
            isFullScreen.toggle()
            HapticManager.instance.impact(style: .medium)
        }
    }
    
    func stopButtonPressed(value: Bool) {
        isShowingResultView = true
    }
}

#Preview {
    RunningRecordView()
}
