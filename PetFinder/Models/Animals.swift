//
//  Animals.swift
//  PetFinder
//
//  Created by Consultant on 1/19/23.
//

import Foundation


struct AnimalAPI: Decodable {
    let animals: [Animal]
    let pagination: Pagination
}

struct Animal: Decodable, Identifiable {
    let id: Int
    let organizationId: String
    let url: String?
    let type: String?
    let species: String?
    let colors: Colors
    let age: String?
    let gender: String
    let size: String
    let name: String
    let description: String?
    let photos: [Photo]
    let videos: [Video]
    let status: String
    let contact: Contact
    
    enum CodingKeys: String, CodingKey {
        case id, url, type, species, colors, age, gender, size, name, description, photos, videos, status, contact
        case organizationId = "organization_id"
    }
    
}

struct Colors: Decodable {
    let primary: String?
    let secondary: String?
    let tertiary: String?
}

struct Photo: Decodable {
    let small: String?
    let medium: String?
    let large: String?
    let full: String?
}

struct Video: Decodable {
    let embeded: String?
}

struct Contact: Decodable {
    let email: String?
    let phone: String?
    let address: Address?
}

struct Address: Decodable {
    let address: String?
    let city: String?
    let state: String?
    let postcode: String?
    let country: String?
    
    enum CodingKeys: String, CodingKey {
        case city, state, postcode, country
        case address = "address1"
    }
}

struct Pagination: Decodable {
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
    }
}

extension Animal {
    static var mockAnimal: Animal {
        .init(
            id: 59496811,
            organizationId: "MI176",
            url: "https://www.petfinder.com/cat/lia-59496811/mi/lansing/capital-area-humane-society-mi176/?referrer_id=cc01221c-0fb6-48a2-8401-64ef4f9c8f26",
            type: "Cat",
            species: "Cat",
            colors: Colors(primary: "Tabby (Brown / Chocolate)", secondary: nil, tertiary: nil),
            age: "Senior",
            gender: "Female",
            size: "Medium",
            name: "Lia",
            description: nil,
            photos: [
                Photo(
                    small: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/59496811/1/?bust=1674148178&width=100",
                    medium: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/59496811/1/?bust=1674148178&width=300",
                    large: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/59496811/1/?bust=1674148178&width=600",
                    full: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/59496811/1/?bust=1674148178")
            ],
            videos: [],
            status: "adoptable",
            contact: Contact(
                email: "adoptions@adoptlansing.org",
                phone: "(517) 626-6060",
                address: Address(
                    address: "7095 West Grand River Avenue",
                    city: "Lansing",
                    state: "MI",
                    postcode: "48906",
                    country: "US"
                )
            )
        )
    }
}
