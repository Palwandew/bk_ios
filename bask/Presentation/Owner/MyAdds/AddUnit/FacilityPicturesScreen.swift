//
//  FacilityPicturesScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI

struct FacilityPicturesScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var progress: Float = 0.332
    @State var showGallery: Bool = false
    @State var pickerResult: [UIImage] = []
    
    @State var showChecklist: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            //MARK: - Title
            
            
            Text("Add photos")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("Overall photos")
                .font(Font.custom("Poppins-Regular", size: 20, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.top)
                .padding(.bottom, 1)
            
            Text("Make beautiful photos of your house. It significantly influences on guest`s interest.")
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.bottom, 32)
            
            
            Button {
                print("Add pic")
                showGallery = true
            } label: {
                Text("Add overall photos")
                    .foregroundColor(.white)
                    .font(Font.custom("Poppins-Regular", size: 14))
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(AppColor.DARKEST_BLUE)))
            }
            
            
            if !pickerResult.isEmpty {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack{
                        ForEach($pickerResult, id:\.self){ image in
                            GalleryImage(image: image)
                                .frame(width: UIScreen.main.bounds.width * 0.90, height: 250)
                        }
                    }
                }
                
                //List {
                //PictureSliderView(images: $pickerResult)
                //  .frame(height: 300)
                
                // }
            }
            //            ScrollView {
            //                    ForEach(pickerResult, id: \.self) { uiImage in
            //                        Image(uiImage: uiImage)
            //                            .resizable()
            //
            //                            .frame(width: 300, height: 300)
            //                    }
            //                    .padding()
            //                  }
            //            .frame(width: UIScreen.main.bounds.width * 0.90)
            
            
            //MARK: - Continue Button
            
                        NavigationLink(destination:
                                        FacilityPublishChecklistScreen(), isActive: $showChecklist) {
                            EmptyView()
                        }
            
            Spacer()
            
            FilledButton(label: "Add photos later", color: Color(AppColor.DARKEST_BLUE)) {
                
                print("tapped")
                showChecklist.toggle()
                
            }.padding(.top)
                .background(Rectangle().fill(Color.white.opacity(0.5)))
            
            
            
            
        }
        .sheet(isPresented: $showGallery, content: {
            Gallery(selectedImages: $pickerResult, isPresented: $showGallery)
        })
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

struct FacilityPicturesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityPicturesScreen()
    }
}
