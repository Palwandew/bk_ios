//
//  CancellationPolicyViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import Foundation

class CancellationPolicyViewModel: ObservableObject {
    @Published var policy: CancellationPolicyType = .anytime
    
    
}

enum CancellationPolicyType {
    case anytime
    case threeDays
    case week
}
