//
//  ViewController.swift
//  Calculator
//
//  Created by Vido Valianto on 2/25/19.
//  Copyright © 2019 Vido Valianto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var hasilPerhitungan : Double = 0
    var input : String = "0"
    var numberArray = [Double]()
    var calculation = [Int]()
    var resultLbl: UILabel!
    var inputLbl: UILabel!
    let btnFunctionList = ["Division","Multiplication","Subtraction","Addition","Equal"]
    var lanjutcounting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.black
        
        let numberBtnList = [[7,8,9],[4,5,6],[1,2,3],[0]]
        let symbolBtnList = [":","x","-","+","="]
        let additionBtnList = [".","c"]
        
        let xstart = Int(self.view.frame.size.width/25)
        let ystart = Int(self.view.frame.size.height/4)
        
        let spacing = 90
        let indent = 100
        let btnSize = 80
        let btnFontSize = CGFloat(30)
        let btnFontName = "Avenir"
        
        let ncolor = hexStringToUIColor(hex: "#333333")
        let scolor = hexStringToUIColor(hex: "#f39938")
        let ccolor = hexStringToUIColor(hex: "#a6a6a6")
        
        let cradius = CGFloat(28)
        
        resultLbl = UILabel(frame: CGRect(x:Int(self.view.frame.size.width/25), y:ystart-(indent*5/3), width:340, height:210))
        resultLbl.textAlignment = NSTextAlignment.right
        resultLbl.textColor = UIColor.white
        resultLbl.font = UIFont(name:"AvenirNext-UltraLight", size: 100.0)
        resultLbl.text = String(0)
        self.view.addSubview(resultLbl)
    
        
        for (i,set) in numberBtnList.enumerated(){
            for (j,number) in set.enumerated() {
                
                if (number == 0){
                    let button = UIButton(frame: CGRect(x: xstart + j*spacing, y: indent+i*indent+ystart, width: btnSize*2 , height: btnSize))
                    button.backgroundColor = ncolor
                    button.setTitle(String(number), for: .normal)
                    button.layer.cornerRadius = cradius
                    button.titleLabel?.font =  UIFont(name: btnFontName, size: btnFontSize)
                    button.tag = number
                    button.addTarget(self, action: #selector(numberBtnAction), for: .touchUpInside)
                    
                    self.view.addSubview(button)
                }
                else {
                    let button = UIButton(frame: CGRect(x: xstart + j*spacing, y: indent+i*indent+ystart, width: btnSize, height: btnSize))
                    button.backgroundColor = ncolor
                    button.setTitle(String(number), for: .normal)
                    button.layer.cornerRadius = 0.5 * button.bounds.size.width
                    button.titleLabel?.font =  UIFont(name: btnFontName, size: btnFontSize)
                    button.tag = number
                    button.addTarget(self, action: #selector(numberBtnAction), for: .touchUpInside)
                    
                    self.view.addSubview(button)
                }
                
            }
        }
        
        let cbutton = UIButton(frame: CGRect(x: xstart, y: ystart, width: btnSize, height: btnSize))
        cbutton.backgroundColor = ccolor
        cbutton.setTitle(additionBtnList[1], for: .normal)
        cbutton.layer.cornerRadius = 0.5 * cbutton.bounds.size.width
        cbutton.titleLabel?.font =  UIFont(name: btnFontName, size: btnFontSize)
        cbutton.tag = 1
        cbutton.addTarget(self, action: #selector(addBtnAction), for: .touchUpInside)
        
        self.view.addSubview(cbutton)

        let fbutton = UIButton(frame: CGRect(x: xstart + spacing+((numberBtnList[3].count)*spacing), y: ystart+(symbolBtnList.count-1)*indent, width: btnSize, height: btnSize))
        fbutton.backgroundColor = ncolor
        fbutton.tag = 0
        fbutton.layer.cornerRadius = 0.5 * fbutton.bounds.size.width
        fbutton.setTitle(additionBtnList[0], for: .normal)
        fbutton.titleLabel?.font =  UIFont(name: btnFontName, size: btnFontSize)
        fbutton.addTarget(self, action: #selector(addBtnAction), for: .touchUpInside)
        
        self.view.addSubview(fbutton)

        for (i,symbol) in symbolBtnList.enumerated(){
            
            let button = UIButton(frame: CGRect(x: xstart + spacing*(numberBtnList[0].count), y: ystart+i*indent, width: btnSize, height: btnSize))
            button.backgroundColor = scolor
            button.setTitle(symbol, for: .normal)
            button.titleLabel?.font =  UIFont(name: btnFontName, size: btnFontSize)
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            
            if i == 4{
                button.addTarget(self, action: #selector(Equal), for: .touchUpInside)
            }
            else {
                button.tag = i
                button.addTarget(self, action: #selector(Calculate), for: .touchUpInside)
            }

            self.view.addSubview(button)
            
        }
    }

    func Addition(a:Double,b:Double) -> Double{
        return (a+b)
    }
    
    func Subtraction(a:Double,b:Double) -> Double{
        return (a-b)
    }
    
    func Multiplication(a:Double,b:Double) -> Double{
        print(a,b,a*b)
        return (a*b)
    }
    
    func Division(a:Double,b:Double) -> Double{
        if (b==0){
            return (0)
        }
        return (a/b)
    }
    
    @objc func Equal(sender: UIButton!){
//        print("equal button click")
        let number = Double(input)
        
        numberArray.append(number!)
        var counter = 0
        
        for (i,tuppleCal) in calculation.enumerated(){
            let indeks = i-counter
            switch tuppleCal{
            case 0:
//                print(numberArray[indeks],numberArray[indeks+1])
                numberArray[indeks]=Division(a:numberArray[indeks],b:numberArray[indeks+1])
                print("Division")
            case 1:
//                print(numberArray[indeks],numberArray[indeks+1])
                numberArray[indeks]=Multiplication(a:numberArray[indeks],b:numberArray[indeks+1])
                print("Multiplication")
                
            case 2:
//                print(numberArray[indeks],numberArray[indeks+1])
                numberArray[indeks]=Subtraction(a:numberArray[i-counter],b:numberArray[indeks+1])
                print("Subtraction")
            case 3:
//                print(numberArray[indeks],numberArray[indeks+1])
                numberArray[indeks]=Addition(a:numberArray[indeks],b:numberArray[indeks+1])
                print("Addition")
            default:
                break
            }
            numberArray.remove(at: i+1-counter)
            calculation.remove(at: i-counter)
            
            
            input = String(numberArray[i-counter].clean)
            
            resultLbl.text = input
            lanjutcounting = true
            counter += 1
        }
        
        numberArray = []
        numberArray.append(Double(input)!)
//        print(numberArray)
        
        
    }
    
    @objc func Calculate(sender: UIButton!){
        let number = Double(input)
        calculation.append(sender.tag)
        if !lanjutcounting {
            
            numberArray.append(number!)
//            print(number!)
        }
        lanjutcounting = false
//        print(numberArray)
//        print(calculation)
        input = "0"
        resultLbl.text = input
    }
    
    @objc func addBtnAction(sender: UIButton!){
        switch sender.tag {
        case 0:
            input = input + "."
            resultLbl.text = input
        case 1:
            hasilPerhitungan = 0
            numberArray = []
            calculation = []
            input = "0"
            resultLbl.text = input
            lanjutcounting = false
        default:
            break
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func numberBtnAction(sender: UIButton!) {
        if lanjutcounting == true{
            numberArray = []
            calculation = []
            input = String(sender.tag)
            resultLbl.text = input
        }
        if Double(input) == 0 {
            input = String(sender.tag)
            resultLbl.text = input
            
        }
        else {
            input = input + String(sender.tag)
            resultLbl.text = input
        }
        lanjutcounting = false
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

extension Array where Element : Collection, Element.Index == Int {
    func indexPath(where predicate: (Element.Iterator.Element) -> Bool) -> IndexPath? {
        for (i, row) in self.enumerated() {
            if let j = row.index(where: predicate) {
                return IndexPath(indexes: [i, j])
            }
        }
        return nil
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

