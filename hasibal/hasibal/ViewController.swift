//
//  ViewController.swift
//  hasibal
//
//  Created by cscoi045 on 2017. 2. 7..
//  Copyright © 2017년 test. All rights reserved.
//

import UIKit
import Photos

//let albumName = "나무"
class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
 
    
    var imageArray = [UIImage]()
    var imageArray2 = [UIImage]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.collectionView?.allowsMultipleSelection = true
        grabPhotos()

    }
    
    func grabPhotos(){
        
        let imgManager = PHImageManager.default()

        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
    
//        let assetCollectionRO = PHFetchOptions()
//        assetCollectionRO.predicate = NSPredicate(format: "title = %@", albumName)
//        
//        let assetcollection : PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: assetCollectionRO)
//        print("\(assetcollection.count)")

        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        if let fetchResult :PHFetchResult = PHAsset.fetchAssets(with: .image , options: fetchOptions) {
        
            if fetchResult.countOfAssets(with: PHAssetMediaType.image) > 0 {
                
                for i in 0..<fetchResult.count{
                    
                    imgManager.requestImage(for: fetchResult.object(at: i) as! PHAsset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOptions, resultHandler: {image, Error in
                    self.imageArray.append(image!)
                    print("Succeesssss")
                    })
                    
                }
                
                
                
            }else{print("you got no Photos")
            self.collectionView?.reloadData()
            }
            
            
            
            
        }
    }
    
        override func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
            //return 10
            return imageArray.count
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        
       cell.imgVu.image = imageArray[indexPath.row]
        //cell.backgroundColor = UIColor.blue
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
            
            let width = collectionView.frame.width / 5 - 1
            
            return CGSize(width: width , height: width)
            }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 1.0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 1.0
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! as String == "viewLargePhoto" {
            
            let controller : ViewPhoto = segue.destination as! ViewPhoto
            let indexpath = self.collectionView?.indexPath(for: sender as! UICollectionViewCell)
            controller.index = indexpath!.item
//            controller.photosAsset = self.
//            controller.assetCollection = self.assetCollection
            controller.imageBoo = imageArray[controller.index]
        }
    }




}
