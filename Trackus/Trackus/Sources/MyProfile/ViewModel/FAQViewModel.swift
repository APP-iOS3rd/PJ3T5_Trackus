//
//  FAQViewModel.swift
//  Trackus
//
//  Created by 박소희 on 1/23/24.
//

import SwiftUI

class FAQViewModel: ObservableObject {
    @Published var selectedQuestionIndex: Int?

    func toggleQuestion(index: Int) {
        selectedQuestionIndex = selectedQuestionIndex == index ? nil : index
    }
}
