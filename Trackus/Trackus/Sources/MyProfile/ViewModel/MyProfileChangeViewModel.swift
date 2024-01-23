//
//  MyProfileChangeViewModel.swift
//  Trackus
//
//  Created by 박소희 on 1/23/24.
//

import SwiftUI

class MyProfileChangeViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var height: Int = 170
    @Published var weight: Int = 65
    @Published var runningStyleIndex: Int = 0
    @Published var setDailyGoal: Int = 10
    @Published var isProfilePublic: Bool = true

    func saveChanges() {
        // 수정완료 시 동작 추가하기
    }
}
