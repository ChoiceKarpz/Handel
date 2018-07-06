//
//  Event.swift
//  Handel
//
//  Created by gridstone on 5/7/18.
//  Copyright © 2018 gridstone. All rights reserved.
//

import Foundation

public class Event: Codable {
    var title: String
    var location: String
    var creator: String
    var dateIsConfirmed: Bool = false
    var numberInvited: Int?
    var numberGoing: Int?
    var eventDescription: String
    
    init(titleToSet: String, locationToSet: String, creatorToSet: String, eventDescriptionToSet: String) {
        title = titleToSet
        location = locationToSet
        creator = creatorToSet
        eventDescription = eventDescriptionToSet
    }
}












public struct EventLists: Codable {
    let eventsConfirmed: [Event]
    let eventsPending: [Event]
    
    init(confirmed: [Event], pending: [Event]) {
        eventsConfirmed = confirmed
        eventsPending = pending
    }

}
