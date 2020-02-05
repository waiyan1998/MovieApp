//
//  CollectionView.swift
//  CoinScol
//
//  Created by Wai Yan on 1/15/20.
//  Copyright © 2020 Wai Yan. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView {
    
    let Cellnib = UINib(nibName: "Cell", bundle: nil)
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        super.init(frame: frame, collectionViewLayout: layout)
        self.showsVerticalScrollIndicator = false
        self.register(Cellnib , forCellWithReuseIdentifier: "cell")
        self.backgroundColor = .clear
        
        self.bounces = false
        
//        self.layer.borderWidth = 2
//        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    convenience init ( VC  : ViewController){
        self.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}




extension ViewController : UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88 , height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}



extension ViewController : UICollectionViewDataSource , UICollectionViewDelegate {
    
    
    
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       
        if (self.searchContoller.isActive != true && self.SearchTF.text == "" )
        {
        switch collectionView.tag {
        case  0 : if (Upcoming.count != 0 )
        { return   Upcoming.count }else{ print("nilColViNo_0"); return 0}
         case  1 :  if (TopRated.count  != 0  )
         {  return TopRated.count   }else{ print("nilColViNo_1"); return 0}
        case  2 :if (Now_Playin.count  != 0  )
        {  return Now_Playin.count }else{print("nilColViNo_2"); return 0}
        case  3 :if (Popular.count  != 0  )
        {   return Popular.count }else {print("nilColViNo_3"); return 0}
        default:
            return 0

            }
        }else
        {
          return SeResults.count
        }

  //return 0
  
    }
        
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell" , for: indexPath)
        
        configureCell(cell)
        
        if ( SearchTF.text == "")
        {
        switch collectionView.tag {
            
        case 0 :  DataShow(cell, Upcoming , indexPath)
            
            
        case 1 : DataShow(cell, TopRated  , indexPath)
            
            
        case 2 :  DataShow(cell, Now_Playin , indexPath)
            
            
        case 3 : DataShow(cell, Popular , indexPath)
  
            
        default:
            
            print("default")
            
                 }

           }else{

            DataShow(cell , SeResults , indexPath)

            }

            
            return cell
        }
        
    
        
    
        
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//       print("Clicked")
//       print(indexPath.row)
//
////        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
////        let D_ViewController = storyBoard.instantiateViewController(withIdentifier: "detail") as! DetailViewController
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        print(cell.tag)
//
//        self.searchContoller.isActive = false
//        self.searchContoller.definesPresentationContext = true
//        self.performSegue(withIdentifier: "detail", sender: (Any).self)
//
//
//////        if(SearchTF.text == "")
//////        {
////        switch PageIndex {
////        case 0 : D_ViewController.id_to_DVC(id: Upcoming[indexPath.row].id! )
////        case 1 : D_ViewController.id_to_DVC(id: TopRated[indexPath.row].id! )
////        case 2 : D_ViewController.id_to_DVC(id: Now_Playin[indexPath.row].id! )
////        case 3 : D_ViewController.id_to_DVC(id: Popular[indexPath.row].id! )
////        default:
////            print("DID SELECTED IN COLVIEW CELL")
//////        }
//////        }else{
//////            D_ViewController.id_to_DVC(id: SeResults[indexPath.row].id!)
//////        }
//
//        print(" i touch cell")
//    }
//
   
    
    func configureCell(_ cell: UICollectionViewCell)
       {
            let imageView = cell.viewWithTag(1) as! UIImageView
            imageView.layer.cornerRadius = 10
        
            let TapGuesture = UITapGestureRecognizer()
                TapGuesture.addTarget(self, action: #selector(Tap(sender:)))
        
                cell.addGestureRecognizer(TapGuesture)
        
            print("ConfigCell")
        
        
        }
        
    @objc func Tap( sender : UITapGestureRecognizer )
    {
        print(sender.view?.tag as Any)
        print("Clicked")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let D_ViewController = storyBoard.instantiateViewController(withIdentifier: "detail") as! DetailViewController
        
      self.searchContoller.isActive = false
        
        D_ViewController.IdtoDVC(id: sender.view!.tag , VC : self )
        
     self.present(D_ViewController, animated: true , completion: nil)
     
    }
    
    
        
     func DataShow(_ cell : UICollectionViewCell , _ Data : [Results]? , _ IndexPath : IndexPath)
       {
        
                let ImageView  = cell.viewWithTag(1) as! UIImageView
                cell.tag = Data![IndexPath.row].id!
       
                if (Data![IndexPath.row].poster_path != nil )
                {
                    let url = URL(string: "https://image.tmdb.org/t/p/w500/" +  Data![IndexPath.row].poster_path! )
                    ImageView.kf.setImage(with: url)
                }else{
                    ImageView.image = UIImage(named : "not.jpg")
                }
                ImageView.layer.cornerRadius = 10
                
                let titleLabel = cell.viewWithTag(2) as! UILabel
                titleLabel.text =  Data![IndexPath.row].original_title ?? " "
                
            }
    
    
    
  
}






