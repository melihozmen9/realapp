//
//  ViewController.swift
//  realapp
//
//  Created by Kullanici on 21.07.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadlogo()
    }
    func loadlogo () {
        if let logo = UIImage(named:"1.png"){
            let imageview = UIImageView(image: logo)
            self.navigationItem.titleView = imageview
        }
        
    }

}

