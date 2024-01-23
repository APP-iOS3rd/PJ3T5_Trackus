//
//  ReportViewModel.swift
//  Trackus
//
//  Created by 박선구 on 1/17/24.
//

import Foundation


enum AvgAge: String, CaseIterable, Identifiable { // 나이대 피커
    case teens = "10대"
    case twenties = "20대"
    case thirties = "30대"
    case forties = "40대"
    case fifties = "50대"
    
    var id: Self { self }
}
