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
import CalculatorKeyboard
import ActionCell


//class ViewController: UIViewController,UIImagePickerControllerDelegate, CalculatorDelegate {
class ViewController: UIViewController
    ,UIImagePickerControllerDelegate
    ,UICollectionViewDataSource
    ,UINavigationControllerDelegate
    ,UIScrollViewDelegate
    , CalculatorDelegate
    ,UITableViewDelegate
    ,UITableViewDataSource
{

   // @IBOutlet weak var displayImageView: UIImageView!
    var displayImageView: UIImageView = UIImageView()
    var output:UILabel = UILabel()
    var resultText:String = ""
    var suuji:String = ""
    
    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var myTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - UICollectionViewDataSource
        myCollectionView.dataSource = self
 


            ////////画像の一番最後が表示された。最後だけやる方法ないかな？？/////////////////////
        displayImageView = UIImageView(image: UIImage(named: "Red-kitten.jpg"))
        displayImageView.isUserInteractionEnabled = true  // Gestureの許可
        displayImageView.backgroundColor = UIColor.purple
        initScrollImage()
        
        //TableViewとCellの設定
                myTableView.dataSource = self
                myTableView.delegate   = self
                myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cellta")
    
        
        output.frame = CGRect(x: 10, y: 10, width: 100, height: 20)
        output.textAlignment = .center
        output.backgroundColor = UIColor.lightGray
        self.view.addSubview(output)
        
        initCalc()

        
    }
    
    
    //===============================
    // 計算機
    //===============================
    func calculator(_ calculator: CalculatorKeyboard, didChangeValue value: String, KeyType: Int) {
        inputText.text = value

        switch KeyType {
        case CalculatorKey.multiply.rawValue ... CalculatorKey.add.rawValue:
            if KeyType == CalculatorKey.multiply.rawValue {
                resultText = resultText + "\(suuji)x"
            }
            else if KeyType == CalculatorKey.divide.rawValue {
                resultText = resultText + "\(suuji)/"
            }
            else if KeyType == CalculatorKey.subtract.rawValue {
                resultText = resultText + "\(suuji)-"
            }
            else if KeyType == CalculatorKey.add.rawValue {
                resultText = resultText + "\(suuji)+"
            }
            
        case CalculatorKey.equal.rawValue :
            resultText = resultText + "\(suuji) = \(value)"
            rirekiTexts.append(resultText)

        case CalculatorKey.clear.rawValue:
            print("けされたぁ")
            resultText = ""
        default:
            break
            
        }

        suuji = value
        print(value)
        print(resultText)

        
    }
    
    func initCalc() {
        let frame = CGRect(x:0 , y:0 , width: UIScreen.main.bounds.width, height:300 )
        var keyboard:CalculatorKeyboard = CalculatorKeyboard()
        keyboard = CalculatorKeyboard(frame: frame)
        
        
        keyboard.delegate = self
        keyboard.showDecimal = true
        inputText.inputView = keyboard
        
        
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
    
 
    //============================
    //collectionView
    //============================
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
    
    //=============================
    //TableView
    //=============================
    
    var rirekiResult:[String] = []
    var rirekiTexts:[String] = []
    
    //2.行数の決定
    // numberofrowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 10
        
        //return rirekiResult.count
        
    }
    

    //3.リストに表示する文字列を決定し、表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //文字列を表示するせるの取得（セルの再利用）
        //indexPath 行番号とかいろいろ入っている　セルを指定する時によく使う
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellko", for: indexPath)
        
        
            //表示したい文字の設定
