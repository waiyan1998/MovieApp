//
//  ViewController.swift
//  Movie
//
//  Created by Wai Yan on 10/14/19.
//  Copyright © 2019 Wai Yan. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher

class ViewController : UIViewController, MovieServiceDelegate {
 
    
    
    
   
    
   
    @IBOutlet weak var SearchTF: UISearchBar!
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    var PageIndex : Int = 0
    var Indicator :  UIView = {
        var ind = UIView()
        ind.backgroundColor = UIColor(red: 0 , green: 100 / 255, blue: 1.0 , alpha: 1.0)
        ind.layer.cornerRadius = 3
        return ind
    }()
    
    
    
    var Upcoming   = [Results]()
    var TopRated   = [Results]()
    var Now_Playin = [Results]()
    var Popular    = [Results]()
    var SeResults  = [Results]()
    
    
    var NetworkService = MovieService()
    
    var ColViews    = [CollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()) ,                         CollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()) ,
                       CollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()) ,
                       CollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()) ]
    
    var Menubar     = [ UIButton () , UIButton (), UIButton() , UIButton() ]
    
    var MenuTitle   = ["UpComing","TopRated","Nowplaying","Popular"]
    
    
    @IBOutlet weak var TitleLabel: UILabel!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.SearchTF.delegate = self
        self.NetworkService.delegate = self
        self.NetworkService.Upcoming()
        self.NetworkService.Top_Rated()
        self.NetworkService.Now_Playing()
        self.NetworkService.Popular()
        self.Setup()
        
        
   
    }
    
   
    
    func DidFinishGettingUpcoming(results: [Results]?, error: Error?) {
        print("Up")
        
        guard let e = error else {
            self.Upcoming = results!
         ColViews[0].reloadData()
            
            return
        }
        print(e)
        
    }
    
    
    func DidFinishGettingNow_Playing(results: [Results]?, error: Error?) {
        print("Now_pla")
        guard let e = error else {
            self.Now_Playin  = results!
            ColViews[1].reloadData()
            
            return
        }
        print(e)
    }
    
    func DidFinishGettingTop_rated(results: [Results]?, error: Error?) {
         print("Toprated")
        guard let e = error else {
            self.TopRated = results!
             ColViews[2].reloadData()
            
            return
        }
        print(e)
    }
    
    func DidFinishGettingPopular(results: [Results]?, error: Error?) {
        print("Popular")
        guard let e = error else {
            self.Popular = results!
             ColViews[3].reloadData()
           
            return
        }
        print(e)
        
    }



    func DidFinishSearching(results: [Results]?, error: Error?) {
        self.SeResults.removeAll()
        print("Did Searching do")
        guard let e = error else {
            self.SeResults = results!
            
            switch PageIndex {
            case 0: ColViews[0].reloadData()
            case 1: ColViews[1].reloadData()
            case 2: ColViews[2].reloadData()
            case 3: ColViews[3].reloadData()
            default:
                print("Default")
            }
            return
        }
        print(e)
    }
    
    
    
   
   
//       if (self.results[indexPath.row].poster_path != nil )
//
//       {
//        let url = URL(string: "https://image.tmdb.org/t/p/w500/" +  self.results[indexPath.row].poster_path! )
//        print(url)
//        cell.image.kf.setImage(with: url)
//
//       }else{
//        print( "ELSE DO")
//        cell.image.image = UIImage(named : "not.jpg")
//        }
//        cell.image.tag   = indexPath.row
//
    //        cell.label.text = self.results[indexPath.row].original_title }
    
    
