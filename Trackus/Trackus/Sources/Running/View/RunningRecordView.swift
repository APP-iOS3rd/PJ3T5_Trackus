//
//  RunningRecordView.swift
//  Trackus
//
//  Created by SeokKi Kwon on 2024/01/20.
//

import SwiftUI
import PopupView

struct RunningRecordView: View {
    @State private var isShowingResultView = false
    @State private var isFullScreen = false
    @State var isShowingPopup = false
    @GestureState var press = false
    
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
                                    Button(action: {}, label: {
                                        Image(systemName: "stop.circle")
                                            .font(.system(size: 116))
                                            .foregroundColor(.white)
                                        
                                    }) // LongPressGesture를 앞에 추가
                                    .simultaneousGesture(LongPressGesture(minimumDuration: 2)
                                        .updating($press) { currentState, gestureState, transaction in
                                            gestureState = currentState
                                        }
                                        .onEnded(stopButtonLongPressed))
                                    .simultaneousGesture(TapGesture().onEnded(stopButtonPressed))
                                    
                                    
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
        .popup(isPresented: $isShowingPopup) {
            HStack {
                Image(systemName: "hand.tap")
                    .foregroundColor(.white)
                    .font(.title)
                Text("일시정지 버튼을 2초이상 탭하면 기록이 중지됩니다!")
                    .foregroundColor(.white)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .background(.purple)
        } customize: {
            $0
                .type(.floater())
                .position(.top)
                .autohideIn(1.5)
        }
 
        .navigationBarBackButtonHidden(true)
    }
    
    func pauseButtonPressed() {
        withAnimation {
            isFullScreen.toggle()
            HapticManager.instance.impact(style: .medium)
        }
    }
    
    func stopButtonPressed() {
        print("stop button pressed!")
        isShowingPopup = true
    }
    
    func stopButtonLongPressed(value: Bool) {
        isShowingResultView = true
    }
}

#Preview {
    RunningRecordView()
}
