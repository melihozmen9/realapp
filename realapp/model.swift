//
//  model.swift
//  realapp
//
//  Created by Kullanici on 24.07.2022.
//

import Foundation
struct  photo {
    var albumId : Int
    var Id :Int
    var title : String
    var url : String
    var thumbnailUrl : String
    init(_ dictionary: [String: Any]){
        self.albumId = dictionary["albumId"] as? Int ?? 0
        self.Id = dictionary["Id"] as? Int ?? 0
        self.title = dictionary["title"] as? String ?? ""
        self.url = dictionary["url"] as? String ?? ""
        self.thumbnailUrl = dictionary["thumbnailUrl"] as? String ?? ""
        
    }
    
}
struct  Comment{
    var postId : Int
    var Id :Int
    var name : String
    var email : String
    var body : String
    init(_ dictionary: [String: Any]){
        self.postId = dictionary["postId"] as? Int ?? 0
        self.Id = dictionary["Id"] as? Int ?? 0
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.body = dictionary["body"] as? String ?? ""
        
    }

}
