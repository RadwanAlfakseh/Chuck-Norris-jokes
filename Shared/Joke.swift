//
//  Joke.swift
//  Chuck Norris jokes
//
//  Created by Radwan Alfakseh on 20/06/2022.
//

import Foundation
class Joke:Identifiable,Codable{
    let icon_url:String
    let id:String
    let url:String
    let value:String
    let created_at:String
    let updated_at:String
    let categories:[String]
}
