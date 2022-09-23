//
//  OfferDetailView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 22/09/2022.
//

import SwiftUI


//MARK: - OfferDetailView
struct OfferDetailView: View {
    
    
    //MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var myOffersViewModel: MyOffersViewModel
    
    @State var isDragging = false
    @State var newHeight = 0
    @State var currentHeight = 0.610
    @State var showPopup: Bool = false
    @State var willShowCancelBookingDialog: Bool = false
    @State var showCalendarSheet: Bool = false
    
    private let style: FacilityDetailsStyle = .available
    
    //MARK: - Body
    var body: some View {
        
        switch myOffersViewModel.state {
            
            //MARK: - Loading State
        case .loading:
            VStack {
                BackButton {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Spinner()
                Spacer()
            }.onAppear {
                myOffersViewModel.getOfferItemDetails()
            }
            
            
            //MARK: - Success State
        case .success:
            ZStack(alignment: .bottom){
                
                
                //MARK: - Image Slider
                FacilityImagesSliderView(isPopupShown: $showPopup, cancelBookingDialog: $willShowCancelBookingDialog, images: myOffersViewModel.offerItemDetail?.images ?? [], popupStyle: style, onBackTapped: {
                    
                    presentationMode.wrappedValue.dismiss()
                }, onPopupTapped: {
                    showPopup.toggle()
                })
                
                ScrollView{
                    
                    VStack(alignment: .leading, spacing: 16){
                        Group{
                            
                            
                            //MARK: - Offer banner and price
                            HStack {
                                Text("\(myOffersViewModel.offerItemDetail?.price ?? 0) currency")
                                    .font(.custom("Poppins-Medium", size: 16, relativeTo: .body))
                                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                                
                                Text("per night")
                                    .font(Font.custom("Poppins-Regular", size: 14))
                                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                                
                                
                                Divider()
                                    .frame(height: 32)
                                
                                Text(myOffersViewModel.offerItemDetail?.rating ?? "4.3")
                                    .font(Font.custom("Poppins-Medium", size: 16))
                                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                
                                Spacer()
                                
                                Text("\(myOffersViewModel.offerItemDetail?.discountAmount ?? 0) currency")
                                    .foregroundColor(.white)
                                    .font(Font.custom("Poppins-Medium", size: 10, relativeTo: .callout))
                                    .padding(8)
                                    .background(Color(AppColor.LIGHT_VOILET))
                                    .roundCorners(radius: 8, [.topRight, .bottomLeft])
                                    .offset(x: 16, y: -17)
                                
                            }
                            
                            
                            //MARK: - Facility Name
                            Text(myOffersViewModel.offerItemDetail?.name ?? "")
                                .font(Font.custom("Poppins-Regular", size: 26))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                            
                            
                            //MARK: - Facility Size Info
                            SizeInfoView(space: myOffersViewModel.offerItemDetail?.livingSpace ?? "", rooms: myOffersViewModel.offerItemDetail?.livingRooms ?? "", capacity: myOffersViewModel.offerItemDetail?.capacity ?? "")
                            
                            
                            //MARK: - Amenities
                            FacilityAmenitiesView()
                            
                            Divider()
                                .padding(.vertical)
                            
                            
                            //MARK: - Owner Info
                            Group{
                                UserInfoView(name: myOffersViewModel.offerItemDetail?.owner ?? "", rating: "")
                                
                                
                                ArrivalDetailsView(time: myOffersViewModel.offerItemDetail?.arrivalTime ?? "")
                                
                                Divider()
                                    .padding(.vertical)
                            }
                            
                            
                            //MARK: - Map Thumbnail
                            FacilityMapView()// need to provide lat and long
                                .frame(height: UIScreen.main.bounds.height * 0.35)
                                .padding(.bottom)
                            
                            Divider().padding(.vertical)
                            
                            //MARK: - Reviews
                            ReviewsView()
                        }
                        
                        
                        //MARK: - Calendar Check Button
                        Button {
                            print("message guest")
                        } label: {
                            HStack {
                                Spacer()
                                Text("Check Calendar")
                                    .foregroundColor(.white)
                                    .padding()
                                
                                Spacer()
                            }.background(RoundedRectangle(cornerRadius: 8).fill(Color(AppColor.DARKEST_BLUE)))
                        }
                    }.padding()
                    
                        .background(Color.white)
                        .roundCorners(radius: 16, [.topLeft, .topRight])
                        .shadow(radius: 4, y: -3)
                        .padding(.top)
                }
                .frame(height: UIScreen.main.bounds.height * currentHeight)
                .padding(.top)
                
            }
            .navigationBarHidden(true)
            
            
            //MARK: - Failed State
        case .failed:
            VStack {
                BackButton {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                ErrorStateScreen()
                Spacer()
            }
            
        case .initial:
            EmptyView()
        }
    }
}
