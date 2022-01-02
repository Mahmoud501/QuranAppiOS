//
//  TeamMemberModel.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class TeamMemberModel {

    var photo: String?
    var name: String?
    var position: String?
    
    init() { }
    init(dict: [String: Any]?) {
        self.photo = dict?["photo"] as? String
        self.name = dict?["name"] as? String
        self.position = dict?["position"] as? String
    }
    
}
