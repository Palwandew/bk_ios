//
//  MaterialTimePicker.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 07/08/2022.
//

import SwiftUI

struct MaterialTimePicker: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var newUnitViewModel: AddNewUnitViewModel
    @StateObject var timePickerViewModel = TimePickerViewModel()
    let constraint: TimeConstraint
    
    var body: some View {
        //ZStack {
        
        VStack {
            
            HStack {
                Text("Select time")
                    .font(Font.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                Spacer()
            }.padding(32)
            
            
            HStack {
                
                Text("\(timePickerViewModel.hour < 10 ? "0" : "")\(timePickerViewModel.hour)")
                    .font(Font.custom("Poppins-Regular", size: 64))
                    .foregroundColor(timePickerViewModel.isSelectingHour ? Color(AppColor.DARKEST_BLUE) : .gray)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.1)))
                
                    .onTapGesture {
                        timePickerViewModel.isSelectingHour = true
                        timePickerViewModel.updateDegree()
                    }
                
                Text(":")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("\(timePickerViewModel.minutes < 10 ? "0" : "")\(timePickerViewModel.minutes)")
                    .font(Font.custom("Poppins-Regular", size: 64))
                    .foregroundColor(timePickerViewModel.isSelectingHour ? .gray : Color(AppColor.DARKEST_BLUE))
                //                    .fontWeight(tpViewModel.isSelectingHour ? .heavy : .bold)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.1)))
                    .onTapGesture {
                        timePickerViewModel.isSelectingHour = false
                        timePickerViewModel.updateDegree()
                        
                    }
                
                VStack{
                    Text("AM")
                        .foregroundColor(timePickerViewModel.timePeriod == .AM ? .black : .gray)
                        .font(timePickerViewModel.timePeriod == .AM ? Font.custom("Poppins-Medium", size: 18) : Font.custom("Poppins-Regular", size: 18))
                        .padding(8)
                        .onTapGesture {
                            timePickerViewModel.timePeriod = .AM
                        }
                    
                    
                    Text("PM")
                        .foregroundColor(timePickerViewModel.timePeriod == .AM ? .gray : .black)
                        .font(timePickerViewModel.timePeriod == .PM ? Font.custom("Poppins-Medium", size: 18) : Font.custom("Poppins-Regular", size: 18))
                        .padding(8)
                        .onTapGesture {
                            timePickerViewModel.timePeriod = .PM
                        }
                    
                    
                }
                
                .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.1)))
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
                .padding(.leading, 8)
            }
            
            ClockView()
                .environmentObject(timePickerViewModel)
                .frame(width: 280, height: 280)
            
            Spacer()
            
            //MARK: - Buttons
            HStack(spacing: 16.0){
                
                Spacer()
                
                
                //MARK: - Cancel
                Button {
                    print("Cancel")
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .font(Font.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        .padding(8)
                }
                
                
                //MARK: - Apply
                Button {
                    
                    switch constraint {
                    case .checkInAfter:
                        newUnitViewModel.facility.checkInAfter = timePickerViewModel.getTime()
                        
                    case .checkInBefore:
                        newUnitViewModel.facility.checkInBefore = timePickerViewModel.getTime()
                    case .checkOutBefore:
                        newUnitViewModel.facility.checkOutBefore = timePickerViewModel.getTime()
                    }
                    self.presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text("Apply")
                        .font(Font.custom("Poppins-Regular", size: 14))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(AppColor.DARKEST_BLUE)))
                }
            }.padding(.trailing, 32)
        }
        //}
    }
}



class TimePickerViewModel: ObservableObject {
    
    @Published var hour: Int = 12
    @Published var minutes: Int = 0
    @Published var angle: Double = 0
    @Published var isSelectingHour: Bool = true
    @Published var timePeriod: TimePeriod = .AM
    
    
    func updateDegree(){
        withAnimation(.spring()) {
            if isSelectingHour {
                angle = Double(hour * 30)
            } else {
                
                angle = Double(minutes * 6)
            }
        }
    }
    
