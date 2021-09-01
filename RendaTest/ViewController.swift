//
//  ViewController.swift
//  RendaTest
//
//  Created by 高橋　龍 on 2021/08/30.
//

//ToDo
//音声を流す(Done)
//ユーザーの最高記録コースを作る(Done)
//記録更新した証のAlertをつける（Done）
//BGMをつける
//開始までのカウントダウンViewを作る（３・２・１）
//開始までのカウントダウンにも音楽をつける？

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //目標回数
    var goalCount = 0
    
    //ユーザーの最高記録
    var userRecord = 0
    @IBOutlet var userRecordLabel: UILabel!
    
    //ボタンの装飾
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    
    //BGMの追加
    let bgmAudio = try! AVAudioPlayer(data: NSDataAsset(name: "ホーム画面BGM")!.data
    )
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ユーザーの最高記録を反映
//        print(userRecord)
        userRecordLabel.text = "\(userRecord)回"
        
        //角丸にする
        button1.layer.cornerRadius = 10
        button2.layer.cornerRadius = 10
        button3.layer.cornerRadius = 10
        button4.layer.cornerRadius = 10
        
        //BGMの再生
        bgmAudio.currentTime = 0
        bgmAudio.play()
        
    }
    
    //各レベルのボタンを押した時の処理
    @IBAction func playRenda(sender: UIButton) {
        
//        print(sender.tag)
        //初級の時、tagは1
        if sender.tag == 1 {
            goalCount = 20
        } else if sender.tag == 2 {
            goalCount = 35
        } else if sender.tag == 3 {
            goalCount = 50
        } else if sender.tag == 4 {
            goalCount = userRecord
            
        }
//        print(goalCount)
        //BGMのストップ
        bgmAudio.stop()
        
        //画面遷移
        performSegueToRenda()
    }
    
    //画面遷移のメソッド
    func performSegueToRenda() {
        performSegue(withIdentifier: "toRenda", sender: nil)
    }
    
    //連打画面に遷移するときにgoalCountの数値を保持する
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRenda" {
            let rendaViewController = segue.destination as! RendaViewController
            rendaViewController.goalCount = self.goalCount
            rendaViewController.userRecord = self.userRecord
            
        }
    }
    //以下は、旧verのコード
//
//    var count: Float = 0.0
//    var counter = 0
//
//    //もどるボタンを表示させるかどうか
//    var backJudge = 0
//
//    var timer: Timer = Timer()
//
//    //変化用
//    @IBOutlet var countLabel: UILabel!
//    @IBOutlet var timeLabel: UILabel!
//    @IBOutlet var titileLabel: UILabel!
//    @IBOutlet var countdownLabel: UILabel!
//    @IBOutlet var goalCountLabel: UILabel!
//    @IBOutlet var goalLabel: UILabel!
//    @IBOutlet var resultImage: UIImageView!
//    var goalCount = 0
//
//    //画像の名前が入った配列を作成
//    let imageName = ["クラッカー", "残念"]
//
//    //表示用
//    @IBOutlet var level1Label: UILabel!
//    @IBOutlet var level2Label: UILabel!
//    @IBOutlet var level3Label: UILabel!
//
//    //ボタン隠す、表示するのラベル
////    @IBOutlet var rendaButton: UIButton!
//    @IBOutlet var beginerButton: UIButton!
//    @IBOutlet var middleButton: UIButton!
//    @IBOutlet var superButton: UIButton!
//    @IBOutlet var backButton: UIButton!
    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
////        rendaButton.layer.cornerRadius = 125
//        startView()
//
//    }
//
//    func hidden() {
//        counter = 0
//        countLabel.text = String(counter)
//        reset()
//        start()
//
//        titileLabel.isHidden = true
//        countLabel.isHidden = false
//        timeLabel.isHidden = false
//        //countdownは、優先順位低めだから、後で実装
////        countdownLabel.isHidden = false
//        level1Label.isHidden = true
//        level2Label.isHidden = true
//        level3Label.isHidden = true
//        goalLabel.isHidden = false
//        goalCountLabel.isHidden = false
//
////        rendaButton.isHidden = false
////        beginerButton.isHidden = true
//        middleButton.isHidden = true
//        superButton.isHidden = true
////        backButton.isHidden = true
//
//
//        goalCountLabel.text = String(goalCount)
//
//
//    }
//
//    func startView() {
//
//        titileLabel.isHidden = false
//        countLabel.isHidden = true
//        timeLabel.isHidden = true
//        countdownLabel.isHidden = true
//        level1Label.isHidden = false
//        level2Label.isHidden = false
//        level3Label.isHidden = false
//        goalLabel.isHidden = true
//        goalCountLabel.isHidden = true
//
////        rendaButton.isHidden = true
////        beginerButton.isHidden = false
//        middleButton.isHidden = false
//        superButton.isHidden = false
//        backButton.isHidden = true
//        resultImage.isHidden = true
//    }
//
//    //
//
//    @IBAction func button() {
//        counter += 1
//
//        countLabel.text = String(counter)
//
//    }
//
//    @objc func up() {
//        count -= 0.01
//        //float型をString型に変換しているので、特殊な指定方法になっている
//        timeLabel.text = String(format: "%.2f", count)
//        if count <= 0.00 {
//            printResult()
//            reset()
//            resultImage.isHidden = false
//        }
//    }
//
//    @IBAction func back() {
//        startView()
//        titileLabel.text = "連打ゲーム"
//        counter = 0
//    }
//
//    @IBAction func beginer() {
//        goalCount = 20
//        hidden()
//
//    }
//    @IBAction func middle() {
//
//        goalCount = 35
//        hidden()
//
//
//    }
//    @IBAction func superLevel() {
//        goalCount = 50
//        hidden()
//    }
//
//    func start() {
//
//        //タイマーが動作していなかったら
//        if !timer.isValid {
//            count = 5.0
//            timer = Timer.scheduledTimer(timeInterval: 0.01,
//                                         target: self,
//                                         selector: #selector(self.up),
//                                         userInfo: nil,
//                                         repeats: true)
//        }
//    }
//
//    func stop() {
//        if timer.isValid {
//            //invalidate = 無効にする
//            timer.invalidate()
//        }
//    }
//
//    func reset() {
//        stop()
//
//        count = 0.0
//        timeLabel.text = String(format: "%.2f", count)
//    }
//
//    //結果の表示。Clear！とか
//    func printResult() {
//        var judge = 0
////        goalに達していた場合
//        if counter >= goalCount {
//            titileLabel.text = "Clear!!!"
////            resultImage
//            judge = 0
//        }else {
//            titileLabel.text = "残念…"
//            judge = 1
//
//        }
//        resultImage.image = UIImage(named: imageName[judge])
//
//        //戻るボタンの表示
//        backButton.isHidden = false
////        middleButton.isHidden = false
//        timeLabel.isHidden = true
////        rendaButton.isHidden = true
//        titileLabel.isHidden = false
//        goalLabel.isHidden = true
//        goalCountLabel.isHidden = true
////        middleButton.setTitle("戻る", for: .normal)
//        print("printResultが呼び出された")
//    }
    
//    func backOrMiddle() {
//        if backJudge == 0 {
////            middleButton.setTitle("戻る", for: .normal)
//            backJudge = 1
//        }
//        else {
//            middleButton.setTitle("中級", for: .normal)
//            backJudge = 0
//        }
//    }

}

