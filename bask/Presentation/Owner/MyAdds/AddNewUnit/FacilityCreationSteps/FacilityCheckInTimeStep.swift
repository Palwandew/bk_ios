//
//  FacilityCheckInTimeStep.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 16/11/2022.
//

import SwiftUI

struct FacilityCheckInTimeStep: View {
    
    @ObservedObject var model: CheckInCheckOutViewModel
    @State private var showTimePicker = false
    @State var timeConstraint: TimeConstraint = .checkInAfter
    var body: some View {
        
        VStack(alignment: .leading) {
            
            //MARK: - Title
            
            Text("Please enter check-in time when a guest can arrive into the facility")
                .lineLimit(2)
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.top, -16)
                .padding(.bottom, 32)
            
            
            Group {
                MaterialTextSelector(text: $model.checkInTime, placeHolder: "Check-in after")
                    .frame(height: 60)
                    .onTapGesture {
                        
                        showTimePicker(for: .checkInAfter)
                        
                    }
               
                
                MaterialTextSelector(text: $model.checkOutTime, placeHolder: "Check-out before")
                    .frame(height: 60)
                    .onTapGesture {
                        showTimePicker(for: .checkOutBefore)
                    }
                
            }.padding(.bottom)
            
        }
        .sheet(isPresented: $showTimePicker, content: {
            MaterialTimePicker(constraint: $timeConstraint)
                .environmentObject(model)
        })
        .background(Color.white)
        
    }
    
    private func showTimePicker(for newConstraint: TimeConstraint){
        print("previous value \(timeConstraint) ..--.. new value \(newConstraint)")
        timeConstraint = newConstraint
        showTimePicker.toggle()
    }
}

