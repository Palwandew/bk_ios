//
//  FacilityPicturesStep.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 22/11/2022.
//

import SwiftUI

struct FacilityPicturesStep: View {
    
    @ObservedObject var model: PhotosViewModel// inject the object
    
    @State private var showGallery: Bool = false
    @State private var x: CGFloat = 0
    @State private var count: CGFloat = 0
    @State private var screen = UIScreen.main.bounds.width - 30
    private let size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            //MARK: - Titleç
            Text("Make beautiful photos of your house. It significantly influences on guest`s interest. You can add maximum of 20 pictures.")
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.bottom, 16)
            
            if !model.images.isEmpty {
                LazyHStack(spacing: 16) {
                    ForEach(0..<model.images.count, id:\.self) { index in
                        
                        //MARK: - Image slider
                        GalleryImage(image: model.images[index], onDelete: {
                            
                            updateOffSet(for: index)
                            model.removePhoto(at: index)
                            
                        })
                            .offset(x: self.x)
                            .simultaneousGesture(DragGesture()
                                                    .onChanged({ value in
                                
                                handleDragGestureChangedValue(value)
                            })
                                                    .onEnded({ value in
                                
                                handleDragGestureEndedValue(value)
                            })
                            ).animation(.spring(), value: self.x)
                    }
                }.frame(maxWidth: UIScreen.main.bounds.width - 32, alignment: .leading)
                
                Spacer()
                FilledButton(label: "Open Gallery", color: Color(AppColor.LIGHT_VOILET)) {
                    showGallery = true
                }.padding(.top, 16)
                    .background(Color.white.opacity(0.5))
            } else {
                Spacer()
                EmptyFacilityImagesIndicator()
                    .onTapGesture {
                        showGallery = true
                    }
                Spacer()
            }
            
        }
        //MARK: - Gallery
        .sheet(isPresented: $showGallery, content: {
            Gallery(isPresented: $showGallery)
                .environmentObject(model)
        })
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
    }
    
    private func updateOffSet(for index: Int){
        if (index == (model.images.count - 1)) {
            self.x = -(UIScreen.main.bounds.width - 16) * CGFloat(index - 1)
            self.count -= 1
        } else {
            self.x = -(UIScreen.main.bounds.width - 16) * CGFloat(index)
        }
    }
    
    private func handleDragGestureChangedValue(_ value: DragGesture.Value){
        if value.translation.width > 0 {
            // Right swipe
            
            self.x = value.location.x
        } else {
            // Left swipe
            self.x = value.location.x - UIScreen.main.bounds.width
        }
    }
    
    private func handleDragGestureEndedValue(_ value: DragGesture.Value){
        if value.translation.width > 0 {
            // Right swipe
            if Int(count) == 0 {
                self.x = 0
            } else {
                self.count -= 1
                self.x = -(UIScreen.main.bounds.width - 16) * self.count
            }
        } else {
            // Left swipe
            
            if Int(count) == (model.images.count - 1){
                self.x = -(UIScreen.main.bounds.width - 16) * self.count// this will go to first
            }
            
            if Int(count) < (model.images.count - 1) {
                self.count += 1
                self.x = -(UIScreen.main.bounds.width - 16) * self.count
            }
        }
    }
}


struct EmptyFacilityImagesIndicator: View {
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(AppColor.GREY))
                .opacity(0.3)
            
                .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height * 0.3)
            
            Text("Tap here to add a photo.")
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .font(.custom("Poppins-Regular", size: 14))
            
        }
        
    }
}

