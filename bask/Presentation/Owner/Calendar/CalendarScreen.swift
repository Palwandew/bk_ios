//
//  CalendarScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/10/2022.
//

import SwiftUI

struct CalendarScreen: View {
    
    @StateObject private var model: CalendarScreenViewModel = CalendarScreenViewModel(repo: FacilityRepositoryImpl())
    
    @State var selectedIndex: Int = 0
    
    
    @State var price: String = ""
    @State var isValid: Bool = true
    let error: LocalizedStringKey = LocalizedStringKey("error")
    
    @State var menuShowed: Bool = false
    
    
    @State var selectedMenuItem: Status = .unavailable
    private var menuItem: [Status] = [.available, .booked, .unavailable]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            //MARK: - Title
            CalendarFacilities(model: model, selectedIndex: selectedIndex)
            
            Group{
                
                
                
                HStack(alignment: .top){
                    
                    Image(systemName: "calendar")
                    
                    Text(model.selectedFacility?.address ?? "placeHolderAddress")
                        .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .body))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        .lineLimit(2)
                    
                }.redacted(reason: (model.selectedFacility != nil) ? [] : .placeholder)
                
                HStack(alignment: .top){
                    
                    Image(systemName: "calendar")
                    
                    Text("Default price is \(model.selectedFacility?.defaultPrice ?? 0) per night")
                        .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .body))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        .lineLimit(2)
                    
                }.padding(.vertical, 4)
                    .redacted(reason: (model.selectedFacility != nil) ? [] : .placeholder)
                
                if model.startDate == nil {
                    HStack {
                        Spacer()
                        Text("Select dates to change status or price")
                            .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .body))
                            .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                            .padding()
                            
                        Spacer()
                    }.background(Color(AppColor.LIGHT_GREY).cornerRadius(8))
                    
                    
                } else {
                    HStack{
                        
                        MaterialPriceField(text: $price, isValid: $isValid, errorMessage: error, placeHolder: "Price per night")
                            .onTapGesture {
                                print("hii")
                                model.checkSelectedDatesForAvailability()
                            }
                        
                        MaterialDropdown(menuShowed: $menuShowed, selectedText: selectedMenuItem.rawValue) {
                            withAnimation {
                                menuShowed.toggle()
                            }

                        }.frame(height: 55)
                        
                    }
                }
                
                
            }.padding(.horizontal)
            
            ZStack(alignment: .topTrailing) {
                
                CalendarViews(model: model.datesViewModel, startDate: $model.startDate, endDate: $model.endDate)
                
                if menuShowed {
                    VStack(alignment: .leading, spacing: 16){
                        
                        ForEach(menuItem, id:\.self) { menuItem in
                            
                            if menuItem != selectedMenuItem{
                                HStack {
                                    Text(menuItem.rawValue)
                                        .font(Font.custom("Poppins-Regular", size: 16))
                                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                                        .padding(.leading)

                                    Spacer()
                                }.contentShape(Rectangle())
                                .onTapGesture {
                                    selectedMenuItem = menuItem
                                    model.handleStatusChange(to: selectedMenuItem)
                                    menuShowed.toggle()
                                }
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width / 2.25)
                    .padding(.vertical)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.white).shadow(radius: 2))
                    .padding(.trailing)
                    .transition(.scale)
                    
                }
                
                    
            }
            
            if model.showSaveButton {
                FilledButton(label: "Save", color: Color(AppColor.DARKEST_BLUE), action: {
                    
                    model.performSaveAction(for: price, with: selectedMenuItem.rawValue)
                    
                }).padding(.horizontal)
            }
            
        }
        .alertDialog(isShowing: $model.showAlertDialog, content: {
            
            //MARK: - Alert Dialogs

            if model.priceChangeDialog {
                BookedFacilityPriceChangeDialog(model: model)
            } else {
                BookingCancelationDialog(onProceedCancelation: {
                    print("Send cancelation request")
                }, onDismissDialog: {
                    model.showAlertDialog.toggle()
                })
            }
        })
        .onChange(of: model.showAlertDialog, perform: { showDialog in
            if showDialog {
                UIApplicationHelper.dimissKeyboard()
            }
        })
        .gesture((DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                        .onEnded({ value in
                                            

                                            if value.translation.height > 0 {
                                                // down
                                                UIApplicationHelper.dimissKeyboard()
                                                
                                            }
                                        })))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
    }
    
    
    
}


struct CalendarScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScreen()
    }
}


struct CalendarFacilities: View {
    
    @ObservedObject var model: CalendarScreenViewModel
    let selectedIndex: Int
    private let width: CGFloat = UIScreen.main.bounds.width
    @State private var initialOffSet: CGFloat = UIScreen.main.bounds.width / 8
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            Text("Calendar")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.horizontal)
            
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(model.facilities) { facility in
                        VStack{
                            Text(facility.name)
                                .foregroundColor(model.isFacilitySelected(facility) ? Color(AppColor.DARKEST_BLUE) : Color(AppColor.MAIN_TEXT_LIGHT))
                                .font(.custom("Poppins-Regular", size: 16))
                                .offset(y: model.isFacilitySelected(facility) ? 8 : 0)
                                .onTapGesture {
                                    model.updateSelectedFacility(with: facility)
                                   
                                }
                            
                            if model.isFacilitySelected(facility) {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color(AppColor.ACCENT_GREEN))
                                    .frame(height: 5)
                            }
                        }.contentShape(Rectangle())
                            
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                    .padding(.horizontal)
                }
            }
            
            
//            HStack{
//                RoundedRectangle(cornerRadius: 8).fill(Color(AppColor.ACCENT_GREEN))
//                    .frame(width: UIScreen.main.bounds.width * 0.10, height: UIScreen.main.bounds.height * 0.01)
//                    .offset(x: selectedIndex == 0 ? initialOffSet : (width - (width * 0.30)))
//                    .animation(.interpolatingSpring(mass: 1.0,stiffness: 100.0,damping: 10,initialVelocity: 0), value: selectedIndex)
//
//            }
//            .padding(.horizontal)
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 1)], startPoint: .bottom, endPoint: .top)
                .frame(height: 6)
                .opacity(0.8)
        }
        .background(Color.white)
    }
}


struct BookedFacilityPriceChangeDialog: View {
    
    @ObservedObject var model: CalendarScreenViewModel
    
    var body: some View {
        VStack{
            Image("icon_complain")

            Text("You can't change price of a booked day")
                .font(.custom("Poppins-Regular", size: 20))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))

            Text("You can only change price of a available day")
                .font(.custom("Poppins-Regular", size: 18))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.top, 8)

            Button{
                model.showAlertDialog.toggle()
                model.showSaveButton = false
            } label: {
                Text("OK")
                    .font(.custom("Poppins-Medium", size: 16))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))

            }.padding(.vertical)
        }.padding()
    }
    
}
