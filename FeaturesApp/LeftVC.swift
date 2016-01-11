//
//  LeftVC.swift
//  FeaturesApp
//
//  Created by Noura Rizk on 1/10/16.
//  Copyright © 2016 Noura Rizk. All rights reserved.
//

import UIKit

class LeftVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblView: UITableView!;
    var titles = ["Home","Categories", "Video", "item3"];
    var images = ["","news.png", "photo.png", "tag.png"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.dataSource = self;
        tblView.delegate = self;
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tblView.dequeueReusableCellWithIdentifier("menuCell") as? menuCell{
            cell.lblTitle.text = titles[indexPath.row];
            if indexPath.row != 0 {
                cell.imgIcon.image = UIImage(named: images[indexPath.row]);
            }else{
                cell.imgIcon.hidden = true;
            }
            return cell;
        }else
        {
            return UITableViewCell();}
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("index=\(indexPath.row)")
        if(indexPath.row == 0){
            self.performSegueWithIdentifier("homeSegue", sender: self)
        }
        else if(indexPath.row == 1){
            self.performSegueWithIdentifier("catSegue", sender: self)
        }else if (indexPath.row == 2){
            self.performSegueWithIdentifier("vedioSegue", sender: self)
        }
        
    }
}
