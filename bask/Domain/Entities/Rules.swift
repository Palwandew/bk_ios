//
//  Rules.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 16/08/2022.
//

import Foundation

struct Rules {
    var petsAllowed: Bool = false
    var petsAllAllowed: Bool = false
    var petsCatsAllowed: Bool = false
    var petsDogsAllowed: Bool = false
    var petsRodentsAllowed: Bool = false
    var petsReptileAllowed: Bool = false
    var petsBigAnimalAllowed: Bool = false
    var smokingAllowed: Bool = false
    var additionalRules: Bool = false
    var additionalRulesDescription: String = ""
    let rulesStatus: Int = 1
    
    func toRequestBodyModel() -> FacilityRulesRequestBody {
        
        return FacilityRulesRequestBody(petsAllowed: self.petsAllowed, petsAllAllowed: self.petsAllAllowed, petsCatsAllowed: self.petsCatsAllowed, petsDogsAllowed: self.petsDogsAllowed, petsRodentsAllowed: self.petsRodentsAllowed, petsReptileAllowed: self.petsReptileAllowed, petsBigAnimalAllowed: self.petsBigAnimalAllowed, smokingAllowed: self.smokingAllowed, additionalRules: self.additionalRules, additionalRulesDescription: self.additionalRulesDescription, rulesStatus: self.rulesStatus)
    }
}
