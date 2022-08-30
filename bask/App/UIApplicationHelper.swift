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
    
    static func popToRootView() {
        findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)?
            .popToRootViewController(animated: true)
    }
    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
        return nil
    }
}
