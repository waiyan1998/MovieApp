//
//  ViewController.swift
//  MovieApp
//
//  Created by Wai Yan Pyae Sone on 11/10/23.
//

import UIKit


class MovieListViewController : BaseViewController {
    
    var page_count = 1
    {
        didSet {
            self.collectionView.reloadData()
        }
    }

    var movielist = [Movie]()
    {
        didSet {
            self.MoviecollectionView.reloadData()
        }
    }
   
    
    
    @IBOutlet weak var segment : UISegmentedControl!
    
    @IBOutlet weak var collectionView : UICollectionView!
    {
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.registerForCell(strID: PageNoCell.nibName)
        }
    }
    
    @IBOutlet weak var MoviecollectionView : UICollectionView!
    {
        didSet{
            MoviecollectionView.delegate = self
            MoviecollectionView.dataSource = self
            MoviecollectionView.registerForCell(strID: MovieCell.nibName)
        }
    }
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
            switch segment.selectedSegmentIndex {
                
            case 0 :
                UpComingDataRequest("\(self.page_count)")
                
            case 1 :
                PopularRequestData("\(self.page_count)")
                
            default : break
                
            }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
    }
    
    
    @IBAction func SegChange(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0 :  self.page_count = 1
            UpComingDataRequest("\(self.page_count)")
            
        case 1 :  self.page_count = 1
            PopularRequestData("\(self.page_count)")
            
        default : break
            
        }
        
        
    }
    
    
    
    
    func UpComingDataRequest(_ page : String )
    {
        self.showLoading()
        NetworkService.shared.getUpcomingMovieLists(page: page) {  [weak self] response , error in
            self?.hideLoading()
            
            
            guard let results  = response?.results else {
                return
            }
            if self?.page_count == 1 {
                
                self?.page_count = response?.total_results ??  0
                self?.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .bottom)
                
            }
            self?.movielist = results
           
        }
        
        
    }
    
    func PopularRequestData(_ page : String )
    {
        self.showLoading()
        NetworkService.shared.getUpcomingMovieLists(page: page) {  [weak self] response , error in
            self?.hideLoading()
            
            
            guard let results  = response?.results else {
                return
            }
            if self?.page_count == 1 {
                
                self?.page_count = response?.total_results ??  0
                self?.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .bottom)
                
            }
            self?.movielist = results
          
            
        }
        
        
    }


}



extension MovieListViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView == MoviecollectionView {
            return movielist.count
        }else{
           
            return self.page_count
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == MoviecollectionView {
            
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
                cell.TitleLabel.text =   self.movielist[indexPath.row].original_title
            cell.ImageView.setImage( ("https://image.tmdb.org/t/p/w500" + (self.movielist[indexPath.row].poster_path ?? "") ))
            
            return cell
        }else{
          
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: PageNoCell.identifier, for: indexPath) as! PageNoCell
            cell.TitleLabel.text =  "\(indexPath.row + 1)"
             return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionView
        {
            switch segment.selectedSegmentIndex {
                
            case 0 :
                UpComingDataRequest("\(indexPath.row + 1 )")
                
            case 1 :  
                PopularRequestData("\(indexPath.row + 1)")
                
            default : break
                
            }
        }else{
            
            let vc = DetailViewController.initiate(appStoryBoard: .Detail)
                vc.id = String(self.movielist[indexPath.row].id ?? 1)
            let navi_VC = UINavigationController(rootViewController: vc)
            self.showDetailViewController(navi_VC , sender: nil)
        }
      
    }
    
}



