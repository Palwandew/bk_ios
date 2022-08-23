//
//  FacilityPicturesScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI
import QuickLookThumbnailing

struct FacilityPicturesScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var phViewModel = UploadViewModel()
    @State var progress: Float = 0.332
    @State var showGallery: Bool = false
    @State var pickerResult: [UIImage] = []
    @State var showChecklist: Bool = false
    
    
    @State var x: CGFloat = 0
    @State var count: CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 30
    
    @State var testImage: Image?
    
    @State var image:UIImage = UIImage()
    
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
            
            Text("Make beautiful photos of your house. It significantly influences on guest`s interest. You can add maximum of 20 pictures.")
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.bottom, 16)
            
            
            testImage?
                .resizable()
                .scaledToFit()
            
            if !pickerResult.isEmpty {
                
                //ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 15){
                    ForEach($pickerResult, id:\.self){ image in
                        GalleryImage(image: image, onDelete: {
                            print("tapped")
                            pickerResult.remove(at: 0)
                        }).frame(width: UIScreen.main.bounds.width - 30)
                            .shadow(radius: 4)
                        
                            .offset(x: self.x)
                            .highPriorityGesture(DragGesture()
                                                    .onChanged({ value in
                                
                                if value.translation.width  > 0 {
                                    self.x = value.location.x
                                } else {
                                    self.x = value.location.x - self.screen
                                }
                                
                            })
                                                    .onEnded({ value in
                                if value.translation.width > 0 {
                                    if value.translation.width > ((screen - 80) / 2) && Int(self.count) != self.getMid() {
                                        self.count += 1
                                        self.x = (self.screen + 15) * self.count
                                    } else {
                                        self.x = (self.screen + 15) * self.count
                                    }
                                } else {
                                    if -value.translation.width > ((screen - 80) / 2) && -Int(self.count) != self.getMid() {
                                        self.count -= 1
                                        self.x = (self.screen + 15) * self.count
                                    } else {
                                        self.x = (self.screen + 15) * self.count
                                    }
                                }
                            })
                            )
                    }
                }
                
                .frame(width: UIScreen.main.bounds.width - 30, alignment: .topLeading)
                //.background(Color.blue.opacity(0.2).cornerRadius(24))
                .animation(.spring())
            }
            
            
            //MARK: - Continue Button
            
            NavigationLink(destination:
                            FacilityPublishChecklistScreen(), isActive: $showChecklist) {
                EmptyView()
            }
            
            Spacer()
            
            FilledButton(label: "Open Gallery", color: Color(AppColor.LIGHT_VOILET)) {
                
                print("tapped")
                showGallery = true
                
            }.padding(.top, 16)
                .background(Color.white.opacity(0.5))
            
            FilledButton(label: pickerResult.isEmpty ? "Add photos later" : "Upload", color: Color(AppColor.DARKEST_BLUE)) {
                
                print("tapped")
                showChecklist.toggle()
                
            }.padding(.top, 8)
                .background(Rectangle().fill(Color.white.opacity(0.5)))
            
            
            
            
        }
        .onAppear(perform: {
            
            print("On Appera --->")
            //            if !imageUrls.isEmpty{
            //                guard let cgImage = phViewModel.imageIo(url: imageUrls[0]) else {
            //                    print("eror cgImage")
            //                    return
            //
            //                }
            //
            //                let uiImage = UIImage(cgImage: cgImage)
            //                testImage = Image(uiImage: uiImage)
            //
            //            }
            
        })
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
    
    func getMid() -> Int {
        return pickerResult.count / 2
    }
    
    func generateThumbnail(url: URL, scale: CGFloat)  {
        
        let size: CGSize = CGSize(width: 60, height: 90)
        
        
        // Creating request for thumbnail
        let request = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: scale, representationTypes: .all)
        
        let generator = QLThumbnailGenerator.shared
        
        generator.generateRepresentations(for: request) { (thumbnail, type, error) in
            
            DispatchQueue.main.async {
                if thumbnail == nil || error != nil {
                    // Handle the error case gracefully.
                    print("erroro occured while creating thumbnail")
                    print(error!.localizedDescription)
                } else {
                    // Display the thumbnail that you created.
                    if let image = thumbnail?.uiImage {
                        self.testImage = Image(uiImage: image)
                    }
                }
            }
        }
    }
}

//struct FacilityPicturesScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        FacilityPicturesScreen()
//    }
//}


struct Huh: Identifiable {
    var id: Int
    var num: Int
}
