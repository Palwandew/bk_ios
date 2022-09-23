//
//  ExistingPromoTicket.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 23/09/2022.
//

import SwiftUI

struct ExistingPromoTicketUpperPartShape: Shape{
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            let width: CGFloat = rect.width
            let height: CGFloat = rect.height
            
            path.move(to: CGPoint(x: 0, y: 0))

            path.addLine(to: CGPoint(x: 0, y: (height ) - (width / 35)))

            path.addArc(center: CGPoint(x: 0, y: height ), radius: width / 35, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)

            path.addArc(center: CGPoint(x: width, y: height ), radius: width / 35, startAngle: .degrees(180), endAngle: .degrees(360), clockwise: false)
  
            path.addLine(to: CGPoint(x: width, y: 0))
           
            path.closeSubpath()
        }
    }
    
}

struct ExistingPromoTicketLowerPartShape: Shape{
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            let width: CGFloat = rect.width
            let height: CGFloat = rect.height
            
            path.move(to: CGPoint(x: 0, y: height))

            path.addLine(to: CGPoint(x: width, y: height))

            path.addLine(to: CGPoint(x: width, y: 0 + (width / 35)))

            path.addArc(center: CGPoint(x: width, y: 0), radius: width / 35, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)

            path.addLine(to: CGPoint(x: (width / 35), y: 0))

            path.addArc(center: CGPoint(x: 0, y: 0 ), radius: width / 35, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)

            path.closeSubpath()
        }
    }
    
}

//struct ExistingPromoTicket_Previews: PreviewProvider {
//    static var previews: some View {
//        ExistingPromoTicket()
//    }
//}
