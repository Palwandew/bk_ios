//
//  ProfileTabScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 24/09/2022.
//

import SwiftUI

struct ProfileTabScreen: View {
    
    @State var showLogoutDialog: Bool = false
     
    var body: some View {

        if #available(iOS 15.0, *) {
            MainV(showLogoutDialog: $showLogoutDialog)
                .alert("Logout", isPresented: $showLogoutDialog) {
                    Text("Cancel")
                } message: {
                    Text("Do you want to logout?")
                }
        } else {
            // Fallback on earlier versions
            MainV(showLogoutDialog: $showLogoutDialog)
            .alert(isPresented: $showLogoutDialog) {
                    Alert(
                        title: Text("Unable to Save Workout Data"),
                        message: Text("The connection to the server was lost."),
                        primaryButton: .default(
                            Text("Try Again"),
                            action: {
                                print("hi")
                            }
                        ),
                        secondaryButton: .destructive(
                            Text("Delete"),
                            action: {
                                print("Hi")
                            }
                        )
                    )
                }
        }

//        .alertDialog(isShowing: $showLogoutDialog) {
//            AlertDialog(title: "Logout", "Do you want to logout?", "Cancel", "Logout") {
//                print("Cancel")
//                showLogoutDialog.toggle()
//            } perform: {
//                print("Logout")
//                showLogoutDialog.toggle()
//            }
//
//        }
    }
}

struct ProfileTabScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTabScreen()
    }
}

struct MainV: View {
    @Binding var showLogoutDialog: Bool 
    
    var body: some View {
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
            NavigationLink{
                FacilityNameScreen()
            } label: {
                RowButton(title: "Agreement", icon: "doc.text.fill")
            }
            
            
            
            //MARK: - Help Center
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
}
