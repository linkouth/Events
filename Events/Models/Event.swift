//
//  Event.swift
//  Events
//
//  Created by User on 27/08/2019.
//  Copyright © 2019 Timur LLC. All rights reserved.
//

import Foundation

class Event: Codable {
    var id: Int?
    var name: String?
    var statusString: String?
    var authorName: String?
    var authorPhone: String?
    var authorEmail: String?
    var participantCount: Int?
    var description: String?
    var eventAvatar: String?
    var images: [String]
    var status: Int?
    var startDate: Int?
    var endDate: Int?
    var room: String?
    var comment: String?
    
    init(id: Int? = nil,
         name: String? = nil,
         statusString: String? = nil,
         authorName: String? = nil,
         authorPhone: String? = nil,
         authorEmail: String? = nil,
         participantCount: Int? = nil,
         description: String? = nil,
         eventAvatar: String? = nil,
         images: [String] = [],
         status: Int? = nil,
         startDate: Int?,
         endDate: Int?,
         room: String?,
         comment: String?) {
        self.id = id
        self.name = name
        self.statusString = statusString
        self.authorName = authorName
        self.authorPhone = authorPhone
        self.authorEmail = authorEmail
        self.participantCount = participantCount
        self.description = description
        self.eventAvatar = eventAvatar
        self.images = images
        self.status = status
        self.startDate = startDate
        self.endDate = endDate
        self.room = room
        self.comment = comment
    }
}
