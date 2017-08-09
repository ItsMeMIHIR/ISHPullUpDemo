//
//  BottomVC.swift
//  ISHPullUpDemo
//

import UIKit

class BottomVC: UIViewController {
    
    @IBOutlet var bottomrootView: UIView!
    @IBOutlet var itemTableView: UITableView!
    @IBOutlet var isPullUpTopview: UIView!
    @IBOutlet var submitButton: UIButton!
    
    @IBOutlet var upButton: UIButton!
    fileprivate var firstAppearanceCompleted = false
    fileprivate var isPullUpHalfWayPoint = CGFloat(0)
    var isPullUpController: ISHPullUpViewController!

    
    var item: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        isPullUpTopview.addGestureRecognizer(tapGesture)
        itemTableView.tableFooterView = UIView(frame: .zero)
        
        item = ["1","2","3","4","5"]
        itemTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstAppearanceCompleted = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate dynamic func handleTapGesture(gesture: UITapGestureRecognizer) {
        if isPullUpController.isLocked {
            return
        }
        isPullUpController.toggleState(animated: true)
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

extension BottomVC: ISHPullUpSizingDelegate, ISHPullUpStateDelegate {
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, maximumHeightForBottomViewController bottomVC: UIViewController, maximumAvailableHeight: CGFloat) -> CGFloat {
        let totalHeight = bottomrootView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        
        // we allow the pullUp to snap to the half way point
        // we "calculate" the cached value here
        // and perform the snapping in ..targetHeightForBottomViewController..
        isPullUpHalfWayPoint = totalHeight / 2.0
        
        return totalHeight
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, minimumHeightForBottomViewController bottomVC: UIViewController) -> CGFloat {
        return isPullUpTopview.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height;
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, targetHeightForBottomViewController bottomVC: UIViewController, fromCurrentHeight height: CGFloat) -> CGFloat {
        // if around 30pt of the half way point -> snap to it
        if abs(height - isPullUpHalfWayPoint) < 30 {
            return isPullUpHalfWayPoint
        }
        
        // default behaviour
        return height
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forBottomViewController bottomVC: UIViewController) {
        // we update the scroll view's content inset
        // to properly support scrolling in the intermediate states
        itemTableView.contentInset = edgeInsets;
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, didChangeTo state: ISHPullUpState) {
        //        debugPrint(textForState(state))
        //        isPullUpHandleView.setState(ISHPullUpHandleView.handleState(for: state), animated: firstAppearanceCompleted)
        
        upButton.tintColor = UIColor.white
    }
    
    private func textForState(_ state: ISHPullUpState) -> String {
        switch state {
        case .collapsed:
            return "Drag up or tap"
        case .intermediate:
            return "Intermediate"
        case .dragging:
            return "Hold on"
        case .expanded:
            return "Drag down or tap"
        }
    }
}
extension BottomVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bottomCell", for: indexPath)
        let currentItem = item[indexPath.row]
        cell.textLabel?.text = currentItem
        
        return cell
    }
}
