//
//  SwiftUIView.swift
//  Trackus
//
//  Created by 박선구 on 1/23/24.
//

import SwiftUI

// 기간별 운동정보 원 차트 View

struct MyStatsCircleView: View {
    @State private var progress: CGFloat = 0.5
    
    var body: some View {
        ZStack {
            TUColor.box.edgesIgnoringSafeArea(.all)
            
            VStack (spacing: -25){
                
                Spacer()
                
                CircularProgressView(progress: progress)
                    .frame(width: 150, height: 150)
                VStack {
                    
                    Image(systemName: "figure.walk")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .offset(y: -95)
                    
                    Text("3.2km") // 오늘 나의 러닝 거리
                        .foregroundColor(TUColor.main)
                        .font(.headline)
                        .fontWeight(.bold)
                        .italic()
                        .offset(y: -90)
                }
                
                Text("일일 목표까지 1.4km") // 일일 목표와 오늘 나의 거리의 차이
                    .padding(.bottom, 50)
                    .foregroundColor(TUColor.main)
                    .fontWeight(.semibold)
                
                Spacer()
                
                // stats
                HStack {
                    
                    VStack {
                        Image(systemName: "flame.fill")
                            .resizable()
                            .frame(width: 20, height: 23)
                        Text("161 Kcal")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(TUColor.main)
                    
                    Spacer()
                    
                    VStack {
                        Image(systemName: "figure.walk")
                            .resizable()
                            .frame(width: 20, height: 23)
                        Text("3.2 km")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(TUColor.main)
                    
                    Spacer()
                    
                    VStack {
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 20, height: 23)
                        Text("00:32")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(TUColor.main)
                }
                .padding()
                .background(TUColor.subBox)
                .cornerRadius(14)
            }
        }
    }
}


struct CircularProgressView: View {
    var progress: CGFloat

    var body: some View {
        ZStack {
            // 원형 트랙
            Circle()
                .stroke(Color.black, style: StrokeStyle(lineWidth: 12.0, lineCap: .round))

            // 원형 그래프
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(TUColor.main, style: StrokeStyle(lineWidth: 13.0, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
        }
    }
}

#Preview {
    MyStatsCircleView()
}
