//
//  ProfileTabScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 24/09/2022.
//

import SwiftUI

struct ProfileTabScreen: View {
    
    @EnvironmentObject var flowVM: FlowSelectorViewModel
    @State var showLogoutDialog: Bool = false
    
    var body: some View {
        
        NavigationView{
            VStack{
                
                //MARK: - Profile Picture
                Circle().fill().opacity(0.1)
                    .frame(width: 60, height: 60)
                
                
                //MARK: - Name
                Text("Palwandew")
                    .font(.custom("Poppins-Regular", size: 20))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                
                //MARK: - Profile Info
                NavigationLink{
                    ProfileInfoScreen()
                } label: {
                    RowButton(title: "Profile info", icon: "person.fill")
                }
                
                
                //MARK: - Payments
                NavigationLink{
                    PaymentsScreen()
                } label: {
                    RowButton(title: "Payments", icon: "creditcard.fill")
                }
                
                
                //MARK: - Agreement
//                NavigationLink{
//                    FacilityNameSt()
//                } label: {
//                    RowButton(title: "Agreement", icon: "doc.text.fill")
//                }
                
                
                
                //MARK: - Help Center
                // There isn't any networking involve in this.
                NavigationLink{
                    HelpCenterScreen()
                } label: {
                    RowButton(title: "Help Center", icon: "circle.dashed")
                }
                
                
                //MARK: - Exit
                Button{
                    showLogoutDialog.toggle()
                } label: {
                    RowButton(title: "Logout", icon: "rectangle.portrait.and.arrow.right.fill")
                }
                
                Spacer()
                
            }
            .padding(.horizontal)
        }
        .alertDialog(isShowing: $showLogoutDialog) {
            AlertDialog(title: "Logout", "Logout_subtitle", "Cancel_button_label", "Logout") {
                print("Cancel")
                showLogoutDialog.toggle()
            } perform: {
                print("Logout needs to be done")
                showLogoutDialog.toggle()
                flowVM.isSignedIn.toggle()
            }
            
        }
            
        
        
    }
}

//struct ProfileTabScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileTabScreen()
//    }
//}