    func onGestureChanged(_ value: DragGesture.Value, _ circleIndicatorSize: CGFloat){
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radians = atan2(vector.dy - circleIndicatorSize, vector.dx - circleIndicatorSize)
        
        var angle = radians * 180 / .pi
        
        
        if angle < 0 {
            angle = 360 + angle
            
        }
        
        if isSelectingHour {
            let roundOff = 30 * Int(round(angle / 30))
            self.angle = Double(roundOff)
            if roundOff/30 == 0 {
                hour = 12
            } else {
                hour = roundOff/30
            }
            
        } else {
            let roundOff = 6 * Int(round(angle / 6))
            self.angle = Double(roundOff)
            if roundOff / 6 == 60 {
                minutes = 0
            } else {
                minutes = roundOff/6
            }
        }
    }
    
    func onGestureEnded(_ value: DragGesture.Value){
        
        if isSelectingHour {
            
            withAnimation(.spring(), {
                
                self.angle = Double(minutes * 6)
                
                isSelectingHour = false
            })
            
        } else {
            withAnimation(.spring()) {
                self.angle = Double(hour * 30)
                
                isSelectingHour = true
                
            }
        }
    }
    
    func getTime() -> String {
        return ("\(hour):\(minutes < 10 ? "0" : "")\(minutes) \(timePeriod.rawValue)")
    }
    
    public enum TimePeriod: String {
        case PM = "PM"
        case AM = "AM"
    }
}

enum TimeConstraint {
    case checkInAfter
    case checkInBefore
    case checkOutBefore
}

struct ClockView: View {
    
    @EnvironmentObject var viewModel: TimePickerViewModel
    let accentColor: Color = Color(red: 0.086, green: 0.114, blue: 0.314)
    private let background: Color = Color(red: 0.969, green: 0.98, blue: 0.992)
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                
                //MARK: - Clock backgroud
                
                
                Circle()
                    .fill(background)
                
                //MARK: - Hand
                
                
                Circle()
                    .fill(accentColor)
                    .frame(width: geometry.size.width * 0.05, height: geometry.size.width * 0.05)
                    .overlay(
                        Rectangle()
                            .fill(accentColor)
                            .frame(width: 3, height: geometry.size.width / 2.7)
                        ,alignment: .bottom
                    )
                    .rotationEffect(Angle.degrees(viewModel.angle))
                
                //MARK: - Selector Dot
                
                
                Circle()
                    .fill(accentColor)
                    .frame(width: geometry.size.width * 0.15, height: geometry.size.width * 0.15)
                    .offset(x: geometry.size.width / 2 - 30)
                    .rotationEffect(.init(degrees: viewModel.angle))
                    .gesture(DragGesture().onChanged({ value in
                        
                        viewModel.onGestureChanged(value, geometry.size.width * 0.1)
                        
                    }).onEnded({ value in
                        
                        viewModel.onGestureEnded(value)
                        
                    }))
                    .rotationEffect(.init(degrees: -90))
                
                ForEach(1...12, id: \.self) {index in
                    VStack {
                        
                        if viewModel.isSelectingHour {
                            Text("\(index)")
                                .foregroundColor(viewModel.hour == index ? .white : .black)
                                .font(Font.custom("Poppins-Regular", size: 18))
                                .rotationEffect(.init(degrees: Double(-index) * 30))
                        } else {
                            Text("\(index * 5)")
                            
                                .rotationEffect(.init(degrees: Double(-index) * 30))
                        }
                    }
                    .frame(width: geometry.size.width , height: geometry.size.height )
                    .offset( y: -geometry.size.width / 2 + 30 )
                    .rotationEffect(.init(degrees: Double(index) * 30))
                }
            }
        }
    }
}

//struct MaterialTimePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        MaterialTimePicker()
//    }
//}
