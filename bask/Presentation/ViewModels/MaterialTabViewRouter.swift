//
//  MaterialTabViewRouter.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/07/2022.
//

import SwiftUI

class MaterialTabViewRouter: ObservableObject {
    @Published var currentTab: MaterialTabViewPage = .upcoming
}

enum MaterialTabViewPage {
    case upcoming
    case present
    case past
}
