//
//  FacilityTimeScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 07/08/2022.
//

import SwiftUI

struct FacilityTimeScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    //@EnvironmentObject var viewModel: AddNewUnitViewModel
    @StateObject var viewModel: AddNewUnitViewModel = AddNewUnitViewModel(useCase: CreateFacilityUseCase(repository: CreateFacilityReopositoryImpl()))
    @State var progress: Float = 0.332
    
    @State var checkInAfter: String = ""
    @State var checkInBefore: String = "02:00 PM"
    @State var checkOutBefore: String = ""
    
    @State var showPriceSetup: Bool = false 
    @State var showTimePicker: Bool = false
    @State var timeConstraint: TimeConstraint = .checkInAfter
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            //MARK: - Title
            
            
            Text("Check-in and\ncheck-out time")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("Please enter check-in time when a guest can arrive into the facility")
                .lineLimit(2)
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.top, -16)
                .padding(.bottom, 32)
            
            
            Group {
                MaterialTextSelector(text: $checkInAfter, placeHolder: "Check-in after")
                    .frame(height: 60)
                    .onTapGesture {
                        print("hi")
                        timeConstraint = .checkInAfter
                        showTimePicker.toggle()
                    }
                
                
                MaterialTextSelector(text: $checkInBefore, placeHolder: "Check-in before")
                    .frame(height: 60)
                    .onTapGesture {
                        print("hi")
                        timeConstraint = .checkInBefore
                        showTimePicker.toggle()
                    }
                
                MaterialTextSelector(text: $checkOutBefore, placeHolder: "Check-out before")
                    .frame(height: 60)
                    .onTapGesture {
                        print("hi")
                        timeConstraint = .checkOutBefore
                        showTimePicker.toggle()
                    }
                
            }.padding(.bottom)
            
            
            //MARK: - Continue Button
            
            NavigationLink(destination:
                            FacilityPriceSetupScreen(), isActive: $showPriceSetup) {
                EmptyView()
            }
                
                Spacer()
                
                FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                    
                    print("tapped")
                    //print(region.center)
                    //showCountries.toggle()
                    showPriceSetup.toggle()
                    
                    
                }.padding(.top)
                    .background(Rectangle().fill(Color.white.opacity(0.5)))
                
                
        
            
        }
        .sheet(isPresented: $showTimePicker, content: {
            MaterialTimePicker(constraint: timeConstraint)
        })
        .padding(.horizontal)
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button(action : {
                    print("Back button tapped")
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color(AppColor.GREY))
                    
                },
            trailing: Button(action : {
                print("Back button tapped")
                self.presentationMode.wrappedValue.dismiss()
                //                    self.dismiss.callAsFunction()
            }){
                Text("Exit")
                    .font(Font.custom("Poppins-Light", size: 16.0))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                
            })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .principal){
                HStack{
                    
                    LinearProgressBar(value: $progress)
                        .frame(width: UIScreen.main.bounds.width/2,height: UIScreen.main.bounds.height/100)
                    
                }
            }
        }
    }
}

struct FacilityTimeScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityTimeScreen()
    }
}
