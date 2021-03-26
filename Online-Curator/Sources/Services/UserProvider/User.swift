//
//  User.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 05.03.2021.
//

import Foundation

struct User: Decodable {
    let id: String
    let statusOfBusy: String
    let firstName: String
    let middleName: String
    let lastName: String
    let childrenHome: String
    let typeOfSpecialist: String
    let email: String
    let phoneNumber: String
    let callHours: String
    let city: String
    let subjectOfCountry: String
    let nameOfPhoto: String
}

extension User {
    private enum CodingKeys: String, CodingKey {
        case id
        case statusOfBusy = "status_of_busy"
        case firstName = "name"
        case middleName = "middlename"
        case lastName = "surname"
        case childrenHome = "child_home"
        case typeOfSpecialist = "type_of_specialist"
        case email
        case phoneNumber = "phone_number"
        case callHours = "call_hours"
        case city
        case subjectOfCountry = "subject_of_country"
        case nameOfPhoto = "name_of_photo"
    }
}
