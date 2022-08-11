//
//  File.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 11/08/2022.
//

import UIKit

class UIApplicationHelper {
    static func dimissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
}
