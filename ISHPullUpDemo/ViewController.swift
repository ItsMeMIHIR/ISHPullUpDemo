//
//  ViewController.swift
//  ISHPullUpDemo
//


import UIKit
import ISHPullUp

class ViewController: ISHPullUpViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goMenuAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let contentVC = storyBoard.instantiateViewController(withIdentifier: "MenuMainViewController") as! MenuMainViewController
        let bottomVC = storyBoard.instantiateViewController(withIdentifier: "BottomVC") as! BottomVC
        
        
        self.contentViewController = contentVC
        self.bottomViewController = bottomVC
        
        bottomVC.isPullUpController = self
        self.contentDelegate = contentVC
        self.sizingDelegate = bottomVC
        self.stateDelegate = bottomVC
    }

}

