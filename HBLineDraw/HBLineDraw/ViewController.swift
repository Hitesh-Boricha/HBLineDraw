//
//  ViewController.swift
//  HBLineDraw
//
//  Created by HiteshBoricha on 09/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lineDraw: HBLineDraw!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lineDraw.lineWidth = 2

        // Do any additional setup after loading the view.
    }
    @IBAction func btnSaveTap(_ sender: Any) {
        lineDraw.btnSaveTapped()
    }
    @IBAction func btnResetTap(_ sender: Any) {
        lineDraw.btnResetDemoTapped()
    }
    @IBAction func btnClear(_ sender: Any) {
        lineDraw.btnClearTapped()
    }
}

