//
//  MyProfileViewModel.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

import SwiftUI

class MyProfileViewModel: ObservableObject {
    @Published var isSettingsActive: Bool = false
    @Published var isFAQActive: Bool = false
    @Published var isAskActive: Bool = false


    func settingsButtonTapped() {
        isSettingsActive = true
    }

    func faqButtonTapped() {
        isFAQActive = true
    }

    func askButtonTapped() {
        isAskActive = true
    }

}

