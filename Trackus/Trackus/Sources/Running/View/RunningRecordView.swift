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
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        SoundSetting.instance.playSound(sound: .recordStart)
        self._path = path
    }
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            
            LiveRecordedRunningView()
            .frame(height: UIScreen.screenHeight * 0.4)
            .edgesIgnoringSafeArea(.all)
            
            BottomSheet(isFullScreen: $isFullScreen) {
                VStack {
                    // 러닝 일시정지(현재까지 기록을 보여줌)
                    if isFullScreen {
                        VStack {
                            NavigationLink(destination: RunningResultView(path: $path).navigationBarBackButtonHidden(true), isActive: $isShowingResultView) {
                                EmptyView()
                            }
                            Text("일시정지")
                                .font(.system(size: 34, weight: .heavy))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(Constants.ViewLayoutConst.VIEW_STANDARD_HORIZONTAL_SPACING)
                            
                            Divider()
                            
                            VStack(spacing: Constants.ViewLayoutConst.VIEW_STANDARD_VERTICAL_SPACING) {
                                HStack {
                                    Text("킬로미터")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(TUColor.subText)
                                    
                                    Spacer()
                                    Text("0.0")
                                        .font(.system(size: 36, weight: .heavy))
                                        .foregroundColor(.white)
                                }
                                
                                HStack {
                                    Text("러닝타임")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(TUColor.subText)
                                    
                                    Spacer()
                                    Text("00:00")
                                        .font(.system(size: 36, weight: .heavy))
                                        .foregroundColor(.white)
                                }
                                
                                HStack {
                                    Text("페이스")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(TUColor.subText)
                                    
                                    Spacer()
                                    Text("-'--''")
                                        .font(.system(size: 36, weight: .heavy))
                                        .foregroundColor(.white)
                                }
                                
                                HStack {
                                    Text("칼로리")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(TUColor.subText)
                                    
                                    Spacer()
                                    Text("0.0")
                                        .font(.system(size: 36, weight: .heavy))
                                        .foregroundColor(.white)
                                }
                                
                                HStack {
                                    Text("케이던스")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(TUColor.subText)
                                    
                                    Spacer()
                                    Text("-")
                                        .font(.system(size: 36, weight: .heavy))
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(Constants.ViewLayoutConst.VIEW_STANDARD_HORIZONTAL_SPACING)
                            
                            Divider()
                            
                            Spacer()
                            // 러닝중지, 러닝재개 버튼
                            HStack {
                                Button(action: {}, label: {
                                    Image(systemName: "stop.circle")
                                        .font(.system(size: 104))
                                        .foregroundColor(.white)
                                    
                                }) // LongPressGesture를 앞에 추가
                                .simultaneousGesture(LongPressGesture(minimumDuration: 2)
                                    .updating($press) { currentState, gestureState, transaction in
                                        gestureState = currentState
                                    }
                                    .onEnded(stopButtonLongPressed))
                                .simultaneousGesture(TapGesture().onEnded(stopButtonPressed))
                                
                                Spacer()
                                Button(action: playButtonPressed) {
                                    Image(systemName: "play.circle")
                                        .font(.system(size: 104))
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(Constants.ViewLayoutConst.VIEW_STANDARD_HORIZONTAL_SPACING)
                            .padding(.bottom, 32)
                        }
                        
                    }
                    // 러닝중
                    else {
                        VStack(spacing: Constants.ViewLayoutConst.VIEW_SPECIAL_SPACING) {
                            Spacer()
                            HStack {
                                VStack(spacing: Constants.ViewLayoutConst.VIEW_STANDARD_VERTICAL_SPACING) {
                                    Text("0.0")
                                        .font(.system(size: 36, weight: .heavy))
                                        .italic()
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    
                                    
                                    Text("현재까지 거리")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(TUColor.subText)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                                
                                VStack(spacing: Constants.ViewLayoutConst.VIEW_STANDARD_VERTICAL_SPACING) {
                                    Text("00:00")
                                        .font(.system(size: 36, weight: .heavy))
                                        .italic()
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    
                                    Text("경과 시간")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(TUColor.subText)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                            
                            HStack {
                                VStack(spacing: Constants.ViewLayoutConst.VIEW_STANDARD_VERTICAL_SPACING) {
                                    Text("-'--''")
                                        .font(.system(size: 36, weight: .heavy))
                                        .italic()
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    
                                    
                                    Text("페이스")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(TUColor.subText)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                                
                                VStack(spacing: Constants.ViewLayoutConst.VIEW_STANDARD_VERTICAL_SPACING) {
                                    Text("0")
                                        .font(.system(size: 36, weight: .heavy))
                                        .italic()
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    
                                    Text("소모 칼로리")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(TUColor.subText)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                            Spacer()
                            Button(action: pauseButtonPressed) {
                                Image(systemName: "pause.circle")
                                    .font(.system(size: 104))
                                    .foregroundColor(.white)
                            }
                            .padding(.bottom, 32)
                        }
                        .padding(Constants.ViewLayoutConst.VIEW_STANDARD_HORIZONTAL_SPACING)
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
                .autohideIn(2)
        }
        
        .navigationBarBackButtonHidden(true)
    }
    
    // 일시중지
    func pauseButtonPressed() {
        withAnimation {
            isFullScreen = true
        }
        HapticManager.instance.impact(style: .medium)
        SoundSetting.instance.playSound(sound: .recordStop)
    }
    
    // 기록시작
    func playButtonPressed() {
        withAnimation {
            isFullScreen = false
        }
        HapticManager.instance.impact(style: .medium)
    }
    
    // 종료버튼 탭
    func stopButtonPressed() {
        isShowingPopup = true
    }
    
    // 종료버튼 롱프레스
    func stopButtonLongPressed(value: Bool) {
        HapticManager.instance.impact(style: .heavy)
        isShowingResultView = true
    }
}

//#Preview {
//    RunningRecordView()
//}
