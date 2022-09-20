//
//  CalendarView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 20/09/2022.
//

import SwiftUI

import SwiftUI

fileprivate extension DateFormatter {
    
    static var day: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate("d")
        //formatter.dateFormat = "MMMM"
        return formatter
    }
    
    static var test: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate("dd MM yyyy")
        //formatter.dateFormat = "MMMM"
        return formatter
    }
    
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
        //formatter.dateFormat = "MMMM"
        return formatter
    }
    
    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

fileprivate extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        
        var dates: [Date] = []
        dates.append(interval.start)
        
        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
            
            
        }
        
        return dates
    }
}

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let interval: DateInterval // Interval to show the calendar e.g year 2022
    let content: (Date) -> DateView // Body
    let bookedDates: [CalendarDay] // booked
    @Binding var sDate: Date?
    @Binding var eDate: Date?
    
    init(
        interval: DateInterval,
        bookedDays: [CalendarDay],
        sDate: Binding<Date?>,
        eDate: Binding<Date?>,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.interval = interval
        self.bookedDates = bookedDays
        _sDate = sDate
        _eDate = eDate
        self.content = content
    }
    
    private var months: [Date] {
        
        
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }
    
    var body: some View {
        
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    ForEach(months, id: \.self) { month in
                        MonthHeader(monthTitle: DateFormatter.month.string(from: month))
                        
                        MonthView(month: month, bookedDays: bookedDates, sDate: $sDate, eDate: $eDate, content: self.content)
                            .id(DateFormatter.month.string(from: month))
                            .onAppear {
                                let date = Date()
                                
                                
                                if DateFormatter.month.string(from: date) == DateFormatter.month.string(from: month) {
                                    
                                    proxy.scrollTo(DateFormatter.month.string(from: date), anchor: .center)
                                    
                                }
                            }
                    }
                }
            }
        }
    }
}

struct MonthHeader: View {
    let monthTitle: String
    let days: [LocalizedStringKey] = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(monthTitle)
                .padding(.top, 32)
                .padding(.bottom, 16)
                .font(.headline)
            
            
            HStack(spacing: 0){
                ForEach(0..<days.count, id:\.self){ day in
                    Spacer()
                    Text(days[day])
                        .font(.footnote)
                        .lineLimit(1)
                    Spacer()
                }
            }
        }.padding(.horizontal, 24)
    }
}


struct MonthView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let month: Date
    let content: (Date) -> DateView
    let bookedDays: [CalendarDay]
    @Binding var sDate: Date?
    @Binding var eDate: Date?
    
    init(
        month: Date,
        bookedDays: [CalendarDay],
        sDate: Binding<Date?>,
        eDate: Binding<Date?>,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.month = month
        self.bookedDays = bookedDays
        _sDate = sDate
        _eDate = eDate
        self.content = content
    }
    
    private var weeks: [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month)
        else { return [] }
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
        )
    }
    
    var body: some View {
        LazyVStack {
            ForEach(weeks, id: \.self) { week in
                WeekView(week: week, bookedDays: bookedDays, sDate: $sDate, eDate: $eDate, content: self.content)
            }
        }
    }
    
    
    struct WeekView<DateView>: View where DateView: View {
        @Environment(\.calendar) var calendar
        
        let week: Date
        let content: (Date) -> DateView
        let bookedDays: [CalendarDay]
        @Binding var sDate: Date?
        @Binding var eDate: Date?
        @State var animate: Bool = false
        init(
            week: Date,
            bookedDays: [CalendarDay],
            sDate: Binding<Date?>,
            eDate: Binding<Date?>,
            @ViewBuilder content: @escaping (Date) -> DateView
        ) {
            self.week = week
            self.bookedDays = bookedDays
            _sDate = sDate
            _eDate = eDate
            self.content = content
        }
        
        private var days: [Date] {
            guard
                let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
            else { return [] }
            return calendar.generateDates(
                inside: weekInterval,
                matching: DateComponents(hour: 0, minute: 0, second: 0)
            )
        }
        
        var body: some View {
            HStack(spacing: 0) {
                
                ForEach(days, id: \.self) { date in
                    if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                        HStack {
                            
                            if isDateBetweenStartAndEnd(date){
                                
                                RoundedRectangle(cornerRadius: 8).fill(Color.clear).shadow(radius: 4)
                                
                                    .frame(width: (UIScreen.main.bounds.width / 7) - 16, height: (UIScreen.main.bounds.width / 7) - 16)
                                    .padding(1)
                                    .overlay(
                                        Text(DateFormatter.day.string(from: date))
                                        
                                            .foregroundColor(.white)
                                            .onTapGesture(perform: {
                                                
                                                updateStartDate(date)
                                                animate.toggle()
                                                
                                            })
                                        
                                    )
                                
                            } else {
                                self.content(date)
                                
                            }
                            
                        }             .padding(.horizontal, 4)
                            .background(isDateBetweenStartAndEnd(date) ? Color(red: 0.741, green: 0.753, blue: 0.827, opacity: 1) : Color.clear)
                    } else {
                        
                        self.content(date).hidden()
                            .padding(.horizontal, 4)
                    }
                }
            }
            .padding(.horizontal)
        }
        
        private func isDateBetweenStartAndEnd(_ date: Date) -> Bool {
            if sDate != nil && eDate != nil {
                if date > sDate! && date < eDate! {
                    return true
                    
                }
                
            }
            return false
        }
        
        private func updateStartDate(_ date: Date) {
            if sDate != nil && eDate != nil {
                if date > sDate! && date < eDate! {
                    sDate = date
                    eDate = nil
                }
            }
        }
    }
}

