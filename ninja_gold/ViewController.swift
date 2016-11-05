//
//  ViewController.swift
//  ninja_gold
//
//  Created by Erik Clineschmidt on 11/3/16.
//  Copyright © 2016 Erik Clineschmidt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var house_btn: UIButton!
    
    @IBOutlet var results_label: [UILabel]!
    
    let ranges = [(10,20),(5,10),(2,5),(0,50)]
    var total: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        resetUI(reset_total: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func resetUI(reset_total: Bool){
        for index in 0...3 { results_label[index].isHidden = true }
        if(reset_total == true){
            total = 0
            self.results_label[5].text = "0"
        }
    }
    func gen_rnd(lower: Int, upper: Int) -> Int {
        return(Int(arc4random_uniform(UInt32((upper - lower) + 1))) + lower)
    }
    func neg_pos(val: Int) -> Int {
        let x = arc4random_uniform(99)
        if x<=50 { return(val) } else { return(-val) }
    }
    func updateUI(pushed: Int){
        if(pushed == 5){
            resetUI(reset_total: true)
        }else{
            resetUI(reset_total: false)
            var result = gen_rnd(lower: ranges[pushed].0, upper: ranges[pushed].1)
            if (pushed == 3) { result = neg_pos(val: result) }
            result >= 0 ? (self.results_label[pushed].text = "You won " + String(result)) : (self.results_label[pushed].text = "you lost " + String(result))
            self.results_label[pushed].isHidden = false
            total += result
            self.results_label[5].text = String(total)
        }
    }
    
    @IBAction func house_btn_pressed(_ sender: UIButton) {
        updateUI(pushed: sender.tag)
    }

}

