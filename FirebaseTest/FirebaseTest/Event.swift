//
//  Event.swift
//  FirebaseTest
//
//  Created by Dylan Murphy on 4/28/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Event: Codable, Identifiable {
    let id = UUID().uuidString
    //@DocumentID var id : String?
    var title : String
    var description : String
    var labels : [String]
    var entities : [Entity]?
    var start : String
    //var attendance = 0
}



struct Entity: Codable {
    var formatted_address : String?
}
