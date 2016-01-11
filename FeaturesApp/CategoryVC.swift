//
//  CategoryVC.swift
//  FeaturesApp
//
//  Created by Noura Rizk on 1/10/16.
//  Copyright © 2016 Noura Rizk. All rights reserved.
//

import UIKit
import CoreData
class CategoryVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var items = [Items]();
    @IBOutlet weak var tblView: UITableView!;
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self;
        tblView.dataSource = self;
        if revealViewController() != nil {
            //revealViewController().rearViewRevealWidth = 62
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults();
        tblView.reloadData();
    }
    
    func fetchAndSetResults(){
        //print("readData");
        let app = UIApplication.sharedApplication().delegate as! AppDelegate;
        let context = app.managedObjectContext;
        let fetchReq = NSFetchRequest(entityName: "Items");
        do{
            let results = try context.executeFetchRequest(fetchReq);
            self.items = results as! [Items];
          //  print("COUNTTT\(self.items.count)");
            
        }catch let err as NSError{
            print( err.debugDescription);
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tblView.dequeueReusableCellWithIdentifier("catCell") as? CatCell{
            var item = items[indexPath.row]
            cell.lblCat.text = item.arName;
            return cell;
        }else
        {
            return UITableViewCell();
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("COUN\(self.items.count)");
        return items.count
    }
    
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        
        
    }
    
    
    
}
