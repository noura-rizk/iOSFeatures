//
//  HomeVC.swift
//  FeaturesApp
//
//  Created by Noura Rizk on 1/6/16.
//  Copyright © 2016 Noura Rizk. All rights reserved.
//

import UIKit
import CoreData

class HomeVC: UIViewController {
    
    @IBOutlet weak var downBtn: UIButton!
    @IBOutlet weak var rotateBtn: UIButton!
    @IBOutlet weak var topBtn: UIButton!
    @IBOutlet weak var slideRightBtn: UIButton!
    
    @IBOutlet weak var rightbtn: UIBarButtonItem!
    @IBOutlet weak var leftBtn: UIBarButtonItem!
    
    
    let slideDownTransition = SlideDownTransitionAnimator()
    let slideRightTransition = SlideRightTransitionAnimator()
    let popTransition = PopTransitionAnimator()
    let rotateTransition = RotateTransitionAnimator()
    
    //var fetchedRequestsController = NSFetchedResultsController!;
    var catObj: Categories!;

    override func viewDidLoad() {
        super.viewDidLoad()
        if (NSUserDefaults.standardUserDefaults().valueForKey(LOADED_KEY) == nil){
            catObj = Categories();
            catObj.downloadAllCategories { () -> () in
                NSUserDefaults.standardUserDefaults().setValue("loaded", forKey: LOADED_KEY);
            }
        }
       
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func leftPressed(sender: AnyObject) {
        if revealViewController() != nil {
            leftBtn.target = revealViewController()
            leftBtn.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    @IBAction func rightPressed(sender: AnyObject) {
        revealViewController().rightViewRevealWidth = 150
        rightbtn.target = revealViewController()
        rightbtn.action = "rightRevealToggle:"
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      //  print("insideSeques");
        let toViewController = segue.destinationViewController
        let sourceViewController = segue.sourceViewController as! UIViewController
        if segue.identifier == "topSeq" {
            toViewController.transitioningDelegate = popTransition
        }else if segue.identifier == "rotateSeq"{
            toViewController.transitioningDelegate = rotateTransition
        }else if segue.identifier == "rightSeq"{
            toViewController.transitioningDelegate = slideRightTransition
        }else if segue.identifier == "downSeq"{
            toViewController.transitioningDelegate = slideDownTransition
            
        }
        
    }
    
    
    @IBAction func downPressed(sender: AnyObject) {
        //var transift = TransitController();
        //presentViewController(transift, animated: true, completion: nil);
        // prepareForSegue(transit, sender: self);
        // toViewController.transitioningDelegate = slideDownTransition
    }
    
    @IBAction func slideRightPressed(sender: AnyObject) {
        // toViewController.transitioningDelegate = slideRightTransition
    }
    
    @IBAction func topPressed(sender: AnyObject) {
        //toViewController.transitioningDelegate = popTransition
    }
    
    
    @IBAction func popPressed(sender: AnyObject) {
        //toViewController.transitioningDelegate = rotateTransition
    }
    
    
    
    
    
    
}
