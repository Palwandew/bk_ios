//
//  MultiStepHandler.swift
//  bask
//
//  Created by MapMac on 21/12/2022.
//

import Foundation

protocol MultiStepHandler {
    var steps: [any CaseIterable] { get set }
    var currentStep: any CaseIterable { get set }
    
    func continueBtnTapped()
    func backBtnTapped()
    func performNextAction()
    func performBackAction()
    
}
