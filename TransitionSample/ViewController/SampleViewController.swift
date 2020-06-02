//
//  SampleViewController.swift
//  Created 3/4/20
//  Using Swift 5.0
// 
//  Copyright © 2020 Yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//


import UIKit


private let backgroundColors: [UIColor] = [.red, .yellow, .green, .blue, .purple]

class SampleViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tbl = UITableView(frame: .zero, style: .plain)
        tbl.register(PlainTableViewCell.self, forCellReuseIdentifier: "basic")
        tbl.register(SpecialTableViewCell.self, forCellReuseIdentifier: "special")
        tbl.dataSource = self
        tbl.delegate = self
        return tbl
    }()
    
    /*
     This is going to be the location of the item to move of my initial VC
     And the location-reference of the destination location of the destination VC
     */
    var specialRow = 3
    
    /*
     My custom animator
     */
    var animator: MyTransitionAnimator? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.fillIn(self.view)
        tableView.backgroundColor = backgroundColors[specialRow]
    }

}

extension SampleViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
}

extension SampleViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let id = indexPath.row == specialRow ? "special" : "basic"
        cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        cell.textLabel?.text = "Row: " + String(indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
}

extension SampleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row == specialRow else { return }
        // make a new VC for display
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! SampleViewController
        
        // set it up
        // here, we set it up to "move the cell up".
        vc.specialRow = (specialRow == 0) ? 4 : specialRow - 1
        setupAnimator(self, vc)
        
        // set up for transition, set animation delegate
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .fullScreen
        
        // present the VC.
        present(vc, animated: true, completion: nil)
    }
}

extension SampleViewController {
    /*
     Sets up my animator
     For this example:
     1. tell it where the first cell will be (the item to move)
     2. tell it where it will go (the destination frame)
    */
    func setupAnimator(_ first: SampleViewController, _ second: SampleViewController) {
        // determine the view to animate
        let cell = tableView.cellForRow(at: IndexPath(row: first.specialRow, section: 0))!
        
        // determine where it'll go
        // here, we know both VCs look the same, and can reliably "move" it to that place
        let secondCell = tableView.cellForRow(at: IndexPath(row: second.specialRow, section: 0))!
        let endRect: CGRect = secondCell.frame
        
        animator = MyTransitionAnimator(view: cell, destinationRect: endRect)
    }
}
