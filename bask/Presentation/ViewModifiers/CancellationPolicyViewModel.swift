//
//  CancellationPolicyViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import Foundation

class CancellationPolicyViewModel: ObservableObject {
    @Published var policy: CancellationPolicy = .anytime
    
    
}

enum CancellationPolicy {
    case anytime
    case threeDays
    case week
}
