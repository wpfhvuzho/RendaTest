//
//  ResultViewController.swift
//  RendaTest
//
//  Created by 高橋　龍 on 2021/09/01.
//

import UIKit
import SwiftConfettiView
import AVFoundation

class ResultViewController: UIViewController {
    
    //結果表示のためのラベルと数値
    @IBOutlet var goalCountLabel: UILabel!
    @IBOutlet var rendaCountLabel: UILabel!
    var rendaCount = 0
    var goalCount = 0
    
    //ボタンの装飾
    @IBOutlet var button: UIButton!
    
    //結果演出
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var resultImage: UIImageView!
    
    //効果音
    let celebrateSoundPlayer = try! AVAudioPlayer(data: NSDataAsset(name:"正解")!.data)
    let zannenSoundPlayer = try! AVAudioPlayer(data: NSDataAsset(name:"残念")!.data)
    
    //ユーザーの最高記録保存
    var saveUserRecord: UserDefaults = UserDefaults.standard
    var userRecord = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //結果の表示
        rendaCountLabel.text = "押した回数：\(rendaCount)回"
        goalCountLabel.text = "目標の回数：\(goalCount)回"
        
        if rendaCount >= goalCount {
            celebrate()
        }else {
            zannen()
        }
        button.layer.cornerRadius = 10
 
        // Do any additional setup after loading the view.
    }
    
    //アラートを表示させるためにviewDidApperでアラートを表示
    override func viewDidAppear(_ animated: Bool) {
        //記録の更新
        if  userRecord < rendaCount {
            print("newRecord")
            newRecord()
        }
    }
    

    
    //クリアした時の処理
    func celebrate() {
        //Audioの初期化と再生
        celebrateSoundPlayer.currentTime = 0
        celebrateSoundPlayer.play()
        
        kamiFubuki()
        resultImage.image = UIImage(named: "喜ぶ人")
        resultLabel.text = "Clear!!"
    }
    
    //クリアできなかった時の処理
    func zannen() {
        //Audioの初期化と再生
        zannenSoundPlayer.currentTime = 0
        zannenSoundPlayer.play()
        
        resultImage.image = UIImage(named: "落ち込む人")
        resultLabel.text = "残念…"

    }
    
    //最高記録を更新する
    func newRecord() {
        //記録の保存
        saveUserRecord.set(rendaCount, forKey: "maxRecord")
        userRecord = rendaCount
        print("ーーこれが保存された最高記録ーー")
        print(saveUserRecord.object(forKey: "maxRecord") ?? Int.self)
                
        //記録更新のアラート
        let alert: UIAlertController = UIAlertController(title: "おめでとう！", message: "最高記録を更新しました！", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(title: "やったぜ！",
                          style: .default,
                          handler: { action in
                            self.navigationController?.popViewController(animated: true)
                            print("きちんと更新されました")
                          }
            )
        )
        
        //アラートの表示
        present(alert, animated: true, completion: nil)
        
    }
    
    //画面遷移のメソッド
    func performSegueToHome() {
        performSegue(withIdentifier: "toHome", sender: nil)
    }
    
    //最高記録をViewControllerに受け渡すための関数
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHome" {
            let viewController = segue.destination as! ViewController
            viewController.userRecord = self.userRecord
        }
        
    }
    

    
    //紙吹雪を舞わさる
    //参考：https://qiita.com/ayuyu_4976/items/52ddf008da582ee99b49
    func kamiFubuki() {
        //Viewを生成
        let confettiView = SwiftConfettiView(frame: self.view.bounds)
        //Viewを追加
        self.view.addSubview(confettiView)
        //パーティクルの種類を設定
        confettiView.type = .confetti
        //パーティクルのカラーを設定
        confettiView.colors = [UIColor.purple, UIColor.systemPink, UIColor.blue, UIColor.green]
        //パーティクルの強度を設定
        confettiView.intensity = 0.75
        //紙吹雪をスタート
        confettiView.startConfetti()
        //3秒後に紙吹雪を停止する
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            confettiView.stopConfetti()
        }
        //6秒後にSubviewを削除する
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            confettiView.removeFromSuperview()
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
