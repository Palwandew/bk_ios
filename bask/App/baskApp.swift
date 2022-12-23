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
    
    var body: some Scene {
        WindowGroup {
            
            NavigationView {
                if vm.isSignedIn {
                    HomeScreen()
                        .transition(.opacity)
                } else {
                    SignInSignUpSelectionView()
                        .padding([.horizontal, .bottom])
                }
            }
            .environmentObject(vm)
        }
    }
}

//struct SplashScreen: View {
//
//    @State private var isSplashShown: Bool = true
//    var body: some View {
//
//        ZStack{
//
//            if isSplashShown{
//
//                SignInSignUpSelectionView()
//
//            } else {
//                //MARK: - Splash View
//                LinearGradient(gradient: Gradient(colors: [Color(AppColor.GRADIENT_BLUE), Color(AppColor.ACCENT_GREEN)]), startPoint: .top, endPoint: .bottom)
//                    .ignoresSafeArea(.all)
//
//                Image("logo")
//                    .resizable()
//                    .frame(width: 100.0, height: 100.0)
//
//            }
//        }
////        .onAppear {
////            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
////                withAnimation {
////                    isSplashShown.toggle()
////                }
////            })
////        }
//    }
//}


struct SignInSignUpSelectionView: View {
    @Namespace private var heroAnimation
    @StateObject var vm: FlowSelectorViewModel = FlowSelectorViewModel()
    
    var body: some View {
        
        VStack(spacing: 16.0){
            
            switch vm.state{
            case .initial:
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
                        vm.updateState(to: .signUp)
                    }
                }).matchedGeometryEffect(id: "btn", in: heroAnimation)
                
                OutlinedButton(label: "Log in", color: Color(AppColor.DARK_BLUE), action: {
                    withAnimation{
                        vm.updateState(to: .login)
                    }
                })
            case .login:
                LoginScreen(vm: vm)
                    .transition(.move(edge: .trailing))
            case .signUp:
                SignUpScreen(animation: heroAnimation, flowVM: vm)
                    .transition(.move(edge: .trailing))
            }
        }
    }
}
