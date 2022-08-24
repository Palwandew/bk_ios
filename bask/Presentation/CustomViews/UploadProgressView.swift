//
//  UploadProgressView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 24/08/2022.
//

import SwiftUI

struct UploadProgressView: View {
    
    @State var progress: Double = 0.2
    
    @State var successful: Bool = true
    
    @State var degree: Double = 0
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            HStack{
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Please wait")
                        .foregroundColor(Color(AppColor.DARK_BLUE))
                        .font(Font.custom("Poppins-Medium", size: 20))
                        .onTapGesture {
                            if degree == 0 {
                                degree += 360
                            } else {
                                degree = 0
                            }
                        }
                    
                    
                    
                    Text("We’re creating your ad to publish.")
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        .font(Font.custom("Poppins-Regular", size: 16))
                        .onTapGesture {
                            progress = 0.0
                        }
                    
                    
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(
                            Color.gray.opacity(0.5),
                            lineWidth: 10
                        )
                    
                    
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(
                            Color(AppColor.ACCENT_GREEN),
                            style: StrokeStyle(
                                lineWidth: 10,
                                lineCap: .round
                            )
                            
                        )
                        .rotationEffect(.degrees(-90.0))
                        .animation(.easeOut, value: progress)
                    
                    
                    if successful {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(Color(AppColor.ACCENT_GREEN))
                            .rotation3DEffect(.degrees(degree), axis: (x: 0.0, y: 1.0, z: 0.0))
                            .animation(.spring(), value: degree)
                            //.rotationEffect(.degrees(degree))
                    } else {
                        Text("\(progress * 100, specifier: "%.0f")%")
                            .foregroundColor(Color(AppColor.DARK_BLUE))
                            .font(Font.custom("Poppins-Medium", size: 20))
                    }

                    
                }.frame(width: 77, height: 77)
                
            }
            .padding(16)
            .background(Color.white.cornerRadius(16).shadow(radius: 4))
            .padding(.horizontal)
            Spacer()
        
        }
        .background(Color.black.opacity(0.7))
        .ignoresSafeArea(.all, edges: .all)

    }
}

struct UploadProgressView_Previews: PreviewProvider {
    static var previews: some View {
        UploadProgressView()
    }
}
