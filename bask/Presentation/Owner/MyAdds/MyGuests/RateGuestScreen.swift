//
//  RateGuestScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 15/09/2022.
//

import SwiftUI

struct RateGuestScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var rating: Int = 1
    @State var comment: String = ""
    @State var editMode: Bool = false
    @State var done: Bool = false
    @State private var textStyle = UIFont.TextStyle.body
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                Text("Rate Guest", comment: "Screen Title")
                    .font(.custom("Poppins-Medium", size: 26))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .padding(.bottom)
                
                    HStack {
                        
                        Rectangle().fill(.black).frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .padding(.trailing, 8)
                        
                        VStack(alignment: .leading) {
                            Text("15 Jun - 16 May, 2020")
                                .font(Font.custom("Poppins-Medium", size: 12))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                                .padding(.bottom, 1)
                            
                            Text("Palwandew")
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
                
                RatingQuestion(title: "Cleanlines", question: "Do you think appartments was clean?", rating: $rating)
                
                RatingQuestion(title: "Facility structure", question: "Rate facility`s constructed infrastructure such as buildings, pools, outdoors", rating: $rating)

                RatingQuestion(title: "Services", question: "Did quality of services coresponde to declared? Was all the declared services available?", rating: $rating)

                RatingQuestion(title: "Communication", question: "Was communication with guest easy and comfortable?", rating: $rating)

                RatingQuestion(title: "Overall", question: "What is your overall impresion about appartmens and host?", rating: $rating)
                
                
                CommentField()
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 150)
                    .padding(.bottom, 32)
                    
                
                if !editMode{
                    FilledButton(label: "Save rating", color: Color(AppColor.DARKEST_BLUE)) {
                        print("Save")
                        editMode.toggle()
                        done.toggle()
                    }
                }
                
            }.padding(.horizontal)
            
        }
        
        .background(Color(AppColor.BACKGROUND))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action : {
                        print("Back button tapped")
                        //self.dismiss.callAsFunction()
                        self.presentationMode.wrappedValue.dismiss()
                       
                    }){
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(AppColor.GREY))
                        
                    },
                trailing: Button(action : {
                    print("Back button tapped")
                    //                    self.dismiss.callAsFunction()
                }){
                    if !editMode{
                        Text("Edit")
                            .font(Font.custom("Poppins-Light", size: 16.0))
                            .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                            .onTapGesture {
                                editMode.toggle()
                            }
                    }
                })
    }
}

struct RateGuestScreen_Previews: PreviewProvider {
    static var previews: some View {
        RateGuestScreen()
        
        //CommentField()
    }
}

struct RatingQuestion: View {
    
    let title: String
    let question: String
    @Binding var rating: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            
            Text(title)
                .font(.custom("Poppins-Regular", size: 20))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text(question)
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            
            HStack{
                ForEach(1..<6){index in
                    
                    Button {
                        print("he")
                        rating = index
                    } label: {
                        Image(systemName: rating >= index ? "star.fill" : "star")
                            .font(.custom("Poppins-Regular", size: 20))
                            .foregroundColor(.yellow)
                    }
                }
            }.padding(.bottom)
        }
    }
}

struct CommentField: View {
    @State var comment = ""
    @State var resign: Bool = false
    var body: some View {
        ZStack(alignment: .topLeading){
            
            
            MaterialCommentField(text: $comment, resignFirstResponder: $resign)
            
                .padding()
                

                
            
            if comment.isEmpty{
                Text("Tell about your impresions from staying?")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color.gray)
                    .padding()
                }
            
        }

        .background(RoundedRectangle(cornerRadius: 8).fill(.white))
        .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
        
        
    }
}