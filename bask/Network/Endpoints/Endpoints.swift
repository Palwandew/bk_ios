//
//  Endpoints.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 04/09/2022.
//

import Foundation

struct Endpoints{
    private let apiVersion = "/api/v1/"
    let path: String
    var queryItems: [URLQueryItem]? = nil
}


extension Endpoints{
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.baskapp.co"
        components.path = apiVersion + path
        components.queryItems = queryItems
        
        return components.url
    }
}

extension Endpoints{
    
    static let CREATE_FACILITY: Endpoints = Endpoints(path: "facility", queryItems: nil)
    static let CREATE_IMAGE_LINK: Endpoints = Endpoints(path: "image", queryItems: nil)
    static let ADD_FREE_AMENITIES: Endpoints = Endpoints(path: "facilityservice/amenitiesfree")
    static let ADD_PAID_AMENITIES: Endpoints = Endpoints(path: "facilityservice/amenitiesextra")
    static let GET_BOOKED_FACILITIES: Endpoints = Endpoints(path: "booking/currentmonth")
    static let GET_AVAILABLE_FACILITIES: Endpoints = Endpoints(path: "facility/available")
    static let GET_UNPUBLISHED_FACILITIES: Endpoints = Endpoints(path: "facility/unpublish")
    static let GET_UPCOMING_GUESTS: Endpoints = Endpoints(path: "booking/upcomingguests")
    static let GET_PRESENT_GUESTS: Endpoints = Endpoints(path: "booking/presentguests")
    static let GET_GUESTS_RATINGS: Endpoints = Endpoints(path: "booking/guestsrating")
    static let ADD_GUEST_RATING: Endpoints = Endpoints(path: "rating")
    static let ADD_COMPLAIN: Endpoints = Endpoints(path: "request")
    
    static func GET_SINGLE_RATING(with query: [URLQueryItem]) -> Endpoints {
        return Endpoints(path: "rating", queryItems: query)
    }
    
    static func GET_BOOKED_ITEM(with query: [URLQueryItem]) -> Endpoints {
        return Endpoints(path: "rating", queryItems: query)
    }
    
    static func GET_AVAILABLE_FACILITY(with query: [URLQueryItem]) -> Endpoints {
     return Endpoints(path: "facility/availableitem", queryItems: query)
    }
    
    static func GET_CHECKLIST(for facilityID: String) -> Endpoints {
     return Endpoints(path: "facility/\(facilityID)")
    }
    static func GET_SIGNED_URL(with query: [URLQueryItem]) -> Endpoints {
     return Endpoints(path: "files/getpresignedurl", queryItems: query)
    }
    
    static func UPDATE_FACILITY(_ facilityID: String) -> Endpoints {
        return Endpoints(path: "facility/\(facilityID)", queryItems: nil)
    }
}
