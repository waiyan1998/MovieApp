//
//  Service.swift
//  Movie
//
//  Created by Wai Yan on 10/20/19.
//  Copyright © 2019 Wai Yan. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper


protocol DetailServiceDelegate : class {
    
    func GettingFinishDetail(videos : [Videos] , s_lang : [Spoken_Lang]? , results : Detail? , genres : String? , error : Error?  )
    func GettingFinishCasts(results : [Cast]? , error : Error?)
    
}



class DetailService  {
    
    var Delegate : DetailServiceDelegate?
    
    
 
    
    func GetDetail( MovieId : Int  )
    {
        let Detail_url : String = "https://api.themoviedb.org/3/movie/" + "\(MovieId)" +  "?api_key=0e11ec4415ce25d5faa6aa39553e27ac&append_to_response=videos"
        //__Alamofire _ request
        print(Detail_url)
//        let queue = DispatchQueue(label: "work" )
//        queue.async {
//         
//        let req = URLRequest(url: URL(string: Detail_url)!)
//        URLSession.shared.dataTask(with: req) { (data , response , error ) in
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
//                let v_json = json["videos"] as! [String :Any]
//                                let viedos_json = v_json["results"] as! [[String :Any]]
//                                let g_json = json["genres"] as! [[String :Any]]
//                                let sl_json = json["spoken_languages"] as! [[String :Any]]
//
//                                let details = Mapper<Detail>().map(JSON: json)
//                                let viedos  = Mapper<Videos>().mapArray(JSONArray: viedos_json)
//                                let s_Lang  = Mapper<Spoken_Lang>().mapArray(JSONArray: sl_json)
//                                let genres  = Mapper<Genre>().mapArray(JSONArray: g_json)
//                                var genre : String = ""
//                                for g in genres
//                                {
//                                    genre = genre + g.name! + ","
//
//                                }
//                                print(genre)
//                                print(s_Lang.count)
//                                print(viedos.count)
//                                print(details?.overview as Any)
//                self.Delegate?.GettingFinishDetail(videos: viedos , s_lang: s_Lang , results: details, genres: genre , error: nil)
//                
//            } catch let error as NSError {
//                print(error)
//            }
//        }.resume()
//            
//        }
      
  
       
        Alamofire.request(Detail_url , method: .get , parameters: nil , encoding: URLEncoding.default , headers: nil)
            .responseJSON { (Data) in
                let json = Data.result.value as! [String :Any]
                let v_json = json["videos"] as! [String :Any]
                let viedos_json = v_json["results"] as! [[String :Any]]
                let g_json = json["genres"] as! [[String :Any]]
                let sl_json = json["spoken_languages"] as? [[String :Any]]

                let details = Mapper<Detail>().map(JSON: json)
                let viedos  = Mapper<Videos>().mapArray(JSONArray: viedos_json)
                let s_Lang  = Mapper<Spoken_Lang>().mapArray(JSONArray: sl_json!)
                let genres  = Mapper<Genre>().mapArray(JSONArray: g_json)
                var genre : String = ""
                for g in genres
                {
                    genre = genre + g.name! + ","

                }
                print(genre)
                print(s_Lang.count)
                print(viedos.count)
                print(details?.overview as Any)

                self.Delegate?.GettingFinishDetail(videos: viedos , s_lang: s_Lang , results: details, genres: genre , error: Data.result.error)


       }
        
    
        
        
    }
    
    
    func GetCasts( MovieId : Int )
    {
        let get_cast_url : String = "https://api.themoviedb.org/3/movie/" + "\(MovieId)" + "/credits?api_key=0e11ec4415ce25d5faa6aa39553e27ac"
        
         //__Alamofire _ request
        
        Alamofire.request(get_cast_url , method: .get , parameters: nil , encoding: URLEncoding.default , headers: nil)
            .responseJSON { (Data) in
                
                    let json = Data.result.value as! [String :Any]
                   let cast_json  = json["cast"] as! [[String : Any]]
                
                   let casts = Mapper<Cast>().mapArray(JSONArray: cast_json  )
                
                   self.Delegate?.GettingFinishCasts(results: casts , error: Data.result.error )
                

                }
        
        //Cast : 
        
    }

    
}
