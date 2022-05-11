//
//  UserTypeSelectionScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/05/2022.
//

import SwiftUI

struct UserTypeSelectionScreen: View {
    
    @State private var showDetail = false
    
    @ObservedObject var signupViewModel: SignupViewModel
    
    
    var body: some View {
        
        NavigationView{
            
            VStack(spacing: 16.0){
                HStack(alignment: VerticalAlignment.top){
                    VStack(alignment: .leading) {
                        
                        Image("logo")
                            .resizable()
                            .frame(width: 90.0, height: 90.0)
                            .padding(.leading, -18)
                        
                        Text("Welcome to").font(Font.custom("Poppins-Medium", size: 33))
                            .foregroundColor(Color(AppColor.DARK_BLUE))
                        
                        Text("Bask").font(Font.custom("Poppins-Medium", size: 33))
                            .foregroundColor(Color(AppColor.ACCENT_GREEN))
                        
                    }
                    
                    Spacer()
                    
                }
                .offset(x: signupViewModel.navigate ? -(UIScreen.main.bounds.width / 1.5) : 0, y: 0)
                .animation(.spring(), value: signupViewModel.navigate)
                
                Spacer()
                
                OutlinedButton(label: "I'm Owner", color: Color(AppColor.DARK_BLUE), action: {
                    print("Hello Owner")
                })
                    .offset(x: signupViewModel.navigate ? -(UIScreen.main.bounds.width) : 0, y: 0)
                    .animation(.spring(), value: signupViewModel.navigate)
                
                NavigationLink(destination: LoginScreen(signUpViewModel: signupViewModel), isActive: $showDetail) { EmptyView() }
                
                FilledButton(label: "I'm guest", color: Color(AppColor.DARKEST_BLUE), action: {
                    withAnimation{
                        print("Width -> \(UIScreen.main.bounds.width)")
                        signupViewModel.navigate.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            
                            showDetail.toggle()
                            
                            //signupViewModel.navigate.toggle()
                        }
                        
                    }
                })
                    .offset(x: signupViewModel.navigate ? UIScreen.main.bounds.width - 32: 0, y: 0)
                    .animation(.spring(), value: signupViewModel.navigate)
                
            }
            .padding(.horizontal, 32.0)
            .background(Color(AppColor.BACKGROUND))
            .navigationTitle("")
        }
    }
}



//struct UserTypeSelectionScreen_Previews: PreviewProvider {
//
//    static var previews: some View {
//
//        UserTypeSelectionScreen()
//
//    }
//
//}
