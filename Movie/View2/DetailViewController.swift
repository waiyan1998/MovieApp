//
//  DetailViewController.swift
//  Movie
//
//  Created by Wai Yan on 10/20/19.
//  Copyright © 2019 Wai Yan. All rights reserved.
//

import UIKit
import Kingfisher
import MediaPlayer
import WebKit






class DetailViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,DetailServiceDelegate,WKNavigationDelegate {
    
    
   
    

    
   
    
    
   
    @IBOutlet weak var BG_ImageView: UIImageView!
    @IBOutlet weak var Poster_ImageView: UIImageView!
    @IBOutlet weak var Title_Name_Label: UILabel!
    @IBOutlet weak var Genres_Label: UILabel!
    @IBOutlet weak var Spoken_Lang_Label: UILabel!
    @IBOutlet weak var Overview_TextView: UITextView!
    @IBOutlet weak var Duration_Label: UILabel!
    @IBOutlet weak var Buget_Label: UILabel!
    @IBOutlet weak var Released_Date_Label: UILabel!
    @IBOutlet weak var Trailer_Name__Label: UILabel!
    @IBOutlet weak var Container_ofViedoView: UIView!
    @IBOutlet weak var Credits_ColView: UICollectionView!
    var D_Service = DetailService()
    var casts = [Cast]()
    var VC : ViewController!
    
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        
        self.Poster_ImageView.layer.borderWidth = 1
        self.Poster_ImageView.layer.borderColor = UIColor.white.cgColor
        
        self.D_Service.Delegate = self
       
        
        
        // Do any additional setup after loading the view.
    }
    
   
    
    
    func IdtoDVC (id : Int , VC : ViewController ){
     self.VC = VC
     self.D_Service.GetDetail(MovieId: id )
     self.D_Service.GetCasts(MovieId: id )
    }
    
    

    @IBAction func Cancel_Click(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
        self.VC.SearchTF.text  = self.VC.navigationItem.title
        
        
        
    }
    
    
    
   
    
   func GettingFinishDetail(videos: [Videos], s_lang: [Spoken_Lang]?, results: Detail?, genres: String?, error: Error?) {
        
        print("getting Detail Finsh Func ")
        
        
        guard let e = error else {
            
            if (results != nil)
            {
                
            if (results?.backdrop_path != nil){
            let bg_url   = URL(string: "https://image.tmdb.org/t/p/w500/" +  results!.backdrop_path! )
                self.BG_ImageView.kf.setImage(with: bg_url) }
            
            if (results?.poster_path != nil ){
            let ps_url  =  URL(string: "https://image.tmdb.org/t/p/w500/" + results!.poster_path!)
            self.Poster_ImageView.kf.setImage(with: ps_url)
            }
            
            if (videos.last?.key != nil) {
            let url = URL(string: "https://www.youtube.com/embed/" + videos.last!.key!)
            Show_Viedo(url: url!)
            }

            self.Title_Name_Label.text  = "  " + results!.title!
            self.Overview_TextView.text = results?.overview
            self.Genres_Label.text = "  " + genres!
            self.Spoken_Lang_Label.text = s_lang?.last?.name
                if (results?.runtime != nil)
                { self.Duration_Label.text    = (results?.runtime!.description)! + " mins" }
            self.Released_Date_Label.text = results?.release_date
            self.Buget_Label.text         = "\(results!.budget! / 1000000)" + "M"
            self.Trailer_Name__Label.text = videos.last?.name

            }
            
            return
        }
        
        print(e)
    
    }
    
    
    func GettingFinishCasts(results: [Cast]?, error: Error?) {
         self.casts.removeAll()
         guard let e = error else {
            self.casts = results!
            self.Credits_ColView.reloadData()
            return
        }
        print(e)
        
    }
    
    
    
   
    func Show_Viedo(url: URL) {
        
        
        DispatchQueue.main.async {
        let myURLRequest:URLRequest = URLRequest(url:url)
        let WebView  = WKWebView(frame: CGRect(x:0, y:0, width: self.Container_ofViedoView.frame.width , height:self.Container_ofViedoView.frame.height))
            self.Container_ofViedoView.addSubview(WebView)
            WebView.navigationDelegate = self
            WebView.load(myURLRequest)
            WebView.allowsBackForwardNavigationGestures = true
        }
    
        
      
        
        
    }
   
    

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cast" , for: indexPath) as! Cast_Cell
            cell.InMovie_Name.text = self.casts[indexPath.row].character
            cell.Cast_Name.text    = self.casts[indexPath.row].name
        if (self.casts[indexPath.row].profile_path != nil)
        { let cast_image_url = URL(string:  "https://image.tmdb.org/t/p/w500/" + self.casts[indexPath.row].profile_path!)
            cell.Cast_ImageView.kf.setImage(with: cast_image_url)
        }else{
            cell.Cast_ImageView.image = UIImage(named: "not.jpg")
        }
        return cell
    }

    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
