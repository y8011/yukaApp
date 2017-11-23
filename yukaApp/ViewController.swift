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

   // @IBOutlet weak var displayImageView: UIImageView!
    var displayImageView: UIImageView = UIImageView()
    
    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - UICollectionViewDataSource
        myCollectionView.dataSource = self
 


            ////////画像の一番最後が表示された。最後だけやる方法ないかな？？/////////////////////
        displayImageView = UIImageView(image: UIImage(named: "Red-kitten.jpg"))
        displayImageView.isUserInteractionEnabled = true  // Gestureの許可
        displayImageView.backgroundColor = UIColor.purple
        initScrollImage()

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //initScrollImage()
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
    
    

    //==============================
    // ScrolView
    //==============================
    func initScrollImage() {
        print("initScrollImage")
        if let size = displayImageView.image?.size {
            // imageViewのサイズがscrollView内に収まるように調整
            let wrate = myScrollView.frame.width / size.width
            let hrate = myScrollView.frame.height / size.height
            let rate = min(wrate, hrate , 1)
            displayImageView.frame.size = CGSize(width: size.width * rate , height: size.height * rate)
            displayImageView.frame.origin = CGPoint(x: 0.0, y: 0.0)
            
            // contentSizeを画像サイズに設定
            myScrollView.contentSize = displayImageView.frame.size
            myScrollView.maximumZoomScale = 4.0
            myScrollView.minimumZoomScale = 1.0
            
            myScrollView.delegate = self
            myScrollView.addSubview(displayImageView)
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
    
    

    var touchPointx = 0.0
    var toochPointy = 0.0
    // スクロール中に呼び出され続けるデリゲートメソッド.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(#function)
    }
    
    // ズーム中に呼び出され続けるデリゲートメソッド.
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateScrollInset()
    }
    
    // ユーザが指でドラッグを開始した場合に呼び出されるデリゲートメソッド.
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print(#function)
    }
    
    // ユーザがドラッグ後、指を離した際に呼び出されるデリゲートメソッド.
    // velocity = points / second.
    // targetContentOffsetは、停止が予想されるポイント？
    // pagingEnabledがYESの場合には、呼び出されません.
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(#function)
    }
    
    // ユーザがドラッグ後、指を離した際に呼び出されるデリゲートメソッド.
    // decelerateがYESであれば、慣性移動を行っている.
    //
    // 指をぴたっと止めると、decelerateはNOになり、
    // その場合は「scrollViewWillBeginDecelerating:」「scrollViewDidEndDecelerating:」が呼ばれない？
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print(displayImageView.center)
        displayImageView.center = scrollView.center
        print(#function)
        print(displayImageView.center)
    }
    
    // ユーザがドラッグ後、スクロールが減速する瞬間に呼び出されるデリゲートメソッド.
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print(#function)
    }
    
    // ユーザがドラッグ後、慣性移動も含め、スクロールが停止した際に呼び出されるデリゲートメソッド.
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(#function)
    }
    
    // スクロールのアニメーションが終了した際に呼び出されるデリゲートメソッド.
    // アニメーションプロパティがNOの場合には呼び出されない.
    // 【setContentOffset】/【scrollRectVisible:animated:】
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print(#function)
    }
    
    // ズーム中に呼び出されるデリゲートメソッド.
    // ズームの値に対応したUIViewを返却する.
    // nilを返却すると、何も起きない.
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        print(#function)
        return self.displayImageView
    }
    
    // ズーム開始時に呼び出されるデリゲートメソッド.
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        print(#function)
    }
    
    // ズーム完了時(バウンドアニメーション完了時)に呼び出されるデリゲートメソッド.
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print(#function)
    }
    
    // 先頭にスクロールする際に呼び出されるデリゲートメソッド.
    // NOなら反応しない.
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        print(#function)
        return true
    }
    
    // 先頭へのスクロールが完了した際に呼び出されるデリゲートメソッド.
    // すでに先頭にいる場合には呼び出されない.
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print(#function)
    }

    
    //ズームのために要指定
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        // ズームのために要指定
        return displayImageView
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

