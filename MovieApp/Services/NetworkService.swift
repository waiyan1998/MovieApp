//
//  NetworkService.swift
//  MovieApp
//
//  Created by Wai Yan Pyae Sone on 11/10/23.
//

import Foundation
import Alamofire


class NetworkService {
    
   static let shared = NetworkService()
    
    func getUpcomingMovieLists ( page : String , completionHandler: @escaping (_ result: MovieListResponse?, _ error: Error?) -> Void)
    {
        let url = Constants.apiUrl + Constants.Routes.Movie.upcoming
        
    
        
       
            
        let parameters: Parameters = [
            "page": page ,
            "language" : "en-US" ,
            "api_key" : Constants.APIKey
        ]
        print(url)
        
        AF.request(  url , method: .get , parameters: parameters,
                     encoding: URLEncoding(destination: .queryString) ).responseDecodable(of: MovieListResponse.self) { response   in
            //print(response.value)
            
            completionHandler(response.value , response.error)
        }
    }
    
    
    func getPopularMovieLists ( page : String , completionHandler: @escaping (_ result: MovieListResponse?, _ error: Error?) -> Void)
    {
        let url = Constants.apiUrl + Constants.Routes.Movie.popular
            
        let parameters: Parameters = [
            "page": page ,
            "language" : "en-US" ,
            "api_key" : Constants.APIKey
        ]
        print(url)
        
        AF.request(  url , method: .get , parameters: parameters,
                     encoding: URLEncoding(destination: .queryString) ).responseDecodable(of: MovieListResponse.self) { response   in
            //print(response.value)
            
            completionHandler(response.value , response.error)
        }
    }
    
    
    
    
    func getMovieDetail( id : String , completionHandler: @escaping (_ result: DetailResponse?, _ error: Error?) -> Void)
    {
        let url = Constants.apiUrl + Constants.Routes.detail + id 
        
        let parameters : Parameters = [
            "api_key" : Constants.APIKey,
            "append_to_response" : "video",
        ]
        
        print(url)
        
        AF.request(  url , method: .get , parameters : parameters   , encoding: URLEncoding(destination: .queryString) ).responseDecodable(of: DetailResponse.self) { response   in
        print(response)
            
            completionHandler(response.value , response.error)
        }
    }
    
    
    
}

