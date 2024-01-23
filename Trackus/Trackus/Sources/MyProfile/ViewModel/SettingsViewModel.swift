//
//  SettingsViewModel.swift
//  Trackus
//
//  Created by 박소희 on 1/23/24.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var isWithdrawalActive: Bool = false

    func navigateToWithdrawalView() {
        isWithdrawalActive = true
    }
}
