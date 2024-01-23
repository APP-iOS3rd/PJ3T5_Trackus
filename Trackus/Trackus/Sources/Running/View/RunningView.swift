//
//  RunningView.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

import SwiftUI

struct RunningView: View {
    @State private var showCountView = false
    var body: some View {
        NavigationView {
            TUCanvas.CustomCanvasView {
                VStack {
//                    HStack {
//                        Text("러닝")
//                            .font(.title)
//                            .fontWeight(.bold)
//                            .foregroundColor(.white)
//                            .padding(.leading, 20)
//                        
//                        Text("나만의 코스에서 달려보세요")
//                            .font(.body)
//                            .fontWeight(.bold)
//                            .foregroundColor(.white)
//                        
//                        Spacer()
//                    }
//                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0 + 20)
//                    
//                    Divider().background(Color.white)
//                    
                    
                    Spacer()
                    
                    Image("Running")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200, alignment: .center)
                        .standardPadding()
                    
                    Text("페이스 같은 건 잊고 그냥 달려보세요. TrackUs와 함께 러닝을 완료한 후에는 여기에서 러닝 거리, 통계, 달성 기록을 확인할 수 있습니다.")
                        .font(.body)
                        .foregroundColor(.white)
                        .standardPadding()
                    
                        NavigationLink(destination: CountView().navigationBarBackButtonHidden(true)) {
                            Text("시작하기")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
//                    }
                    .standardPadding()
                    
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    RunningView()
}
