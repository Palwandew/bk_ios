//
//  FacilityPicturesScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI

struct FacilityPicturesScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var phViewModel = PhotosViewModel(useCase: PhotosUsecase(repo: PhotosRepositoryImpl(uploadManager: PhotosUploadManager())))// inject the object
   
    @State var progress: Float = 1.0
    @State var showGallery: Bool = false
    @State var pickerResult: [Image] = []
    @State var showChecklist: Bool = false
    @State var picLoop: [Int] = [1,3,4,5,3,4,5]
    
    @State var x: CGFloat = 0
    @State var count: CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 30
    
    @State var test: Image?
    
    private let size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    var body: some View {
        
        VStack {
            
            //MARK: - Title
            
            Text("Count: \(Int(count))")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.yellow)
                
            
            Text("Make beautiful photos of your house. It significantly influences on guest`s interest. You can add maximum of 20 pictures.")
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.bottom, 16)
                .background(Color.yellow)
            
            LazyHStack(spacing: 16) {
                ForEach(0..<picLoop.count) { item in
                    ImageView(withURL: "test.com", size: size)
                        .frame(width: UIScreen.main.bounds.width - 32)
                        .background(Color.orange)
                        .offset(x: self.x)
                        .highPriorityGesture(DragGesture()
                                                .onChanged({ value in
                            print("Value ---> \(value.location.x) Translation ---> \(value.translation.width)")
                            if value.translation.width > 0 {
                                // Right swipe
                                
                                self.x = value.location.x
                            } else {
                                // Left swipe
                                self.x = value.location.x - UIScreen.main.bounds.width
                            }
                        })
                                            .onEnded({ value in

                            if value.translation.width > 0 {
                                // Right swipe
                                if Int(count) == 0 {
                                    self.x = 0
                                } else {
                                    print("Current count: >>>\(self.count)")
                                    self.count -= 1
                                    self.x = -(UIScreen.main.bounds.width - 16) * self.count
                                }
                            } else {
                                // Left swipe
                                
                                if Int(count) == (picLoop.count - 1){
                                    self.x = -(UIScreen.main.bounds.width - 16) * self.count// this will go to first
                                }
                                
                                if Int(count) < (picLoop.count - 1) {
                                    self.count += 1
                                    self.x = -(UIScreen.main.bounds.width - 16) * self.count
                                }
                            }
//                            if value.translation.width < 0 && Int(count) < picLoop.count {
//                                print("Width is greater than 0")
//                                self.x = -UIScreen.main.bounds.width
//                            }
//                            if Int(count) < picLoop.count && Int(count) > 0 {
//                                print("count >>>> \(picLoop.count)")
//                                self.x = UIScreen.main.bounds.width //* 0.85
//
//                            } else {
//                                if count != 0 {
//
//                                } else {
//                                    self.x = 0//value.translation.width
//
//                                }
//                            }
                        })
//                                                .onEnded({ value in
//                            if value.translation.width > 0 {
//                                if value.translation.width > ((screen - 80) / 2) && Int(self.count) != self.getMid() {
//                                    self.count += 1
//                                    self.x = (self.screen + 15) * self.count
//                                } else {
//                                    self.x = (self.screen + 15) * self.count
//                                }
//                            } else {
//                                if -value.translation.width > ((screen - 80) / 2) && -Int(self.count) != self.getMid() {
//                                    self.count -= 1
//                                    self.x = (self.screen + 15) * self.count
//                                } else {
//                                    self.x = (self.screen + 15) * self.count
//                                }
//                            }
//                        })
                    ).animation(.spring(), value: self.x)
                }
            }.frame(maxWidth: UIScreen.main.bounds.width - 32, alignment: .leading)
                .background(Color.blue)
        }
        .onAppear(perform: {
            print("picture screen is appearing")
        })
        //MARK: - Gallery
        
        
//        .sheet(isPresented: $showGallery, content: {
//            Gallery(selectedImagesThumbnails: $pickerResult, isPresented: $showGallery)
//                .environmentObject(phViewModel)
//        })
        .padding(.horizontal, 16)
        .background(Color.green)
    }
    
    func getMid() -> Int {
        return 1//pickerResult.count / 2
    }
}

struct FacilityPicturesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityPicturesScreen()
    }
}






//if !pickerResult.isEmpty {
//
//                //ScrollView(.horizontal, showsIndicators: false) {
//                LazyHStack(spacing: 15){
//                    ForEach(0..<pickerResult.count, id:
//                                \.self){ image in
//                        GalleryImage(image: pickerResult[image], onDelete: {
//                            print("tapped")
//                            pickerResult.remove(at: 0)
//                        }).frame(width: UIScreen.main.bounds.width - 30)
//                            .shadow(radius: 4)
//
//                            .offset(x: self.x)
//                            .highPriorityGesture(DragGesture()
//                                                    .onChanged({ value in
//
//                                if value.translation.width  > 0 {
//                                    self.x = value.location.x
//                                } else {
//                                    self.x = value.location.x - self.screen
//                                }
//
//                            })
//                                                    .onEnded({ value in
//                                if value.translation.width > 0 {
//                                    if value.translation.width > ((screen - 80) / 2) && Int(self.count) != self.getMid() {
//                                        self.count += 1
//                                        self.x = (self.screen + 15) * self.count
//                                    } else {
//                                        self.x = (self.screen + 15) * self.count
//                                    }
//                                } else {
//                                    if -value.translation.width > ((screen - 80) / 2) && -Int(self.count) != self.getMid() {
//                                        self.count -= 1
//                                        self.x = (self.screen + 15) * self.count
//                                    } else {
//                                        self.x = (self.screen + 15) * self.count
//                                    }
//                                }
//                            })
//                            )
//                    }
//                }
//
//                .frame(width: UIScreen.main.bounds.width - 30, alignment: .topLeading)
//                //.background(Color.blue.opacity(0.2).cornerRadius(24))
//                .animation(.spring())
//            }
//
