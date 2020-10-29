//
//  AuthService.swift
//  Smack
//
//  Created by Luke Bezek on 10/27/20.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.setValue(newValue, forKey: TOKEN_KEY)
        }
    }
 
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.setValue(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        AF.request(URL_REGISTER,
                   method: .post,
                   parameters: body,
                   encoding: JSONEncoding.default,
                   headers: HEADER).responseString { (response) in
            
                    switch response.result {
                    case let .success(value):
                        print(value)
                    case let .failure(error):
                        print(error)
                    }
                    
//            if response.result.error == nil {
//                completion(true)
//            } else {
//                completion(false)
//                debugPrint(response.result.error as any)
//            }
        }
   }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        AF.request(URL_LOGIN,
                   method: .post,
                   parameters: body,
                   encoding: JSONEncoding.default,
                   headers: HEADER).responseJSON { (response) in
                    
                    switch response.result {
                    case let .success(value):
                        
                        //Old Way
//                        if let json = response.result.value as? Dictionary<String, Any> {
//
//
//                        if let email = json["user"] as? String {
//                            self.userEmail = email
//                        }
//                        if let token = json["token"] as? String {
//                            self.authToken = token
//                        }
//                    }
                        //using SwiftyJSON
                        guard let data = response.data else { return }
                        let json = try! JSON(data: data)
                        self.userEmail = json["user"].stringValue
                        self.authToken = json["token"].stringValue
                        
                        self.isLoggedIn = true
                        print(value)
                        
                        
                    case let .failure(error):
                        print(error)
                    }
                   }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        let header: HTTPHeaders = [
            "Authorization":"Bearer \(AuthService.instance.authToken)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        AF.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            switch response.result {
            case let .success(value):
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                let id = json["_id"].stringValue
                let color = json["avatarColor"].stringValue
                let avatarName = json["avatarName"].stringValue
                let email = json["email"].stringValue
                let name = json["name"].stringValue
                
                UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
                completion(true)
                
                print(value)
            case let .failure(error):
                print(error)
            }
        }
        
    }
    
}