//    @IBAction func Click(_ sender: UIButton) {
//
//        switch sender.tag {
//        case 1  :  self.NetworkService.Upcoming(); break ;
//        case 3  :  self.NetworkService.Top_Rated() ;break  ;
//        case 4  :  self.NetworkService.Now_Playing();break ;
//        case 5  :  self.NetworkService.Popular() ;break ;
//
//        default : print( "error")
//        }
//        
//        self.setup()
//        sender.setTitleColor(UIColor.white, for: .normal)
//        sender.backgroundColor = UIColor(red: 5 / 255, green: 122 / 255 , blue: 251 / 255 , alpha: 1.0)
//        sender.layer.shadowColor = UIColor.black.cgColor
//        sender.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        sender.layer.shadowOpacity = 0.5
//    }
//
    
    
//    @IBAction func Search_Click(_ sender: UIButton) {
//
//
//        if ( self.SearchText_F.alpha == 0.0)
//        {
//
//
//            self.SearchText_F.frame.size.width = 400
//            self.SearchText_F.isUserInteractionEnabled   = true
//            self.SearchText_F.alpha = 1.0
//            self.SearchText_F.placeholder   = "Search Movies"
//            self.SearchText_F.becomeFirstResponder()
//
//        }else{
//            self.NetworkService.Search(keyword: self.SearchText_F.text)
//            self.TitleLabel.text  = "  results for '" + SearchText_F.text! + "'"
//            self.setup()
//        }
//

  
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//        self.SearchText_F.text = ""
//        self.SearchText_F.alpha = 0.0
//        self.SearchText_F.frame.size.width = 0
//
//    }
    
    @objc func MenuClick(_ sender: UIButton)
        
    {
        switch sender.tag  {
            
        case 0 :
            
            self.ScrollView.contentOffset.x  = 0
            self.Indicator.frame.origin.x    =  (sender.frame.origin.x + 20)
            
        case 1 :
            self.ScrollView.contentOffset.x  = CGFloat( 1 * ScrollView.frame.size.width )
            
        case 2 :
            self.ScrollView.contentOffset.x  = CGFloat( 2 * ScrollView.frame.size.width )
            
        case 3 :
            self.ScrollView.contentOffset.x  = CGFloat( 3 * ScrollView.frame.size.width )
         
            
        default:
            print("do'nt")
        }
    
        
        
    }
  


    func Setup()
    {
        print("zzz")
        
        var i  : CGFloat = 0
        self.TitleLabel.text = "  UpComing"
        self.Indicator.frame.origin  = CGPoint(x: 20 , y: 160)
        self.Indicator.frame.size   = CGSize(width: (self.view.frame.width / 4) - 40  , height: 3)
        self.ScrollView.contentSize.width = self.view.frame.width * 4
        self.view.addSubview(Indicator)
        
        for n in 0...Menubar.count - 1 {
            
            Menubar[n].setTitleColor(.lightGray, for: .normal)
            Menubar[n].setTitle(MenuTitle[n], for: .normal)
            Menubar[n].titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
            Menubar[n].addTarget(self , action: #selector(MenuClick(_:)), for: .touchUpInside)
            Menubar[n].frame.origin.x = CGFloat(n) * (self.view.frame.size.width / 4 )
            Menubar[n].frame.origin.y = 135
            Menubar[n].frame.size = CGSize(width: self.view.frame.size.width / 4 , height: 25)
            Menubar[n].tag = n
            self.view.addSubview(Menubar[n])
        }
        Menubar[0].setTitleColor(self.Indicator.backgroundColor, for: .normal)
        
        for ColView in ColViews{
            
            
            ColView.frame = CGRect(x: ( i * self.view.frame.size.width )   , y: 0, width: self.view.frame.size.width - 10 , height: self.ScrollView.frame.height )
            ColView.delegate = self
            ColView.dataSource = self
            ColView.tag = Int(i)
            
            self.ScrollView.addSubview(ColView)
            
            i = i + 1 ;
            
        }
        
        
     }
    
    
    func Closed() {
        self.ScrollView.isScrollEnabled = false
        self.Indicator.alpha = 0.0
        for b in Menubar {
            b.alpha = 0.0
            
            
        }
    }

}

extension ViewController : UIScrollViewDelegate

{
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if ( scrollView.contentOffset.x  > 0 )
        {
            self.Indicator.frame.origin.x = (scrollView.contentOffset.x / 4 ) + 20
            print(scrollView.contentOffset.x )
        }
        
        self.PageIndex = Int(ScrollView.contentOffset.x / ScrollView.frame.size.width)
        
        for MenuBtn in Menubar
        {
            MenuBtn.setTitleColor(.lightGray, for: .normal)
            if ( PageIndex == MenuBtn.tag){
                
                MenuBtn.setTitleColor(Indicator.backgroundColor, for: .normal)
                self.TitleLabel.text = "  " + MenuTitle[PageIndex]
            }
            
        }
        
        print(PageIndex)
        print(ScrollView.frame.origin.y)
    
    
    
}
}



extension ViewController : UISearchBarDelegate {
    
    
   
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        if (SearchTF.text != "") {
            self.NetworkService.Search(keyword: self.SearchTF.text)
            
            Closed()
            self.TitleLabel.text = " results of'" + SearchTF.text! + "'"
      
            self.SearchTF.resignFirstResponder()
        }
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.SearchTF.showsCancelButton = true
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.SearchTF.text = ""
        self.TitleLabel.text = "  " + MenuTitle[PageIndex]
        self.Indicator.alpha = 0.0
        self.ScrollView.isScrollEnabled = true
        for b in Menubar {
            b.alpha = 1.0
            
        }
        for V in ColViews  {
            
            V.reloadData()
        }
        self.SearchTF.showsCancelButton = false
        self.SearchTF.resignFirstResponder()
        
    }
    
    
    
    
}



