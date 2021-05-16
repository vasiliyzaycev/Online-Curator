//
//  User.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 05.03.2021.
//

import Foundation

struct User {
    let id: String
    let statusOfBusy: String
    let name: String
    let middleName: String
    let surname: String
    let childrenHome: String
    let typeOfSpecialist: String
    let email: String
    let phoneNumber: String
    let callHours: String
    let city: String
    let subjectOfCountry: String
    let nameOfPhoto: String
    let accessToken: String
}

extension User: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case statusOfBusy = "status_of_busy"
        case name
        case middleName = "middlename"
        case surname
        case childrenHome = "child_home"
        case typeOfSpecialist = "type_of_specialist"
        case email
        case phoneNumber = "phone_number"
        case callHours = "call_hours"
        case city
        case subjectOfCountry = "subject_of_country"
        case nameOfPhoto = "name_of_photo"
        case accessToken = "access_token"
    }
}
