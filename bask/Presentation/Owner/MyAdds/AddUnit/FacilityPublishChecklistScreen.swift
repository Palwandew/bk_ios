//
//  FacilityPublishChecklistScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI

struct FacilityPublishChecklistScreen: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @State var progress: Float = 0.332

    private let checkList: [String] = ["Name", "Rooms", "Amenities", "Amenities (paid)", "Rules of house", "Facility Location", "Check-in", "Price", "Description", "Add photos"]
    
    @State var showPublish: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            //MARK: - Title
            
            
            Text("Publish your ad")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
        
            //MARK: - List
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    ForEach(0..<10, id:\.self){ index in
                        ChecklistRow(title: checkList[index], isCompleted: true)
                            .padding(.bottom)
                    }
                }
            }
            
            //MARK: - Continue Button
            
            NavigationLink(destination:
                            PublishFacilityScreen(), isActive: $showPublish) {
                EmptyView()
            }
            
            Spacer()
            
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                
                print("tapped")
                showPublish.toggle()
                
            }.padding(.top)
                .background(Rectangle().fill(Color.white.opacity(0.5)))
            
            
            
            
        }
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
    
    struct FacilityPublishChecklistScreen_Previews: PreviewProvider {
        static var previews: some View {
            FacilityPublishChecklistScreen()

        }
    }



struct ChecklistRow: View {
    
    let title: String
    let isCompleted: Bool
    
    var body: some View {
        
        HStack{
            Text(title)
                .font(Font.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Spacer()
            
            if isCompleted{
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color(AppColor.ACCENT_GREEN))
                
            } else {
                Text("Continue")
                    .font(Font.custom("Poppins-Medium", size: 14))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
            }
        }
        
    }
}

