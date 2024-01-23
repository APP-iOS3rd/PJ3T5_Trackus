//
//  CountView.swift
//  Trackus
//
//  Created by 윤준성 on 1/22/24.
//

import SwiftUI

enum RunningViewState {
    case counting
    case runningRecord
}

struct CountView: View {
    @State private var count = 3
    @State private var view: RunningViewState = .counting
    @State private var isZoomed = false
    @Binding var path: NavigationPath
    
    var body: some View {
        TUCanvas.CustomCanvasView {
            switch view {
            case .counting:
                countingView
            case .runningRecord:
                RunningRecordView(path: $path)
            }
        }
    }

    var countingView: some View {
        VStack {
            if count > 0 {
                Text("\(count)")
                    .italic()
                    .foregroundColor(.white)
                    .font(.system(size: isZoomed ? 200 : 180))
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    
                Text("잠시후 러닝이 시작됩니다!")
                    .foregroundColor(.white)
                    .font(.body)
            }
        }
        .onAppear {
            // self.count > 0 이라면 1일때도 해당이 되기 때문에 사실상 3 2 1 0 까지 내려감!
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                
                if self.count > 1 {
                    self.count -= 1
                } else {
                    timer.invalidate()
                    self.view = .runningRecord
                }
            }
        }
    }
}

//#Preview {
//    CountView()
//}
