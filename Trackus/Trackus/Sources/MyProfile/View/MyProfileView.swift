//
//  MyProfileView.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

import SwiftUI

struct MyProfileView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    @Environment(\.dismiss) var dismiss
    private func deleteAccount() {
      Task {
        if await viewModel.deleteAccount() == true {
          dismiss()
        }
      }
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button(action: {viewModel.signOut()}, label: {
            Text("로그아웃")
                .foregroundStyle(.black)
        })
        Button(action: {deleteAccount()}, label: {
            Text("탈퇴하기")
                .foregroundStyle(.red)
        })
    }
}
    
#Preview {
    MyProfileView()
}
