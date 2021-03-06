//
//  UserDataService.swift
//  Smack
//
//  Created by Luke Bezek on 10/28/20.
//

import Foundation

class UserDataService {
    
    static let instance  = UserDataService()
    
    public private(set) var id  = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
}
