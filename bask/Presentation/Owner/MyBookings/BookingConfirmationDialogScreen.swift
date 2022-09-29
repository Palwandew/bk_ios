//
//  BookingConfirmationDialogScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 29/09/2022.
//

import SwiftUI

struct BookingConfirmationDialogScreen: View {
    
    
    @ObservedObject var model: MyBookingsViewModel
    @State var showDeclineDialog: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            Text("ConfirmationBookingDialogTitle")
                .font(.custom("Poppins-Medium", size: 20))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("ConfirmationBookingDialogSubtitle")
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            
            AvailableFacilityCard(imageURL: model.facilityToConfirmBooking?.imageURL ?? "", price: model.facilityToConfirmBooking?.price ?? 0, name: model.facilityToConfirmBooking?.name ?? "Mountain", address: "")
                .frame(height: UIScreen.main.bounds.height * 0.15)
            
            InfoView(icon: "calendar", text: LocalizedStringKey(model.facilityToConfirmBooking?.bookedDates ?? ""))
                .padding(.top)
            
            InfoView(icon: "folder.fill", text: LocalizedStringKey("\(model.facilityToConfirmBooking?.price ?? 0) SAR per \(model.facilityToConfirmBooking?.getTotalDaysOfBooking() ?? 0) days"))
           
            InfoView(icon: "folder.fill", text: LocalizedStringKey("Deposit is \(model.facilityToConfirmBooking?.price ?? 0) SAR"))
            
            Spacer()
            
            Button{
                showDeclineDialog.toggle()
            } label: {
                HStack{
                    Spacer()
                    
                    Text("Decline")
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    
                    Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color(AppColor.DARKEST_BLUE), lineWidth: 1))
            }
            
            FilledButton(label: "Approve", color: Color(AppColor.DARKEST_BLUE)) {
                print("Approve booking")
            }
            
        }
        .padding(.horizontal)
        .padding(.top, 32)
        .alertDialog(isShowing: $showDeclineDialog){
            AlertDialog(title: "DeclineBookingDialogTitle", "DeclineBookingDialogSubtitle", "Cancel_button_label", "Decline") {
                showDeclineDialog.toggle()
            } perform: {
                print("print decline booking")
            }

        }
    }
}

//struct BookingConfirmationDialogScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        BookingConfirmationDialogScreen()
//    }
//}

struct InfoView: View {
    
    let icon: String
    let text: LocalizedStringKey
    
    var body: some View {
        HStack{
            Image(systemName: icon)
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text(text)
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Spacer()
        }
    }
}