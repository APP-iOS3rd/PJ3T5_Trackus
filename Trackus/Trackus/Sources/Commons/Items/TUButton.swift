//
//  TUButton.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

// 버튼 기본 색상 => .white -> .main 으로 색상으로 수정

import SwiftUI

struct TUButton: View {
    var active: Bool
    let image: Image?
    let text: String
    let cornerRadius: CGFloat = 14
    let backgroundColor: Color
    let fontColor: Color
    let action: () -> Void
    
    
    // MARK: - 기본 버튼
    // 사용 예시
    // TUButton(buttonText: "버튼 문구") { 실행코드 추가 }
    
    /// 기본 버튼 -> text: 버튼 표시 내용, action:  실행 코드
    init(buttonText: String, action: @escaping () -> Void) {
        self.active = true
        self.image = nil
        self.text = buttonText
        self.backgroundColor = .white
        self.fontColor = .black
        self.action = action
    }
    
    // MARK: - 동적 버튼
    // 사용 예시
    // TUButton(active: 변환 체크값, buttonText: "버튼 내용") { 실행코드 추가 }
    
    /// 동적 버튼 -> active: Bool - true(활성), false(비활성)
    /// 
    /// @State로 선언한 Bool값 넣어 사용
    /// - true - 작동
    /// - false - 비작동
    init(active: Bool, buttonText: String, action: @escaping () -> Void) {
        self.active = active
        self.image = nil
        self.text = buttonText
        self.backgroundColor = .white
        self.fontColor = .black
        self.action = action
    }
    
    // MARK: - 동적 버튼 (색상 설정)
    // 사용 예시
    // TUButton(active: 변환 체크값, buttonText: "버튼 내용", backgroundColor: .red, fontColor: .white) { 실행코드 추가 }
    
    /// 동적 버튼(색상 설정) -> active: Bool - true(활성), false(비활성), buttonColor: 배경색, fontColor: 글자색
    ///
    /// @State로 선언한 Bool값 넣어 사용
    /// - true - 작동
    /// - false - 비작동
    init(active: Bool, buttonText: String, buttonColor: Color, fontColor: Color, action: @escaping () -> Void) {
        self.active = active
        self.image = nil
        self.text = buttonText
        self.backgroundColor = buttonColor
        self.fontColor = fontColor
        self.action = action
    }
    
    // MARK: - 로그인 버튼 - 이미지파일 추가
    /// 이미지 버튼 -> 이미지파일(image), backgroundColor, fontColor 지정
    init(image: Image?, buttonText: String, buttonColor: Color, fontColor: Color, action: @escaping () -> Void) {
        self.active = true
        self.image = image
        self.text = buttonText
        self.backgroundColor = buttonColor
        self.fontColor = fontColor
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack (spacing: 0) {
                if let image = image {
                    Text(text)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .background(alignment: .leading){
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 24, alignment: .center)
                        }
                }else{
                    Text(text)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, minHeight: 56)
                }
            }
            .foregroundColor(active ? fontColor : .gray)
            .background(active ? backgroundColor : .black)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(backgroundColor == .black || active == false ? .gray : backgroundColor, lineWidth: 1)
            )
        }
        .animation(.easeInOut(duration: 0.15), value: active)
        .disabled(!active)
        .frame(maxWidth: .infinity)
        .frame(height: 56)
    }
    
}


//struct TUButton_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            TUButton (image: Image(systemName: "applelogo"), buttonText: "Apple로 시작하기", buttonColor: Color.red, fontColor: .white) {}
//            TUButton (buttonText: "Apple로 시작하기") {}
//            
//            //CustomButton(action: {}, active: false, image: Image(systemName: "star.fill"), buttonText: "Favorite")
//        }
//        .padding()
//    }
//}
