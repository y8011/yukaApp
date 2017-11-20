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
class ViewController: UIViewController
    ,UIImagePickerControllerDelegate
    ,UICollectionViewDataSource
    ,UINavigationControllerDelegate
    ,UIScrollViewDelegate
{

    @IBOutlet weak var displayImageView: UIImageView!
    
    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        myScrollView.delegate = self
        myScrollView.addSubview(displayImageView)

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initScrollImage()
    }


    
    @IBAction func doubleTapImageView(_ sender: UITapGestureRecognizer) {
        print("myScrollView.zoomScale:\(myScrollView.zoomScale)")
        print("myScrollView.maximumZoomScale:\(myScrollView.maximumZoomScale)")

        if ( myScrollView.zoomScale < myScrollView.maximumZoomScale) {
            let newScale = myScrollView.zoomScale * 3
            let zoomRect = self.zoomRectForScale(scale: newScale, center: sender.location(in: sender.view) )
            myScrollView.zoom(to: zoomRect, animated: true)
            
        } else {
            myScrollView.setZoomScale(1.0, animated: true)
        }
    }

    func zoomRectForScale(scale:CGFloat, center: CGPoint) -> CGRect{
        let size = CGSize(
            width: self.myScrollView.frame.size.width / scale,
            height: self.myScrollView.frame.size.height / scale
        )
        print("zoomRectForScale.size: \(size)")
        return CGRect(
            origin: CGPoint(
                x: center.x - size.width / 2.0,
                y: center.y - size.height / 2.0
            ),
            size: size
        )
    }
    
    
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
    
    //==============================
    // ScrolView
    //==============================
    func initScrollImage() {
        print("initScrollImage")
        if let size = displayImageView.image?.size {
            // imageViewのサイズがscrollView内に収まるように調整
//            let wrate = myScrollView.frame.width / size.width
//            let hrate = myScrollView.frame.height / size.height
//            let rate = min(wrate, hrate , 1)
//            displayImageView.frame.size = CGSize(width: size.width * rate , height: size.height * rate)
            
            // contentSizeを画像サイズに設定
            myScrollView.contentSize = displayImageView.frame.size
            // 初期表示のためcontentInsetを更新
            updateScrollInset()
        }
        
    }
    func updateScrollInset()
    {
        // imageViewの大きさからcontentInsetを再計算
        // 0を下回らないようにする
        myScrollView.contentInset = UIEdgeInsetsMake(
            max((myScrollView.frame.height - displayImageView.frame.height)/2, 0)
            ,max((myScrollView.frame.width - displayImageView.frame.width)/2, 0)
            , 0
            , 0
        )
        
    }
    
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        print("pinch")
        return self.displayImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateScrollInset()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

