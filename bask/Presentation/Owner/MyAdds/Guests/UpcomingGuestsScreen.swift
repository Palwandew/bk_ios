//
//  UpcomingGuestsScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 15/09/2022.
//

import SwiftUI

struct UpcomingGuestsScreen: View {
    
    @EnvironmentObject private var model : UpcomingGuestsViewModel
    
    var body: some View {
        
        switch model.state {
            
        case .loading:
            Spinner()
            
        case .success:
            if model.upcomingGuests.isEmpty {
                
                EmptyState(illustration: "empty_guest_illustration", message: "You are not expecting any guests at this moment.")
            }
            else {
                ScrollView{
                    
                    LazyVStack {
                        ForEach(model.upcomingGuests){ guest in
                            MyGuestListItem(guest.facilityName, guest.facilityAddress, guest.chechInTime, guest.checkOutTime, guest.name)
                        }
                    }
                }
            }
            
        case .failed:
            ErrorStateScreen()
            
        case .initial:
            EmptyView()
        }
    }
}

struct UpcomingGuestsScreen_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingGuestsScreen()
    }
}

struct ErrorStateScreen: View {
    
    var onRetry: (() -> Void)? = nil
    
    var body: some View {
        
        HStack {
            Spacer()
            VStack(spacing: 32.0){
                Spacer()
                Image(systemName: "xmark.octagon.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.red.opacity(0.6))
                
                Text("oops")
                    .font(.custom("Poppins-Medium", size: 20, relativeTo: .headline))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    
                
                Text("something_went_wrong")
                    .font(.custom("Poppins-Medium", size: 16))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    .multilineTextAlignment(.center)
                
                
                Button {
                    print("he")
                    if let onRetry = onRetry {
                        onRetry()
                    }
                    
                } label: {
                    Text("retry")
                        .foregroundColor(.white)
                        .padding(.horizontal, 64)
                        .padding(.vertical, 8)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                Spacer()

            }
            Spacer()
        }
        
    }
}
