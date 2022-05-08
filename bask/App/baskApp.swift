//
//  baskApp.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import SwiftUI

@main
struct baskApp: App {
    let postViewModel = AppDI.shared.postDependencies()
    var body: some Scene {
        WindowGroup {
            PostView(postVM: postViewModel)
        }
    }
}
