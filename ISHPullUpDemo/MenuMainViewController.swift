//
//  MenuMainViewController.swift
//  ISHPullUpDemo
//

import UIKit

class MenuMainViewController: LSYViewPagerVC {
    
    var typeArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeArray = ["1","2","3","4","5"]
        self.delegate = self
        self.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MenuMainViewController: LSYViewPagerVCDataSource, LSYViewPagerVCDelegate,  UINavigationControllerDelegate {
    func numberOfViewControllers(inViewPager viewPager: LSYViewPagerVC!) -> Int {
        return typeArray.count
    }
    
    func viewPager(_ viewPager: LSYViewPagerVC!, indexOfViewControllers index: Int) -> UIViewController! {
        let detailVc = self.storyboard?.instantiateViewController(withIdentifier: "MenuDetailTableViewController") as! MenuDetailTableViewController
        return detailVc
    }
    
    func viewPager(_ viewPager: LSYViewPagerVC!, titleWithIndexOfViewControllers index: Int) -> String! {
        let type = typeArray[index]
        return type
    }
    
    func heightForTitle(ofViewPager viewPager: LSYViewPagerVC!) -> CGFloat {
        return 50
    }
}

extension MenuMainViewController: ISHPullUpContentDelegate {
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forContentViewController contentVC: UIViewController) {
        // update edgeInsets
        self.view.layoutMargins = edgeInsets
        
        // call layoutIfNeeded right away to participate in animations
        // this method may be called from within animation blocks
        self.view.layoutIfNeeded()
    }
}
