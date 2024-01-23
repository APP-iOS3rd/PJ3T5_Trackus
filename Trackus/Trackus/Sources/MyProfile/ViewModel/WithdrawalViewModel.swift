//
//  WithdrawalViewModel.swift
//  Trackus
//
//  Created by 박소희 on 1/23/24.
//

import SwiftUI

class WithdrawalViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var isAgreed: Bool = false
    @Published var showWithdrawalAlert: Bool = false

    func toggleAgreement() {
        isAgreed.toggle()
    }

    func initiateWithdrawal() {
        showWithdrawalAlert = true
    }

    func confirmWithdrawal() {
        
    }
}

