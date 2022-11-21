//
//  FreeAmenitiesStep.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 15/11/2022.
//

import SwiftUI

struct FreeAmenitiesStep: View {
    
    @ObservedObject var model: FacilityAmenitiesViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            
            //MARK: - Title
            
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                //MARK: - Wifi
                
                Group{
                    Toggle(isOn: $model.wifi) {
                        Text("Wifi")
                    }.toggleStyle(Checkbox())
                    
                    
                    //MARK: - Parking
                    
                    Toggle(isOn: $model.parking) {
                        Text("Parking")
                    }.toggleStyle(Checkbox())
                    
                    
                    //MARK: - Indoor Pools
                    
                    Toggle(isOn: $model.indoorPool) {
                        Text("Indoor swimming pool")
                    }.toggleStyle(Checkbox())
                    
                    
                    //MARK: - Outdoor Pools
                    
                    Toggle(isOn: $model.outdoorPool) {
                        Text("Outdoor swimming pool")
                    }.toggleStyle(Checkbox())
                }.padding(1)
                    .padding(.bottom)
                
                //MARK: - Checkboxes
                
                Group {
                    Toggle(isOn: $model.outdoorSitting) {
                        Text("Outdoor sitting")
                    }.toggleStyle(Checkbox())
                        
                    
                    Toggle(isOn: $model.bbq) {
                        Text("Barbeque area")
                    }.toggleStyle(Checkbox())
                    
                    
                    Toggle(isOn: $model.gym) {
                        Text("Gym")
                    }.toggleStyle(Checkbox())
                    
                    Toggle(isOn: $model.gamesRoom) {
                        Text("Games room")
                    }.toggleStyle(Checkbox())
                    
                    Toggle(isOn: $model.garden) {
                        Text("Garden")
                    }.toggleStyle(Checkbox())
                    
                    Toggle(isOn: $model.playingField) {
                        Text("Playing field")
                    }.toggleStyle(Checkbox())
                }.padding(.trailing, 1)
                    .padding(.bottom)
                
            })
        
        }
        .background(Color.white)
//            .toast(isShowing: $addNewUnitViewModel.shallRetry, content: {
//                Toast(message: "An error occured. Please try again.", style: .failure)
//
//            })
            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(
//                leading:
//                    Button(action : {
//                        print("Back button tapped")
//                        //self.dismiss.callAsFunction()
//                        self.presentationMode.wrappedValue.dismiss()
//                    }){
//                        Image(systemName: "chevron.backward")
//                            .foregroundColor(Color(AppColor.GREY))
//
//                    },
//                trailing: Button(action : {
//                    print("Back button tapped")
//                    self.presentationMode.wrappedValue.dismiss()
////                    self.dismiss.callAsFunction()
//                }){
//                    Text("Exit")
//                        .font(Font.custom("Poppins-Light", size: 16.0))
//                        .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
//                        .onTapGesture {
//                            UIApplicationHelper.popToRootView()
//                        }
//
//                })
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar{
//                ToolbarItem(placement: .principal){
//                    HStack{
//
//                        LinearProgressBar(value: $progress)
//                            .frame(width: UIScreen.main.bounds.width/2,height: UIScreen.main.bounds.height/100)
//
//                    }
//                }
//            }
    }
}

//struct FreeAmenitiesStep_Previews: PreviewProvider {
//    static var previews: some View {
//        FreeAmenitiesStep()
//    }
//}
