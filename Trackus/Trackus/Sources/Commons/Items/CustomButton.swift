//
//  CustomButton.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

// 예시입니당

import SwiftUI
//
//struct CustomButton: View {
//    var buttonText: String
//    var active: Bool = false
//    let action: () -> Void
//    
//    var body: some View {
//        GeometryReader { geometry in
//            Button {
//                action()
//            } label: {
//                Text(buttonText)
//            }
//            .frame(width: geometry.size.width, height: 56)
//            // white에
//            .background(aa ? .white : .gray)
//        }
//    }
//}
//
//#Preview {
//    CustomButton(ButtonText: "버튼 내용"){}
//}

struct CustomButton: View {
    var active: Bool
    let image: Image?
    let buttonText: String
    let cornerRadius: CGFloat = 14
    // 버튼 기본 색상 => .white -> .main 으로 색상으로 수정
    let buttonColor: Color
    let fontColor: Color
    let action: () -> Void
    
    // CustomButton (buttonText: "버튼 이름") { 실행코드 작성 }
    // MARK: - 기본 버튼
    /// [기본 버튼] (buttonText: String - 버튼 표시 내용, action: () -> Void - 실행 코드)
    init(buttonText: String, action: @escaping () -> Void) {
        self.active = true
        self.image = nil
        self.buttonText = buttonText
        self.buttonColor = .white
        self.fontColor = .black
        self.action = action
    }
    
    // MARK: - 비활성화 버튼
    /// [비활성화 필요 버튼] (active: Bool - 활성화 여부 (바인딩 값) ,buttonText: String - 버튼 표시 내용, action: () -> Void - 실행 코드)
    init(active: Bool, buttonText: String, action: @escaping () -> Void) {
        self.active = active
        self.image = nil
        self.buttonText = buttonText
        self.buttonColor = .white
        self.fontColor = .black
        self.action = action
    }
    
    // MARK: - 로그인 버튼 - 이미지파일 추가
    /// 로그인 버튼 세팅 -> 이미지파일(image), buttonColor, fontColor 지정 필요
    init(image: Image?, buttonText: String, buttonColor: Color, fontColor: Color, action: @escaping () -> Void) {
        self.active = true
        self.image = image
        self.buttonText = buttonText
        self.buttonColor = buttonColor
        self.fontColor = fontColor
        self.action = action
    }

    var body: some View {
        GeometryReader { geometry in
            Button(action: action) {
                HStack (spacing: 20) {
                    if let image = image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 24)
                    }
                    Text(buttonText)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, minHeight: 56)
//                    if let image = image {
//                        .background(alignment: .leading){
//                            image
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 60, height: 24)
//                        }
//                    }
                }
                //.frame(width: geometry.size.width, height: 56)
                //.padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                .foregroundColor(active ? fontColor : .white)
                .background(active ? buttonColor : Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(active ? fontColor : Color.gray, lineWidth: 1)
                )
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
        }
    }
}


struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomButton (image: Image(systemName: "applelogo"), buttonText: "Apple로 시작하기", buttonColor: Color.red, fontColor: .white) {}
            CustomButton (buttonText: "Apple로 시작하기") {}
            
            //CustomButton(action: {}, active: false, image: Image(systemName: "star.fill"), buttonText: "Favorite")
        }
        .padding()
    }
}
