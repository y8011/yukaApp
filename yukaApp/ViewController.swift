//
//  ViewController.swift
//  yukaApp
//
//  Created by yuka on 13/11/2017.
//  Copyright © 2017 yuka. All rights reserved.
//

import UIKit
import Photos  //?
import MobileCoreServices //?
//import CalculatorKeyboard


//class ViewController: UIViewController,UIImagePickerControllerDelegate, CalculatorDelegate {
class ViewController: UIViewController,UIImagePickerControllerDelegate, UICollectionViewDataSource, UINavigationControllerDelegate {

    @IBOutlet weak var displayImageView: UIImageView!
    
    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
//        let frame = CGRect(x:0 , y:0 , width: UIScreen.main.bounds.width, height:300 )
//        let keyboard = CalculatorKeyboard(frame: frame)
//        keyboard.delegate = self
//        keyboard.showDecimal = true
//        inputText.inputView = keyboard

        // MARK: - UICollectionViewDataSource
        myCollectionView.dataSource = self
        displayImageView.isUserInteractionEnabled = true  // Gestureの許可

        ///////////////////////////////試し中
        var assetss:PHFetchResult = PHAsset.fetchAssets(with: .image, options: nil)
        print(assetss.debugDescription);
        assetss.enumerateObjects({ ( obj , idx , stop) in
            
            if obj is PHAsset
            {
                let asset:PHAsset = obj as PHAsset;
                print("FetchResult count:\(assetss.count)")
                print("Asset IDX:\(idx)");
                print("mediaType:\(asset.mediaType)");
                print("mediaSubtypes:\(asset.mediaSubtypes)");
                print("pixelWidth:\(asset.pixelWidth)");
                print("pixelHeight:\(asset.pixelHeight)");
                print("creationDate:\(asset.creationDate)");
                print("modificationDate:\(asset.modificationDate)");
                print("duration:\(asset.duration)");
                print("favorite:\(asset.isFavorite)");
                print("hidden:\(asset.isHidden)");
                print("location:\(asset.location)")
                
                let phImageManager:PHImageManager = PHImageManager()
                phImageManager.requestImage(for: asset, targetSize: CGSize(width: 320,height:320), contentMode: .aspectFill, options: nil, resultHandler: {
                        ( image , info)  in
                        self.displayImageView.image = image as? UIImage
                    
                })
            }
            
        });
            
            
            
            ////////画像の一番最後が表示された。最後だけやる方法ないかな？？/////////////////////
        
        
        
    }
    

//    func calculator(_ calculator: CalculatorKeyboard, didChangeValue value: String) {
//            inputText.text = value
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "cellta", for: indexPath)
        
        cell.backgroundColor = UIColor.blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func display() {
        //UserDefaultから取り出す
        //ユーザデフォルトを用意する
        
        let myDefault = UserDefaults.standard
        
        //データを取り出す
        let strURL = myDefault.string(forKey: "selectedPhotoURL")
    }
    
    
//    func showCamera() {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
//            let picker = UIImagePickerController()
//            picker.modalPresentationStyle = UIModalPresentationStyle.popover
//            picker.delegate = self
//            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
//
//            if let popover = picker.popoverPresentationController {
//                popover.sourceView = self.view
//                popover.sourceRect = displayImageView.frame
//                popover.permittedArrowDirections = UIPopoverArrowDirection.any
//            }
//            self.present(picker, animated: true, completion: nil)
//        }
//    }

    
//    func showAlbum(){
//        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.photoLibrary
//
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
//            //インスタンスの作成
//            let cameraPicker = UIImagePickerController()
//            cameraPicker.sourceType = sourceType
//            cameraPicker.delegate = self
//            self.present(cameraPicker, animated: true, completion:  nil)
//
//
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

