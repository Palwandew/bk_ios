import Foundation

// MARK: - AvailableFacilityItemResponse
struct AvailableFacilityItemResponse: Codable {
    let data: AvailableFacilityDataClass
    let error: Bool
    let message: String
}

// MARK: - DataClass
struct AvailableFacilityDataClass: Codable {
    let availableItem: AvailableItem

    enum CodingKeys: String, CodingKey {
        case availableItem = "booked_item"
    }
}

// MARK: - BookedItem
struct AvailableItem: Codable {
    let price: Int
    let bookedItemDescription: String?
    let englishName, checkInAfter, address: String
    let length, width: Int
    let latitude, longitude: Double
    let capacity: Int
    let cancellationpolicy: CancellationPolicy?
    let owner: Owner
    let images: [FacilityImage]
    let facilityservices: [JSONAny]
    let noOfLivingrooms: String
    let reviews: Reviews

    enum CodingKeys: String, CodingKey {
        case price
        case bookedItemDescription = "description"
        case englishName
        case checkInAfter = "check_in_after"
        case address, length, width, latitude, longitude, capacity, cancellationpolicy, owner, images, facilityservices
        case noOfLivingrooms = "no_of_livingrooms"
        case reviews
    }
}



// MARK: - Owner
struct Owner: Codable {
    let id, fullName: String
}



// MARK: - Encode/decode helpers




