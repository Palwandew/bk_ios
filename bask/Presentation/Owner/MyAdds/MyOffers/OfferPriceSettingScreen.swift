//
//  OfferPriceSettingScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 20/09/2022.
//

import SwiftUI

struct OfferPriceSettingScreen: View {
    
    
    let facility: OfferFacilityViewModel
    var animation: Namespace.ID
    @State var willShowDurationSetting: Bool = false
    @Binding var isShown: Bool
    @State var price: String = ""
    @State var isEditing: Bool = false
    @State var isValid: Bool = true
    @State var didAddPrice: Bool = false
    @StateObject var model = NewOfferViewModel(useCase: OffersUsecase(repo: OffersRepositoryImpl()))
    
    var body: some View {
        VStack(alignment: .leading) {
            
            //MARK: - Back button
            BackButton(onTap: {
                withAnimation(.easeInOut){
                    if !model.didAddPrice {
                        isShown = false
                    } else {
                        model.didAddPrice.toggle()
                    }
                }            })
            
            //MARK: - Title
            Text(model.didAddPrice ? "Set duration" : "Set price")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.horizontal)
            
            Text(model.didAddPrice ? "Set offer duration for your facility" : "Set your offer price")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.horizontal)
                .padding(.bottom)
            
            NavigationLink(isActive: $willShowDurationSetting) {
                OfferDurationSettingScreen()
            } label: {
                EmptyView()
            }
            
            
            AvailableFacilityCard(imageURL: "img.url", price: facility.price, name: facility.name, address: facility.address)
                .matchedGeometryEffect(id: facility.id, in: animation, anchor: .bottom)
                .frame(height: UIScreen.main.bounds.height * 0.15)
                .padding()
            
            if !model.didAddPrice {
                Group {
                    MaterialPriceField(text: $model.offer.discount, isEditing: isEditing, isValid: $model.validPrice, errorMessage: LocalizedStringKey(model.amountEntryErrorLocalizationKey), placeHolder: "Amount of discount")
                        .padding(.horizontal)
                    .padding(.top)
                    
                    Divider()
                        .background(Color(AppColor.DARKEST_BLUE))
                        .padding()
                    
                    
                    
                    HStack {
                        Text("New price")
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        .padding(.leading)
                    
                        Text("\(model.offer.newPrice) currency")
                            .font(.custom("Poppins-Medium", size: 16))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                            .padding(.leading)
                    }
                    
                    
                }
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                
                
            } else {
                OfferDurationSettingScreen()
                    .environmentObject(model)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
                    
            }
            
            Spacer()
            
            FilledButton(label: model.didAddPrice ? "Create offer" : "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                
                withAnimation {
                    model.onContinueTapped()
                    
                }
                
//                willShowDurationSetting.toggle()
            }
            .padding(.horizontal)
            
        }
        .onAppear(perform: {
            model.prepareModel(for: facility)
        })
        .toast(isShowing: $model.toast.willShow){
            Toast(message: model.toast.message, style: model.toast.style)
        }
        .navigationBarHidden(true)
    }
}

//struct OfferPriceSettingScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        OfferPriceSettingScreen()
//    }
//}

struct BackButton: View {
    let onTap: () -> Void
    var body: some View {
       
        
        Button {
            onTap()
        } label: {
            Image(systemName: "chevron.backward")
                .foregroundColor(.gray)
                .font(.system(size: 20))
        }

//            Button(action: { withAnimation(.spring()) {
//                onTap()
//            }}) {
//                Image(systemName: "chevron.backward")
//                    .foregroundColor(.gray)
//                    .font(.system(size: 20))
//                    .padding()
//            }
        
    }
}
