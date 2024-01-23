//
//  Login.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

//
//  Login.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    @Environment(\.dismiss) var dismiss
    
    private func signInWithGoogle() {
        Task {
            if await viewModel.signInWithGoogle() == true {
                dismiss()
            }
        }
    }
    
    var body: some View {
        VStack{
            // 로고 부분
            Image(.trackUsLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 60)
                .padding(.top, 160)
            
            Spacer()
            TUButton(image: Image(.googleLogo), buttonText: "Google로 시작하기", buttonColor: .white, fontColor: .black) {
                signInWithGoogle()
            }
            .padding(.top, 8)
            TUButton(image: Image(systemName: "applelogo"), buttonText: "Apple로 시작하기", buttonColor: .black, fontColor: .white) {
                
            }
            .padding(.top, 8)
            
        }
        .padding(20)
    }
}

#Preview {
    //LoginView()
    
    SignUpView()
}

