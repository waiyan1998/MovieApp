//
//  DataModel.swift
//  Movie
//
//  Created by Wai Yan on 10/20/19.
//  Copyright © 2019 Wai Yan. All rights reserved.
//

import Foundation
import ObjectMapper


class Detail  : Mappable{
    
    
    var adult    : Bool?
    var backdrop_path    : String?
    var belongs_to_collection    : [String : Any]?
    var budget    : Int?
    var genres    : Genre?
    var homepage  : String?
    var id    : Bool?
    var imdb_id    :String?
    var original_language    : String?
    var original_title    :String?
    var overview    :String?
    var popularity    : Double?
    var poster_path    :String?
    var production_companies   : Any?
    var production_countries    : Any?
    var release_date    :String?
    var revenue   : Int?
    var runtime   : Int?
    var spoken_languages   : [Spoken_Lang]?
    var status   :String?
    var tagline  :String?
    var title    :String?
    var video   : Bool?
    var vote_average  : Int?
    var vote_count   : Int?
    var videos     : [Videos]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
         adult                          <- map["adult"]
         backdrop_path                  <- map["backdrop_path"]
         belongs_to_collection          <- map["belongs_to_collection"]
         budget                         <- map["budget"]
         genres                         <- map["genres"]
         homepage                       <- map["homepage"]
         id                             <- map["id"]
         imdb_id                        <- map["imdb_id"]
         original_language              <- map["original_language"]
         original_title                 <- map["original_title"]
         overview                       <- map["overview"]
         popularity                     <- map["popularity"]
         poster_path                    <- map["poster_path"]
         production_companies           <- map["production_companies"]
         production_countries           <- map["production_countries"]
         release_date                    <- map["release_date"]
         revenue                        <- map["revenue"]
         runtime                        <- map["runtime"]
         spoken_languages               <- map["spoken_languages"]
         status                         <- map["status"]
         tagline                        <- map["tagline"]
         title                          <- map["title"]
         video                          <- map["video"]
         vote_average                   <- map["vote_average"]
         vote_count                     <- map["vote_count"]
         videos                         <- map["videos"]
    }
    
    
}


class Genre : Mappable {
   
    var id   : Int?
    var name  : String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
         id    <- map["id"]
         name  <- map["name"]
    }
    
}


class Videos : Mappable {
 
    
    var id   :String?
    var iso_639_1    :String?
    var iso_3166_1    :String?
    var key   :String?
    var name    :String?
    var site    :String?
    var size    : Int?
    var type    :String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id                           <- map["id"]
         iso_639_1                   <- map["iso_639_1"]
         iso_3166_1                  <- map["iso_3166_1"]
         key                         <- map["key"]
         name                        <- map["name"]
         site                        <- map["site"]
         size                        <- map["size"]
         type                        <- map["type"]
    }
    
    
    
    
}


class Spoken_Lang  : Mappable {
    
    var iso_639_1   :String?
    var name        :String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
         iso_639_1                   <- map["iso_639_1"]
         name                        <- map["name"]
    }
    
    
    
}
    
class Cast  : Mappable {
    
    
    var cast_id   :Int?
    var character :String?
    var credit_id :String?
    var gender :Int?
    var id     :Int?
    var name     :String?
    var order   :Int?
    var profile_path :String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        cast_id              <- map["cast_id"]
        character            <- map["character"]
        credit_id            <- map["credit_id"]
        gender               <- map["gender"]
        id                   <- map["id"]
        name                 <- map["name"]
        order                <- map["order"]
        profile_path         <- map["profile_path"]
    }

}
