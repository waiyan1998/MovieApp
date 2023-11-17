

import Foundation

struct Constants {
    static let APIKey = "0e11ec4415ce25d5faa6aa39553e27ac"
    
    static let apiUrl = "https://api.themoviedb.org/3"
    
    struct Routes {
        
        struct Movie {
            static let upcoming = "/movie/upcoming?"
            static let popular = "/movie/popular?"
        }
        static let detail = "/movie/"
        
      
    }
   
    struct ResponseMessage {
        static let success = "Success."
        static let fail = "Failed."
        static let serverError = "Server Error."
        static let error = "Something went wrong."
        
    }
    
    struct DateFormat {
        static let ui_short = "dd MMM yyyy"
        static let ui_long = "dd MMMM yyyy"
        static let apiDate = "dd/MM/yyyy"
    }
    
   
}
