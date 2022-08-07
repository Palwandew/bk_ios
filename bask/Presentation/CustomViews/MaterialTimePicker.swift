//
//  MaterialTimePicker.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 07/08/2022.
//

import SwiftUI

struct MaterialTimePicker: View {
    
    @StateObject var tpViewModel = TimePickerViewModel()
    
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
                
                Text("\(tpViewModel.hour < 10 ? "0" : "")\(tpViewModel.hour)")
                    .font(Font.custom("Poppins-Regular", size: 64))
                    .foregroundColor(tpViewModel.isSelectingHour ? Color(AppColor.DARKEST_BLUE) : .gray)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.1)))
                
                    .onTapGesture {
                        tpViewModel.isSelectingHour = true
                        tpViewModel.updateDegree()
                    }
                
                Text(":")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("\(tpViewModel.minutes < 10 ? "0" : "")\(tpViewModel.minutes)")
                    .font(Font.custom("Poppins-Regular", size: 64))
                    .foregroundColor(tpViewModel.isSelectingHour ? .gray : Color(AppColor.DARKEST_BLUE))
//                    .fontWeight(tpViewModel.isSelectingHour ? .heavy : .bold)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.1)))
                    .onTapGesture {
                        tpViewModel.isSelectingHour = false
                        tpViewModel.updateDegree()
                        
                    }
                
                VStack{
                    Text("AM")
                        .foregroundColor(tpViewModel.timePeriod == .AM ? .black : .gray)
                        .font(tpViewModel.timePeriod == .AM ? Font.custom("Poppins-Medium", size: 18) : Font.custom("Poppins-Regular", size: 18))
                        .padding(8)
                        .onTapGesture {
                            tpViewModel.timePeriod = .AM
                        }
                    
                    
                    Text("PM")
                        .foregroundColor(tpViewModel.timePeriod == .AM ? .gray : .black)
                        .font(tpViewModel.timePeriod == .PM ? Font.custom("Poppins-Medium", size: 18) : Font.custom("Poppins-Regular", size: 18))
                        .padding(8)
                        .onTapGesture {
                            tpViewModel.timePeriod = .PM
                        }
                    
                    
                }
                
                .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.1)))
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1))
                .padding(.leading, 8)
            }
            
            ClockView()
                .environmentObject(tpViewModel)
                .frame(width: 300, height: 300)
            
            Spacer()
            
            HStack(spacing: 16.0){
                
                Spacer()
                
                Button {
                    print("Cancel")
                } label: {
                    Text("Cancel")
                        .font(Font.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        .padding(8)
                }
                
                Button {
                    print("OK")
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
    
    public enum TimePeriod {
        case PM
        case AM
    }
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

struct MaterialTimePicker_Previews: PreviewProvider {
    static var previews: some View {
        MaterialTimePicker()
    }
}
