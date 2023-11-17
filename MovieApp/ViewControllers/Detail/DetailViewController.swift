//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Wai Yan Pyae Sone on 11/12/23.
//

import UIKit

class DetailViewController: BaseViewController {
    @IBOutlet weak var CollectionView : UICollectionView! {
        didSet{
            CollectionView.delegate = self
            CollectionView.dataSource = self
            CollectionView.registerForCell(strID: OverviewCell.nibName)
            CollectionView.registerForCell(strID: HeaderViewCell.nibName)
            CollectionView.registerForCell(strID: GenreCell.nibName)
            let layout = CollectionView.collectionViewLayout as? AlignedCollectionViewFlowLayout
                layout?.horizontalAlignment = .left
            
            
        }
    }
    
    var id : String = ""
    var genres = [Genre]()
    {
        didSet{
            self.CollectionView.reloadData()
        }
    }
    var detail : DetailResponse?
    {
        didSet{
            self.CollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(id)
        self.DataRequest()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addBackButton()
       
    }
    
    
    fileprivate func addBackButton ()
    {
        let btn = UIBarButtonItem(image: UIImage(named: "icon-x"), style: .done, target: self, action: #selector(self.BackAction(_:)))
        self.navigationItem.setLeftBarButton(btn, animated: true)
    }
    
    @objc func BackAction (_ sender : UIButton)
    {
        self.dismiss(animated: true)
    }
    
    
    fileprivate func DataRequest()
    {
        self.showLoading()
        NetworkService.shared.getMovieDetail(id: id) { response , error in
            self.hideLoading()
            print(response)
            guard let genres = response?.genres else {
                return
            }
            
            self.genres = genres
            self.detail = response
           
        }
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
extension DetailViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3 
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 1 : return genres.count
            default :  return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            case 0 :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderViewCell.identifier, for: indexPath) as! HeaderViewCell
                    cell.BackPosterImageView.setImage( "https://image.tmdb.org/t/p/w500" + (detail?.backdropPath ?? "" ) )
                    cell.PosterImageView.setImage( "https://image.tmdb.org/t/p/w500" + (detail?.posterPath ?? "" ))
                return cell
            case 1 :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as! GenreCell
                    cell.Label.text = genres[indexPath.row].name
            
                return cell
            case 2 :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OverviewCell.identifier, for: indexPath) as! OverviewCell
                    cell.TextView.text = detail?.overview ?? ""
                return cell
            
            default :  return UICollectionViewCell()
        }
    }
    
    
}
