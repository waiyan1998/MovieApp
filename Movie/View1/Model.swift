//
//  Model.swift
//  Movie
//
//  Created by Wai Yan on 10/14/19.
//  Copyright © 2019 Wai Yan. All rights reserved.
//

import Foundation
import ObjectMapper




class Results  : Mappable{
    
    required init?(map: Map) {
        
    }
    var id  : Int?
    var adult : Bool!
    var backdrop_path :String?
    var original_language : String!
    var original_title : String?
    var overview : String!
    var popularity : Double!
    var poster_path : String?
    var release_date : String!
    var genre_ids : G_id?
    var video  : Bool?
    var vote_average : Double!
    var vote_count : Int!
    
    
    func mapping(map: Map) {
          id                  <- map["id"]
         adult                <- map["adult"]
         backdrop_path        <- map["backdrop_path"]
         original_language    <- map["original_language"]
         original_title       <- map["original_title"]
         overview             <- map["overview"]
         popularity           <- map["popularity"]
         poster_path          <- map["poster_path"]
         release_date         <- map["release_date"]
         genre_ids            <- map["genre_ids"]
         video                <- map["video"]
         vote_average         <- map["vote_average"]
         vote_count           <- map["vote_count"]
    }
    
}



class G_id: Mappable {
    var title : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        title                <- map["title"]
    }
    
    
}



    class Dates : Mappable {
        
        var minimun : String?
        var maximum : String?
        
        required init?(map: Map) {
            
        }
        func mapping(map: Map) {
            
            minimun                <- map["minimun"]
            maximum                <- map["maximum"]
        }
        
    }

 
    class Up_Coming : Mappable {
        
    
        var results : Results?
        var page : Int!
        var total_results : Int!
        var total_page : Int!
        var dates : Dates?
        
        
        required init? (map: Map) {
            
        }
        
        func mapping(map: Map) {
            dates             <- map["dates"]
            page              <- map["page"]
            total_results     <- map["total_results"]
            total_page        <- map["total_page"]
            results           <- map["results"]
        }
        
        
        
        
        
        
        
    }








    
    
    

