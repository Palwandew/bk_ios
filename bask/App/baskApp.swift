//
//  baskApp.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import SwiftUI

@main
struct baskApp: App {
    //let postViewModel = AppDI.shared.postDependencies()
    //let signUpViewModel = AppDI.shared.signupDependencies()
    @StateObject var vm: FlowSelectorViewModel = FlowSelectorViewModel()
    private let keyChainHelper = KeychainHelper.shared
    var body: some Scene {
        WindowGroup {
            
            NavigationView {
                if keyChainHelper.isUserLoggedIn {
                    HomeScreen()
                } else {
                    FlowSelector(model: vm)
                }

            }
            .environmentObject(vm)
        }
    }
}

struct FlowSelector: View {
    
    @ObservedObject var model: FlowSelectorViewModel
    var body: some View {

        if model.isSignedIn {
            HomeScreen()
                .transition(.opacity)
            
        } else {
            SignInSignUpSelectionView()
                .transition(.opacity)
        }
    }
}


struct SignInSignUpSelectionView: View {
    
    @StateObject var model = SignInSignUpSelectionViewModel()
    
    var body: some View {
        

            
            switch model.state{
            case .initial:
                VStack(spacing: 16.0){
                    HStack(alignment: VerticalAlignment.top){
                        VStack(alignment: .leading) {
                            
                            Image("logo")
                                .resizable()
                                .frame(width: 90.0, height: 90.0)
                                .padding(.leading, -18)
                            
                            Text(NSLocalizedString("Welcome to", comment: "")).font(Font.custom("Poppins-Medium", size: 33))
                                .foregroundColor(Color(AppColor.DARK_BLUE))
                            
                            Text("Bask").font(Font.custom("Poppins-Medium", size: 33))
                                .foregroundColor(Color(AppColor.ACCENT_GREEN))
                            
                        }
                        
                        Spacer()
                        
                    }
                    
                    Spacer()
                    
                    FilledButton(label: "Sign up", color: Color(AppColor.DARKEST_BLUE), action: {
                        withAnimation(.spring()){
                            model.updateState(to: .signUp)
                        }
                    })
                    
                    OutlinedButton(label: "Log in", color: Color(AppColor.DARK_BLUE), action: {
                        withAnimation{
                            model.updateState(to: .login)
                        }
                    })
                }.padding(.horizontal)
            case .login:
                LoginScreen(vm: model)
                    .transition(.move(edge: .trailing))
            case .signUp:
                SignUpScreen(flowVM: model)
                    .transition(.move(edge: .trailing))
            
        }
    }
}
