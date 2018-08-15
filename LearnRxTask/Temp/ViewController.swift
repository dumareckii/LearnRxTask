//
//  ViewController.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/15/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func testButtonPressed(_ sender: UIButton) {
        let vc = SignInViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