//            cell.textLabel?.text = "\(indexPath.row)行目"

        switch (indexPath as NSIndexPath).row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellta", for: indexPath)
            cell.textLabel?.text = "style: ladder"
            let wrapper = ActionCell()
            wrapper.delegate = self
            wrapper.animationStyle = .ladder
            wrapper.wrap(cell: cell,
                         actionsLeft: [
                            {
                                let action = IconTextAction(action: "cell 0 -- left 0")
                                action.icon.image = #imageLiteral(resourceName: "image_5").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.label.text = "Hello"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.14, green:0.69, blue:0.67, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = TextAction(action: "cell 0 -- left 1")
                                action.label.text = "Long Sentence"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:1.00, green:0.78, blue:0.80, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = IconAction(action: "cell 0 -- left 2")
                                action.icon.image = #imageLiteral(resourceName: "image_0").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.51, green:0.83, blue:0.73, alpha:1.00)
                                return action
                            }(),
                            ],
                         actionsRight: [
                            {
                                let action = IconTextAction(action: "cell 0 -- right 0")
                                action.icon.image = #imageLiteral(resourceName: "image_1").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.label.text = "Hello"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.14, green:0.69, blue:0.67, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = TextAction(action: "cell 0 -- right 1")
                                action.label.text = "Long Sentence"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.51, green:0.83, blue:0.73, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = IconAction(action: "cell 0 -- right 2")
                                action.icon.image = #imageLiteral(resourceName: "image_2").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.backgroundColor = UIColor(red:1.00, green:0.78, blue:0.80, alpha:1.00)
                                return action
                            }(),
                            ])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellta", for: indexPath)
            cell.textLabel?.text = "style: ladder_emergence"
            let wrapper = ActionCell()
            wrapper.delegate = self
            wrapper.animationStyle = .ladder_emergence
            wrapper.wrap(cell: cell,
                         actionsLeft: [
                            {
                                let action = IconTextAction(action: "cell 1 -- left 0")
                                action.icon.image = #imageLiteral(resourceName: "image_5").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.label.text = "Hello"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.14, green:0.69, blue:0.67, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = TextAction(action: "cell 1 -- left 1")
                                action.label.text = "Long Sentence"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:1.00, green:0.78, blue:0.80, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = IconAction(action: "cell 1 -- left 2")
                                action.icon.image = #imageLiteral(resourceName: "image_0").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.51, green:0.83, blue:0.73, alpha:1.00)
                                return action
                            }(),
                            ],
                         actionsRight: [
                            {
                                let action = IconTextAction(action: "cell 1 -- right 0")
                                action.icon.image = #imageLiteral(resourceName: "image_1").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.label.text = "Hello"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.14, green:0.69, blue:0.67, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = TextAction(action: "cell 1 -- right 1")
                                action.label.text = "Long Sentence"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.51, green:0.83, blue:0.73, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = IconAction(action: "cell 1 -- right 2")
                                action.icon.image = #imageLiteral(resourceName: "image_2").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.backgroundColor = UIColor(red:1.00, green:0.78, blue:0.80, alpha:1.00)
                                return action
                            }(),
                            ])
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellko", for: indexPath)
            cell.textLabel?.text = "style: concurrent"
            let wrapper = ActionCell()
            wrapper.delegate = self
            wrapper.animationStyle = .concurrent
            wrapper.wrap(cell: cell,
                         actionsLeft: [
                            {
                                let action = IconTextAction(action: "cell 2 -- left 0")
                                action.icon.image = #imageLiteral(resourceName: "image_5").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.label.text = "Hello"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.14, green:0.69, blue:0.67, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = TextAction(action: "cell 2 -- left 1")
                                action.label.text = "Long Sentence"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:1.00, green:0.78, blue:0.80, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = IconAction(action: "cell 2 -- left 2")
                                action.icon.image = #imageLiteral(resourceName: "image_0").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.51, green:0.83, blue:0.73, alpha:1.00)
                                return action
                            }(),
                            ],
                         actionsRight: [
                            {
                                let action = IconTextAction(action: "cell 2 -- right 0")
                                action.icon.image = #imageLiteral(resourceName: "image_1").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.label.text = "Hello"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.14, green:0.69, blue:0.67, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = TextAction(action: "cell 2 -- right 1")
                                action.label.text = "Long Sentence"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.51, green:0.83, blue:0.73, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = IconAction(action: "cell 2 -- right 2")
                                action.icon.image = #imageLiteral(resourceName: "image_2").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.backgroundColor = UIColor(red:1.00, green:0.78, blue:0.80, alpha:1.00)
                                return action
                            }(),
                            ])
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellta", for: indexPath) as! CustomTableViewCell
            cell.accessoryType = .disclosureIndicator
            cell.button.setTitle("result", for: .normal)
            cell.button.addTarget(self, action:  #selector(cellButtonClicked(_:))
                 , for: .touchUpInside)
            let wrapper = ActionCell()
            wrapper.delegate = self
            wrapper.animationStyle = .concurrent
            wrapper.wrap(cell: cell,
                         actionsLeft: [
                            {
                                let action = IconTextAction(action: "cell 3 -- left 0")
                                action.icon.image = #imageLiteral(resourceName: "image_5").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.label.text = "Hello"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.14, green:0.69, blue:0.67, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = TextAction(action: "cell 3 -- left 1")
                                action.label.text = "Long Sentence"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:1.00, green:0.78, blue:0.80, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = IconAction(action: "cell 3 -- left 2")
                                action.icon.image = #imageLiteral(resourceName: "image_0").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.51, green:0.83, blue:0.73, alpha:1.00)
                                return action
                            }(),
                            ],
                         actionsRight: [
                            {
                                let action = IconTextAction(action: "cell 3 -- right 0")
                                action.icon.image = #imageLiteral(resourceName: "image_1").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.label.text = "Hello"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.14, green:0.69, blue:0.67, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = TextAction(action: "cell 3 -- right 1")
                                action.label.text = "Long Sentence"
                                action.label.font = UIFont.systemFont(ofSize: 12)
                                action.label.textColor = UIColor.white
                                action.backgroundColor = UIColor(red:0.51, green:0.83, blue:0.73, alpha:1.00)
                                return action
                            }(),
                            {
                                let action = IconAction(action: "cell 3 -- right 2")
                                action.icon.image = #imageLiteral(resourceName: "image_2").withRenderingMode(.alwaysTemplate)
                                action.icon.tintColor = UIColor.white
                                action.backgroundColor = UIColor(red:1.00, green:0.78, blue:0.80, alpha:1.00)
                                return action
                            }(),
                            ])
            return cell
        default:
            
            return tableView.dequeueReusableCell(withIdentifier: "cellta", for: indexPath) as! CustomTableViewCell
              let cell = tableView.dequeueReusableCell(withIdentifier: "cellko", for: indexPath)
            
            
            //表示したい文字の設定
                        cell.textLabel?.text = "\(indexPath.row)行目"
            
            //文字を設定したせるを返す
            //    return cell
        }
    }

    //addTargetでselector通じて引数を渡すことはできない。それ自身を渡すことならできる
    //なので、テキストラベルに入っているボタンを渡すことにする
    func cellButtonClicked(_ sender: UIButton) {
        self.output.text = "cell button clicked"
        print(#function)
        let myPasteBoard = UIPasteboard.general
//        myPasteBoard.string = sender.titleLabel?.text as! String
        myPasteBoard.string = "aaaa"
        print(sender.description)
        print(sender.titleLabel?.text as! String)
    }

    func tapDelete() {
        let appDalegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDalegate.persistentContainer.viewContext
        
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

extension ViewController: ActionCellDelegate {
    var tableView: UITableView! {
        return myTableView
        
    }
    
    
    public func didActionTriggered(cell: UITableViewCell, action: String) {
        self.output.text = action + " clicked"
        print(#function)
        print(action)
    }
}

class CustomTableViewCell: UITableViewCell {
    
    var button: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        button = {
            let the = UIButton()
            the.setTitle("click me", for: .normal)
            the.setTitleColor(UIColor.white, for: .normal)
            the.backgroundColor = UIColor.brown
            return the
        }()
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 300))
        contentView.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearActionsheet()
    }
}
