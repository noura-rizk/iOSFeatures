//
//  ytVC.swift
//  FeaturesApp
//
//  Created by Noura Rizk on 1/11/16.
//  Copyright © 2016 Noura Rizk. All rights reserved.
//https://github.com/gilesvangruisen/Swift-YouTube-Player#carthage
//http://www.appcoda.com/youtube-api-ios-tutorial/
//https://github.com/youtube/youtube-ios-player-helper another api

import UIKit
import YouTubePlayer
class ytVC: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var playerView: YouTubePlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            //revealViewController().rearViewRevealWidth = 62
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
           view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let myVideoURL = NSURL(string: "https://www.youtube.com/watch?v=wQg3bXrVLtg")
        playerView.loadVideoURL(myVideoURL!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