struct CalendarViews: View {
    @Environment(\.calendar) var calendar
    
    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }
    
    let myLocale = Locale(identifier: "ar_KSA")
    
    @State var startDate: Date? = nil
    @State var endDate: Date? = nil
    
    var bookedDays: [CalendarDay] = [CalendarDay(date: "8/30/2022", status:.booked, isDefaultPrice: true)]
    
    var body: some View {
        
        
        NavigationView {
            CalendarView(interval: year, bookedDays: bookedDays, sDate: $startDate, eDate: $endDate) { date in
                
    //            RoundedRectangle(cornerRadius: 8).fill(isDateSelected(date) ? Color(red: 0.086, green: 0.114, blue: 0.314, opacity: 1) : Color.white).shadow(radius: 1)
                
                NestedStack(date: DateFormatter.day.string(from: date), isDateSelected(date))
                
                    .frame(width: (UIScreen.main.bounds.width / 7) - 16, height: (UIScreen.main.bounds.width / 7) - 16)
                    .padding(1)
                    .onTapGesture {
                    
                                                setDate(date)
                                            }
    //                .overlay(
    //                    Text(DateFormatter.day.string(from: date))//.padding()
    //                        .font(.body)
    //                        .foregroundColor(isDateSelected(date) ? .white : .blue)
    //                        .onTapGesture {
    //
    //                            setDate(date)
    //                        }
    //                )
            }
        }
    }
    
    private func isDateSelected(_ date: Date) -> Bool {
        return startDate == date || endDate == date
    }
    
    private func setDate(_ date: Date){
        if startDate == nil {
            startDate = date
        } else {
            
            if date > startDate! {
                if endDate == nil {
                    endDate = date
                } else {
                    startDate = date
                    endDate = nil
                }
            } else {
                startDate = date
                endDate = nil
            }
        }
    }
    
    func getCalendarDay(_ date: Date) -> CalendarDay? {
        let calendarDay = bookedDays.first(where: {$0.date == DateFormatter.test.string(from: date)})
        return calendarDay
    }
}


enum DayStatus {
    case booked
    case available
    case unavailable
}

class CalendarDay{
    let date: String
    let status: DayStatus
    let isDefaultPrice: Bool
    init(date: String, status: DayStatus, isDefaultPrice: Bool){
        self.date = date
        self.status = status
        self.isDefaultPrice = isDefaultPrice
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}

struct NestedStack: View {
    
    let date: String
    let isDateSelected: Bool
    
    init(date: String, _ isDateSelected: Bool){
        self.date = date
        self.isDateSelected = isDateSelected
    }
    var body: some View {
        GeometryReader { reader in
            
        ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 8)
                .fill( isDateSelected ? Color(AppColor.DARKEST_BLUE) : Color.white).shadow(radius: 1)
                    .frame(width: reader.size.width, height: reader.size.height)
                .shadow(radius: 2)
                .overlay(
                    Text(date)
                        .foregroundColor(isDateSelected ? .white : Color(AppColor.DARKEST_BLUE))
                        .padding(.bottom, 6)
                )
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(red: 0.341, green: 0.884, blue: 0.818, opacity: 1))
                    .frame(width: reader.size.width, height: reader.size.height * 0.30)
                    .overlay(
                        Text("300")

                            .foregroundColor( .white)
                            .font(.footnote)
                    )

                
            }
            
        }
    }
}
