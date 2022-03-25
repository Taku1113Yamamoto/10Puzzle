//
//  GameViewController.swift
//  10puzzle
//
//  Created by 山本拓 on 2022/03/19.
//

import UIKit


class GameViewController: UIViewController {
    @IBOutlet weak var num1: UIButton!
    @IBOutlet weak var num2: UIButton!
    @IBOutlet weak var num3: UIButton!
    @IBOutlet weak var num4: UIButton!
    @IBOutlet weak var calclabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    
  

    
    override func viewDidLoad() {
        /// ①プロジェクト内にある"lv1.txt"のパス取得
        guard let fileURL = Bundle.main.url(forResource: "lv1", withExtension: "txt")  else {
            fatalError("ファイルが見つからない")
        }
         
        /// ②capital.txtファイルの内容をfileContents:Stringに読み込み
        guard let fileContents = try? String(contentsOf: fileURL) else {
            fatalError("ファイル読み込みエラー")
        }
                
        /// ③ファイルの内容を"\n"で分割。
        let numLists = fileContents.components(separatedBy: "\r\n")
        
        print("aaa")
        print(numLists)
//        /// ④１行づつ出力
//        for nums in numLists {
//            let values = capital.components(separatedBy: ",")
//            print("\(values[0])の首都は、\(values[1])です。")
//        }
        
        num1.setTitle("2", for: .normal)
        num2.setTitle("3", for: .normal)
        num3.setTitle("1", for: .normal)
        num4.setTitle("4", for: .normal)
    
        calclabel.text = ""
        correctLabel.text = ""

        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func inputCalc(_ sender: UIButton) {
        guard let formulaText = calclabel.text else{
            return
        }
        guard let senderedText = sender.titleLabel?.text else{
            return
        }
        calclabel.text = formulaText + senderedText
    }

    @IBAction func clearCalc(_ sender: Any) {
        calclabel.text = ""
    }
    
    @IBAction func deleteCalc(_ sender: UIButton) {
        guard var text  = calclabel.text else{
            return
        }
        let i = text.index(text.endIndex, offsetBy: -1)
        text.remove(at: i)
        calclabel.text = text
    }
    
    @IBAction func runCalc(_ sender: Any) {

        guard let text  = calclabel.text else{
            return
        }
        let formattedCalc = formatCalc(text)
        let evalCalc = evalCalc(formattedCalc)
        if evalCalc == "10.0"{
            correctLabel.text = "正解"
        }
    }
    
    private func formatCalc(_ calc: String) -> String {
         // 入力された整数には`.0`を追加して小数として評価する
         // また`÷`を`/`に、`×`を`*`に置換する
         let formattedCalc: String = calc.replacingOccurrences(
                 of: "(?<=^|[÷×\\+\\-\\(])([0-9]+)(?=[÷×\\+\\-\\)]|$)",
                 with: "$1.0",
                 options: NSString.CompareOptions.regularExpression,
                 range: nil
             ).replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "×", with: "*")
         return formattedCalc
     }
    
    private func evalCalc(_ calc: String) -> String {
          // Expressionで文字列の計算式を評価して答えを求める
          let expression = NSExpression(format: calc)
          let answer = expression.expressionValue(with: nil, context: nil) as! Double
          return String(answer)
          
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
