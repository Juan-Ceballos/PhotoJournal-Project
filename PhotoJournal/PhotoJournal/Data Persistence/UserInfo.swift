//
//  UserInfo.swift
//  PhotoJournal
//
//  Created by Juan Ceballos on 2/8/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import Foundation

struct UserInfoKeys  {
    static let commentPost = "Comment"
}

class UserInfo  {
    private init()  {}
    
    static let shared = UserInfo()
    
    func updateComment(comment: String)    {
        UserDefaults.standard.set(comment, forKey: UserInfoKeys.commentPost)
    }
    
    func getComment() -> String?    {
        guard let commentToPost = UserDefaults.standard.object(forKey: UserInfoKeys.commentPost) as? String
            else    {
                return nil
            }
        return commentToPost
    }
}
