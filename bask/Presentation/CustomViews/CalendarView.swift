//
//  CalendarView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 20/09/2022.
//

import SwiftUI


struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let interval: DateInterval // Interval to show the calendar e.g year 2022
    let content: (Date) -> DateView // Body
    let bookedDates: [Date] // booked
    @Binding var sDate: Date?
    @Binding var eDate: Date?
    
    init(
        interval: DateInterval,
        bookedDays: [Date],
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
                .font(.custom("Poppins-Regular", size: 16, relativeTo: .subheadline))
            
            
            HStack(spacing: 0){
                ForEach(0..<days.count, id:\.self){ day in
                    Spacer()
                    Text(days[day])
                        .font(.footnote)
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
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
    let bookedDays: [Date]
    @Binding var sDate: Date?
    @Binding var eDate: Date?
    
    init(
        month: Date,
        bookedDays: [Date],
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
        let bookedDays: [Date]
        @Binding var sDate: Date?
        @Binding var eDate: Date?
        @State var animate: Bool = false
        init(
            week: Date,
            bookedDays: [Date],
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
                                        
                                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                                            .onTapGesture(perform: {
                                                
                                                updateStartDate(date)
                                                animate.toggle()
                                                
                                            })
                                        
                                    )
                                
                            } else {
                                
                                self.content(date)
                                
                            }
                            
                        }             .padding(.horizontal, 4)
                            .background(isDateBetweenStartAndEnd(date) ? Color(AppColor.GREY) : Color.clear)
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
    @ObservedObject var model: CalendarViewModel
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    var enabledInteraction: Bool = true
    
    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }
    
    
    
    var bookedDays: [Date] = [Calendar.current.startOfDay(for: Date())]
    
    
    
    var body: some View {
        
        switch model.state {
            
        case .loading:
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Spinner()
                    Spacer()
                }
                Spacer()
            }            .animation(.easeInOut, value: model.state)
        case .success:
            withAnimation {
                CalendarView(interval: year, bookedDays: bookedDays, sDate: $startDate, eDate: $endDate) { date in
                    
                    
                    if model.bookedDays.contains(date){
                        CalendarCell(model: model, date: date, isDateSelected: isDateSelected(date), status: DayStatus.booked, isDefaultPrice: false)
                        
                            .frame(width: (UIScreen.main.bounds.width / 7) - 16, height: (UIScreen.main.bounds.width / 7) - 16)
                            .padding(1)
                            .onTapGesture {
                                if enabledInteraction {
                                    setDate(date)
                                }
                            }
                    }
                    
                    if model.availableDays.contains(date) {
                        CalendarCell(model: model, date: date, isDateSelected: isDateSelected(date), status: DayStatus.available)
                        
                            .frame(width: (UIScreen.main.bounds.width / 7) - 16, height: (UIScreen.main.bounds.width / 7) - 16)
                            .padding(1)
                            .onTapGesture {
                                if enabledInteraction {
                                    setDate(date)
                                }
                            }
                    }
                    if model.unavailableDays.contains(date) {
                        CalendarCell(model: model, date: date, isDateSelected: isDateSelected(date), status: DayStatus.unavailable)
                        
                            .frame(width: (UIScreen.main.bounds.width / 7) - 16, height: (UIScreen.main.bounds.width / 7) - 16)
                            .padding(1)
                            .onTapGesture {
                                if enabledInteraction {
                                    setDate(date)
                                }
                            }
                    }
                    
                }
                .animation(.easeInOut, value: model.state)
            }

        case .failed:
            ErrorStateScreen()
                .animation(.easeInOut, value: model.state)
            
        case .initial:
            EmptyView()
            
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
}


enum DayStatus {
    case booked
    case available
    case unavailable
}

struct CalendarCell: View {
    @ObservedObject var model: CalendarViewModel
    let date: Date
    let isDateSelected: Bool
    let status: DayStatus
    var isDefaultPrice: Bool = true
    
    var body: some View {
        GeometryReader { reader in
            
            ZStack(alignment: .bottom) {
                
                switch status {
                    case .booked:
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill( isDateSelected ? Color(AppColor.DARKEST_BLUE) : Color(AppColor.CALENDAR_BOOKED_DAY))
                            .overlay(
                                Text(DateFormatter.day.string(from: date))
                                    .foregroundColor(isDateSelected ? .white : Color(AppColor.DARKEST_BLUE))
                                    .padding(.bottom, 6)
                                    .overlay(
                                        Rectangle().fill()
                                            .frame(height: 1)
                                    )
                            )
                        
                            
                    case .available:
                        RoundedRectangle(cornerRadius: 8)
                            .fill( isDateSelected ? Color(AppColor.DARKEST_BLUE) : Color(AppColor.LIGHT_GREY))
                            .overlay(
                                Text(DateFormatter.day.string(from: date))
                                    .foregroundColor(isDateSelected ? .white : Color(AppColor.DARKEST_BLUE))
                                    .padding(.bottom, 6)
                            )
                    case .unavailable:
                        RoundedRectangle(cornerRadius: 8)
                            .fill( isDateSelected ? Color(AppColor.DARKEST_BLUE) : Color(AppColor.LIGHT_GREY))
                            .overlay(
                                Text(DateFormatter.day.string(from: date))
                                    .foregroundColor(isDateSelected ? .white : Color(AppColor.MAIN_TEXT_LIGHT))
                                    .padding(.bottom, 6)
                            )
                }
                if model.isSpecilPriceDay(date){
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
}

