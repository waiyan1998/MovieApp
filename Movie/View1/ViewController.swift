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
    

    
    var SearchTF : UISearchBar!
    let searchContoller =   UISearchController (searchResultsController: nil)
    
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
    
    
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
   
        self.NetworkService.delegate = self
        self.NetworkService.Upcoming()
        self.NetworkService.Top_Rated()
        self.NetworkService.Now_Playing()
        self.NetworkService.Popular()
        self.Setup()
       
        
   
    }
    
   
    
    func DidFinishGettingUpcoming(results: [Results]?, error: Error?) {
        print("Up")
        self.Upcoming.removeAll()
        guard let e = error else {
            self.Upcoming = results!
         ColViews[0].reloadData()
            
            return
        }
        print(e)
        
    }
    
    
    func DidFinishGettingNow_Playing(results: [Results]?, error: Error?) {
        self.Now_Playin.removeAll()
        print("Now_pla")
        guard let e = error else {
            self.Now_Playin  = results!
            ColViews[1].reloadData()
            
            return
        }
        print(e)
    }
    
    func DidFinishGettingTop_rated(results: [Results]?, error: Error?) {
        self.TopRated.removeAll()
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
        self.Popular.removeAll()
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
    
    func DidCatchingConnectionFailure(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    

    
    @objc func MenuClick(_ sender: UIButton)
        
    {
        self.ColViews[sender.tag].reloadData()
        
        switch sender.tag  {
            
        case 0 :
            
            UIView.animate(withDuration: 0.3) {
                self.ScrollView.contentOffset.x  = 0
                self.Indicator.frame.origin.x    =  (sender.frame.origin.x + 20)
            }
            
            
        case 1 :UIView.animate(withDuration: 0.3) {
            self.ScrollView.contentOffset.x  = CGFloat( 1 * self.ScrollView.frame.size.width ) }
            
        case 2 :UIView.animate(withDuration: 0.3) {
            self.ScrollView.contentOffset.x  = CGFloat( 2 * self.ScrollView.frame.size.width ) }
            
        case 3 :UIView.animate(withDuration: 0.3) {
            self.ScrollView.contentOffset.x  = CGFloat( 3 * self.ScrollView.frame.size.width ) }
         
            
        default:
            print("do'nt")
        }
    
        
        
    }
  


    func Setup()
    {
        print("zzz")
        
        var i  : CGFloat = 0
        self.navigationItem.title = "UpComing"
        
        
        self.SearchTF = searchContoller.searchBar
        self.SearchTF.delegate   = self
        searchContoller.searchResultsUpdater = self
        
        self.searchContoller.searchBar.searchBarStyle = .minimal
        self.searchContoller.hidesNavigationBarDuringPresentation = true
        self.searchContoller.obscuresBackgroundDuringPresentation = false
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController    = searchContoller
        //self.navigationController?.navigationBar.set
        self.navigationController?.definesPresentationContext = true
        self.Indicator.frame.origin  = CGPoint(x: 20 , y: 45)
        self.Indicator.frame.size   = CGSize(width: (self.view.frame.width / 4) - 40  , height: 3)
        self.ScrollView.contentSize.width = self.view.frame.width * 4
        self.view.addSubview(Indicator)
        
      
        for n in 0...Menubar.count - 1 {
            
            Menubar[n].setTitleColor(.lightGray, for: .normal)
            Menubar[n].setTitle(MenuTitle[n], for: .normal)
            Menubar[n].titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
            Menubar[n].addTarget(self , action: #selector(MenuClick(_:)), for: .touchUpInside)
            Menubar[n].frame.origin.x = CGFloat(n) * (self.view.frame.size.width / 4 )
            Menubar[n].frame.origin.y = 20
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
    
    
    func RefreshUI() {
        
        self.navigationItem.title =  MenuTitle [self.PageIndex]
        for i in Menubar{
            i.alpha = 1.0
        }
        self.Indicator.alpha = 1.0
        for i in ColViews
        {
            i.reloadData()
        }
        
        
        
        
        
    }
    

}

extension ViewController : UIScrollViewDelegate

{

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.PageIndex = Int(ScrollView.contentOffset.x / ScrollView.frame.size.width)
        //self.ColViews[PageIndex].reloadData()
        
        if ( scrollView.contentOffset.x  > 0 )
        {
            self.Indicator.frame.origin.x = (scrollView.contentOffset.x / 4 ) + 20
            print(scrollView.contentOffset.x )
            self.navigationItem.title = MenuTitle[PageIndex]
        }
        
        
        
        for MenuBtn in Menubar
        {
            MenuBtn.setTitleColor(.lightGray, for: .normal)
            if ( PageIndex == MenuBtn.tag){
                
                MenuBtn.setTitleColor(Indicator.backgroundColor, for: .normal)
                
            }
            
        }
        
        print(PageIndex)
        print(ScrollView.frame.origin.y)
    
    
    
}
}


extension ViewController :  UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
//        self.searchContoller.obscuresBackgroundDuringPresentation    = false
        self.SeResults.removeAll()
         for c in ColViews
         {
            c.reloadData()

         }
        //searchContoller.obscuresBackgroundDuringPresentation = false
        
        
        
    }
    
    
    
    
}



extension ViewController : UISearchBarDelegate ,UISearchControllerDelegate {
    

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        

       
        
        if (SearchTF.text != "") {
            print("Search do ")
            self.NetworkService.Search(keyword: self.SearchTF.text)
            
            Closed()
            
            self.navigationItem.title = " results of '" + SearchTF.text! + "'"
//
        }
        
    }
    
 
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.navigationItem.title =  MenuTitle[PageIndex]
        self.Indicator.alpha = 1.0
        self.ScrollView.isScrollEnabled = true
        for b in Menubar {
            b.alpha = 1.0
            
        }
        for V in ColViews  {
            
            V.reloadData()
        }
//        self.SearchTF.showsCancelButton = false
//        self.SearchTF.resignFirstResponder()
        
    }
    
    
    
    
}




