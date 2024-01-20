//
//  RunningView.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

import SwiftUI

struct RunningView: View {
    var body: some View {
        TUCanvas.CustomCanvasView {
            ScrollView {
                VStack {
                    NavigationLink("러닝 시작!", value: "RunningRecord")
                }.padding(20)
            }
            .navigationDestination(for: String.self) { destination in
                if destination == "RunningRecord" {
                    RunningRecordView()
                }
            }
        }
    }
}

#Preview {
    RunningView()
}
