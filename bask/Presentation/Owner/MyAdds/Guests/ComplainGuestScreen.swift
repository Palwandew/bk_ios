//
//  ComplainGuestScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 16/09/2022.
//

import SwiftUI

struct ComplainGuestScreen: View {
    
    @StateObject var photoVm = PhotosViewModel(useCase: PhotosUsecase(repo: PhotosRepositoryImpl(uploadManager: PhotosUploadManager())))
    @StateObject var model = ComplainGuestViewModel(ComplainGuestUseCase(repo: GuestsRepositoryImpl()))
    @State var showGallery: Bool = false
    @State var pickerResult: [Image] = []
    @State var progress: Double = 0.0
    
    @State var degree: Double = 0
    
    @State var images: [Int] = [1, 4, 5, 6 ,7 ,8, 12, 1, 0 , 1]
    @State var comment = ""
    
    private var guest: UnratedGuestViewModel? = nil
    
    init(_ guest: UnratedGuestViewModel?){
        self.guest = guest
    }
    
    var body: some View {

        VStack(alignment: .leading) {
            
            Text("Complain", comment: "Screen Title")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.bottom)

            
            HStack {
                
                Rectangle().fill(.black).frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    Text("\(guest?.startDate ?? "") - \(guest?.endDate ?? "")")
                        .font(Font.custom("Poppins-Medium", size: 12))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        .padding(.bottom, 1)
                    
                    Text(guest?.name ?? "")
                        .font(Font.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                }
                
                Spacer()
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
            .padding(.bottom)
            
            CommentField(comment: $model.comments)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 150)
                .padding(.bottom, 32)
            
            
            HStack{
                
                Image(systemName: "photo.fill")
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                Text("Add Image")
                    .font(.custom("Poppins-Regular", size: 14))
            }.contentShape(Rectangle())
                .padding(.bottom)
                .onTapGesture {
                    print("add picture")
                    showGallery.toggle()
                }
            
            
            ScrollView {
                LazyVStack{
                    
                    ForEach(0..<photoVm.images.count, id:
                                    
                                \.self){ index in
                        ComplainImageListItem(progress: $progress, degress: $degree, name: "Image \(index+1)", onRemove: {
                            
                            photoVm.images.remove(at: index)
                        })
                    }
                }.padding(1)
            }.padding(.bottom)
            
            
            Spacer()
            
            
            
            FilledButton(label: "Send complaint", color: Color(AppColor.DARKEST_BLUE)) {
                print("Save")
                model.lodgeComplainAgainst(guest)
                
                
                //degree += 30
//                if progress != 1 {
//                    progress += 0.2
//
//                } else {
//                    progress = 0
//                }
//                if degree == 0 {
//                    degree += 360
//                } else {
//                    degree = 0
//                }

                
            }
            
        }.padding(.horizontal)
            .sheet(isPresented: $showGallery, content: {
                Gallery(selectedImagesThumbnails: $pickerResult, isPresented: $showGallery)
                    .environmentObject(photoVm)
            })
            .toast(isShowing: $model.toast.willShow, content: {
                Toast(message: model.toast.message, style: model.toast.style)
            })
    }
}

struct ComplainImageUplodingProgressView: View {
    
    @Binding var progress: Double
    @Binding var degress: Double
    
    
    var body: some View {
        GeometryReader { reader in
            ZStack{
                Circle()
                    .stroke(
                        Color(AppColor.GREY).opacity(0.5),
                        lineWidth: 2.5
                    )
                
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color(AppColor.DARKEST_BLUE),
                        style: StrokeStyle(
                            lineWidth: 2.5,
                            lineCap: .round
                        )
                        
                    )
                    .rotationEffect(.degrees(-90.0))
                    .animation(.easeOut, value: progress)
                
                if progress != 1 {
                    Circle()
                        .fill(Color(AppColor.ACCENT_GREEN))
                        .frame(width: reader.size.width * 0.5, height: reader.size.width * 0.5)
                        .rotation3DEffect(.degrees(degress), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .animation(.spring(), value: degress)
                } else {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .foregroundColor(Color(AppColor.ACCENT_GREEN))
                        .frame(width: reader.size.width * 0.5, height: reader.size.width * 0.5)
                        
                }
                
            }
        }
    }
}

struct ComplainImageListItem: View {
    @Binding var progress: Double
    @Binding var degress: Double
    let name: String
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 16.0) {
            ComplainImageUplodingProgressView( progress: $progress, degress: $degress)
                .frame(width: 24, height: 24)
            
            Text(name)
                .lineLimit(1)
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Spacer()
            
            Image(systemName: "trash.fill")
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .onTapGesture {
                    onRemove()
                }
        }
    }
}
