//
//  UserSelectionView.swift
//  bask
//
//  Created by MapMac on 20/12/2022.
//

import SwiftUI

struct UserSelectionView: View {
    
    
    @Binding var isOwnerSelected: Bool
    
    var body: some View {
        
        
        
        GeometryReader{ reader in
            ZStack {
                ZStack(alignment:.leading){
                    RoundedRectangle(cornerRadius: reader.size.height/2)
                        .fill(Color(AppColor.GREY))
                    
                    
                    RoundedRectangle(cornerRadius: reader.size.height/2)
                        .fill(Color(AppColor.DARK_BLUE))
                        .frame(width: reader.size.width/2 - 16,height: reader.size.height * 0.80)
                        .shadow(radius: 4)
                        .offset(x: isOwnerSelected ? 0: reader.size.width/2 + 8)
                        .padding(.leading, 4)
                        .animation(.spring(), value: isOwnerSelected)
                    
                }
                
                HStack{
                    createLabel("Owner")
                        .onTapGesture {
                            if !isOwnerSelected {
                                isOwnerSelected.toggle()
                            }
                            
                        }
                    
                    Spacer()
                    
                    createLabel("Guest")
                        .onTapGesture {
                            if isOwnerSelected {
                                isOwnerSelected.toggle()
                            }
                        }
                }
                
            }
        }
    }
    
    fileprivate func createLabel(_ text: String) -> some View {
        Text(text)
            .foregroundColor(Color.white)
            .font(.custom("Poppins-Medium", size: 16))
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
}

