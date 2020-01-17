//
//  NetworkService.swift
//  Movie
//
//  Created by Wai Yan on 10/14/19.
//  Copyright © 2019 Wai Yan. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper


protocol MovieServiceDelegate  : class  {
    
    func DidFinishGettingUpcoming  ( results : [Results]? , error : Error?)
    func DidFinishGettingTop_rated ( results : [Results]? , error : Error?)
    func DidFinishGettingPopular   ( results : [Results]? , error : Error?)
    func DidFinishGettingNow_Playing ( results : [Results]? , error : Error?)
    func DidFinishSearching( results : [Results]? , error : Error?)
    


}

class MovieService {
    
    weak var delegate : MovieServiceDelegate?
     let up_coming_url  : String = "https://api.themoviedb.org/3/movie/upcoming?page=1&language=en-US&api_key=0e11ec4415ce25d5faa6aa39553e27ac"
    let top_rated_url  : String = "https://api.themoviedb.org/3/movie/top_rated?page=1&language=en-US&api_key=0e11ec4415ce25d5faa6aa39553e27ac"
     let popular_url  : String = "https://api.themoviedb.org/3/movie/popular?page=1&language=en-US&api_key=0e11ec4415ce25d5faa6aa39553e27ac"
     let now_playing_url  : String = "https://api.themoviedb.org/3/movie/now_playing?language=en-US&api_key=0e11ec4415ce25d5faa6aa39553e27ac"
    
    
    
    
    func Upcoming () ->Void
    {
        
        Alamofire.request(self.up_coming_url , method: .get , parameters: nil , encoding: URLEncoding.default , headers: nil)
                .responseJSON { (Data) in

                    let json = Data.result.value as! [String :Any]
                   let jsonResult   = json["results"] as! [[String: Any]]
                    
                   let results =  Mapper<Results>().mapArray(JSONArray: jsonResult)
                    
                 self.delegate?.DidFinishGettingUpcoming(results: results , error: Data.result.error)
                    
         }
    }
        
        
  
    
    
    
    func Top_Rated()
    {
       
        Alamofire.request(self.top_rated_url , method: .get , parameters: nil , encoding: URLEncoding.default , headers: nil)
            .responseJSON { (Data) in
                let json = Data.result.value as! [String :Any]
                let jsonResult   = json["results"] as! [[String: Any]]

                let results =  Mapper<Results>().mapArray(JSONArray: jsonResult)
                
                self.delegate?.DidFinishGettingTop_rated(results: results , error: Data.result.error)


              }
        }
    
    
    func Popular()
    {
        
       
        Alamofire.request(self.popular_url , method: .get , parameters: nil , encoding: URLEncoding.default , headers: nil)
            .responseJSON { (Data) in
                let json = Data.result.value as! [String :Any]
                let jsonResult   = json["results"] as! [[String: Any]]
                
                let results =  Mapper<Results>().mapArray(JSONArray: jsonResult)
                
                self.delegate?.DidFinishGettingPopular(results: results , error: Data.result.error)
                
                
        }
    }
    
    func Now_Playing()
    {
        
        Alamofire.request(self.now_playing_url , method: .get , parameters: nil , encoding: URLEncoding.default , headers: nil)
            .responseJSON { (Data) in
                let json = Data.result.value as! [String :Any]
                let jsonResult   = json["results"] as! [[String: Any]]
                
                let results =  Mapper<Results>().mapArray(JSONArray: jsonResult)
                
                self.delegate?.DidFinishGettingNow_Playing(results: results , error: Data.result.error)
                
                
        }
    }
    
    
    
    
    
func Search (keyword : String! )
        
    {
        if (keyword != ""){
            print("Do Alamofire Func")
            let key = keyword.replacingOccurrences(of: " ", with: "%20")
            
        let search_url : String = "https://api.themoviedb.org/3/search/movie?api_key=0e11ec4415ce25d5faa6aa39553e27ac&query=" + key

        Alamofire.request(search_url , method: .get , parameters: nil , encoding: URLEncoding.default , headers: nil)
            .responseJSON { (Data) in
                guard  let e = Data.error else {
                let json = Data.result.value as! [String :Any]
                let jsonResult   = json["results"] as! [[String: Any]]
                let results =  Mapper<Results>().mapArray(JSONArray: jsonResult)
                print(results.count)
                self.delegate?.DidFinishSearching(results: results , error: Data.result.error)
                    return
                }
                print(e)
                
                }

        
               }
        }
    
    
    


}
