//
//  TakeToWorkItem.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 16.05.2021.
//

import Foundation

struct TakeToWorkItem: Hashable {
    let surname: String
    let name: String
    let middleName: String
    let city: String
    let phone: String
    let email: String
    let requestType: String
    let message: String
    let sendingTime: String
    let sendingDate: String
}

extension TakeToWorkItem: Codable {
    private enum CodingKeys: String, CodingKey {
        case surname = "surname_of_user"
        case name = "name_of_user"
        case middleName = "middlename_of_user"
        case city
        case phone = "phone_of_user"
        case email = "email_of_user"
        case requestType = "type_of_request"
        case message = "message_of_user"
        case sendingTime = "time_sent_user"
        case sendingDate = "date_sent_user"
    }
}
