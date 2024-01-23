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
    @State var isError1 : Bool = true
    @State var isError2 : Bool = false
    @State var isError3 : Bool = false
    @Binding var text : String
    @Binding var availability : Bool
    
    var body: some View {
        VStack(alignment: .leading){
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
                        checkAvailability()
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
            if isFocused{
                CheckString(condition: $isError1, checkString: "2 ~ 20글자 입력")
                CheckString(condition: $isError2, checkString: "공백 입력 x")
                CheckString(condition: $isError3, checkString: "특수 문자 제외")
            }
        }
    }
    
    private func checkText(_ newText: String) {
        if newText.count > 20 || newText.count < 2{
            isError1 = true
        }else{
            isError1 = false
        }
        
        let specialCharacters = CharacterSet(charactersIn: "!?@#$%^&*()_+=-<>,.;|/:[]{}")
        
        // 첫 글자에 공백이 있거나 공백이 연속되면 안됨
        if newText.hasPrefix(" ") || newText.contains("  ") || newText.isEmpty {
            isError2 = true
        }else{
            isError2 = false
        }
        
        // 텍스트에 특수문자가 들어가면 안됨
        if let _ = newText.rangeOfCharacter(from: specialCharacters) {
            isError3 = true
        }else{
            isError3 = false
        }
        
        if isError1 || isError2 || isError3 {
            isError = true
        }else{
            isError = false
        }
    }
    
    // 버튼 활성화 여부
    private func checkAvailability() {
        if !text.isEmpty && !isError{
            availability = true
        }else{
            availability = false
        }
    }
    
}

struct CheckString: View {
    @Binding var condition: Bool
    let checkString: String
    var body: some View {
        HStack{
            Image(systemName: !condition ? "checkmark" : "xmark")
                .frame(width: 15)
                .foregroundStyle(!condition ? .green : .red)
            Text(checkString)
                .foregroundStyle(!condition ? .white : .gray)
                .font(Font.system(size: 15, weight: .regular))
        }
        .padding(.init(top: 4, leading: 8, bottom: 4, trailing: 0))
    }
}



#Preview {
    TUTextField(placeholder: "닉네임", text: .constant("가나다라"), availability: .constant(true))
}
