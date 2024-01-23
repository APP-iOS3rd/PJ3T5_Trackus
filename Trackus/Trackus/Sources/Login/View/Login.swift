//
//  Login.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

import SwiftUI

struct Login: View {
    var body: some View {
        VStack{
            // 로고 부분
//            Image(.trackUsLogo)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(height: 60)
//                .padding(60)
//
            Spacer()
            TUButton(image: Image(.googleLogo), buttonText: "Google로 시작하기", buttonColor: .white, fontColor: .black) {
                
            }
            TUButton(image: Image(systemName: "applelogo"), buttonText: "Apple로 시작하기", buttonColor: .black, fontColor: .white) {
                
            }
        }
        .padding(20)
        .background(.black)
    }
}

#Preview {
    Login()
}
