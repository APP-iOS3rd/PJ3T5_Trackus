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

    var body: some View {
        TUCanvas.CustomCanvasView {
            switch view {
            case .counting:
                countingView
            case .runningRecord:
                RunningRecordView()
            }
        }
    }

    var countingView: some View {
        VStack {
            if count > 0 {
                Text("\(count)")
                    .italic()
                    .foregroundColor(.white)
                    .font(.system(size: 180))
                    .fontWeight(.bold)
                    .padding(.horizontal)
                Text("잠시후 러닝이 시작됩니다!")
                    .foregroundColor(.white)
                    .font(.body)
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1.2, repeats: true) { timer in
                if self.count > 0 {
                    self.count -= 1
                } else {
                    timer.invalidate()
                    self.view = .runningRecord
                }
            }
        }
    }
}

#Preview {
    CountView()
}
