//
//  ViewController.swift
//  HW2.5
//
//  Created by Арслан on 24.01.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Save all interesting links in one app"
        label.textColor = .white
        label.frame = CGRect(x: 16, y: 600, width: 358, height: 92)
        label.font = UIFont.boldSystemFont(ofSize: 36)
        return label
    }()
    
    
    var but: UIButton = {
        let but = UIButton(frame: CGRect(x: 16, y: 710, width: 350, height: 58))
        but.backgroundColor = .white
        but.setTitle("Let's start collecting", for: .normal)
        but.setTitleColor(.black, for: .normal)
        but.layer.cornerRadius = 16
        return but
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let myLayer = CALayer()
        let myImage = UIImage(named: "image 8")?.cgImage
        myLayer.frame = CGRect(x: 0, y: 0, width: 390, height: 614)
        myLayer.contents = myImage
        view.layer.addSublayer(myLayer)
        
        view.addSubview(label)
        
        view.addSubview(but)
        but.addTarget(self, action: #selector(handleStartButton), for: .touchUpInside)
    }
    
    @objc private func handleStartButton() {
        let vc = SecondView()
        Storage.showOnboarding = false
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(vc, animated: true, completion: nil)
       
    }

}

