//
//  PickerSheet.swift
//  Trackus
//
//  Created by 최주원 on 1/23/24.
//

import SwiftUI

/* 사용 예시
    //
    @State private var isPickerPresented = false
 
    //탭제스쳐 추가
    .onTapGesture {
        isWeightPickerPresented = true
    }
    .sheet(isPresented: $isWeightPickerPresented) {
        PickerSheet(title: "몸무게", unit: "kg",values: 20..<200, selectedValue: $weight)
    }
 
 - title : 변환값 명칭
 - unit : 값 단위
 - valuse : picker 범위 -> 10..<200
 - selectedValue : 연동할 값 (바인딩)
 
 */

struct PickerSheet: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    let unit: String
    let values: Range<Int>
    @Binding var selectedValue: Int
    
    var body: some View {
        TUCanvas.CustomCanvasView {
            VStack{
                MyTypography.subtitle(text: title)
                Picker(title, selection: $selectedValue) {
                    ForEach(values) {
                        Text("\(self.values[$0]) \(unit)")
                            .tag($0)
                    }
                }
                .foregroundStyle(.white)
                .pickerStyle(WheelPickerStyle())
                .background(Color.clear)  // 배경색 제거
                .foregroundColor(.white)  // 글자색상을 하얀색으로 설정
                //.labelsHidden()  // 레이블 숨기기
                .presentationDetents([.height(300)])
                TUButton(buttonText: "선택") {
                    dismiss()
                }
            }
            .padding(20)
        }
    }
}
