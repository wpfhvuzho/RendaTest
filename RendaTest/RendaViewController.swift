//
//  RendaViewController.swift
//  RendaTest
//
//  Created by 高橋　龍 on 2021/09/01.
//

import UIKit

class RendaViewController: UIViewController {
    
    @IBOutlet var countdownLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var goalLabel: UILabel!
    
    @IBOutlet var button: UIButton!
    
    var goalCount = 0
    var rendaCount: Int!
    var userRecord: Int!
    

    var timer: Timer = Timer()
    var count = 5.0
    
    
    //コーディングの都合上必要な値
    var test = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初期化
        rendaCount = 0
        countLabel.text = "0回"
        count = 5.0
        
        button.layer.cornerRadius = 20

        
        //カウントダウンの開始
        startCountdown()
        
        //級数に応じた目標数を表示させる
        goalLabel.text = "目標：\(goalCount)回"

        // Do any additional setup after loading the view.
    }
    
    //連打ボタンを押したときの処理
    @IBAction func rendaButton() {
        rendaCount += 1
        countLabel.text = "\(String(rendaCount))回"
        
    }
    
    
    //カウントダウンの設定
    @objc func up() {
        count -= 0.01
        //float型をString型に変換しているので、特殊な指定方法になっている
        countdownLabel.text = String(format: "%.2f", count)
        //終了時の表示を0.00にするため、0.01以下にしている
        if count <= 0.01 {
            performSegueToResult()
            timer.invalidate()
        }
    }
    //カウントダウンの開始
    func startCountdown() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
    }
    
    //画面遷移のメソッド
    func performSegueToResult() {
        performSegue(withIdentifier: "toResult", sender: nil)
    }
    
    //連打画面に遷移するときにgoalCountの数値を保持する
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult" {
            let resultViewController = segue.destination as! ResultViewController
            resultViewController.rendaCount  = self.rendaCount
            resultViewController.goalCount = self.goalCount
            resultViewController.userRecord = self.userRecord
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
