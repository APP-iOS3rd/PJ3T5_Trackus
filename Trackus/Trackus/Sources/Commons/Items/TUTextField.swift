//
//  CustomTextField.swift
//  Trackus
//
//  Created by 박선구 on 1/18/24.
//

import SwiftUI

// 사용 예시) TUTextField(placeholder: "닉네임", text: $myText)

struct TUTextField: View {
    var placeholder : String
    @State var isFocused = false
    @State var isError : Bool = false
    @Binding var text : String
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text, prompt: Text(placeholder).foregroundColor(.gray))
                .textInputAutocapitalization(.none)
                .autocorrectionDisabled(true)
                .onTapGesture {
                    withAnimation {
                        isFocused = true
                        
                        if isError == true {
                            isError = false
                        }
                    }
                }
                .onChange(of: text) { newText in
                    checkText(newText)
                }
            
                // 키보드가 활성화 되어있는지 확인
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    
                    withAnimation {
                        isFocused = false
                    }
                }
            
            // 텍스트 클리어 버튼
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 3)
                .inset(by: 0.5)
                .stroke(isError ? Color.red : (isFocused ? Color.white : Color.gray))
        )
        .foregroundStyle(.white)
    }
    
    private func checkText(_ newText: String) {
        // 글자 수 제한 20글자까지, 텍스트필드 값에 특수문자(!@#$%^&*()_+=-<>,.;'/:" 등등)와 공백이 있으면 안됨
        
        // 글자 수 제한 20글자
        if newText.count > 20 {
            isError = true
            return
        }
        
        let specialCharacters = CharacterSet(charactersIn: "!?@#$%^&*()_+=-<>,.;|/:[]{}")
        
        // 첫 글자에 공백이 있거나 공백이 연속되면 안됨
        if newText.hasPrefix(" ") || newText.contains("  ") {
            isError = true
            return
        }
        
        // 텍스트에 특수문자가 들어가면 안됨
        if let _ = newText.rangeOfCharacter(from: specialCharacters) {
            isError = true
            return
        }
        
        isError = false
    }
    
}



#Preview {
    TUTextField(placeholder: "닉네임", text: .constant("가나다라"))
}
