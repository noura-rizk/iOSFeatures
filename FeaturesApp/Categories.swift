//
//  Categories.swift
//  FeaturesApp
//
//  Created by Noura Rizk on 1/6/16.
//  Copyright © 2016 Noura Rizk. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class Categories {
    
    private var _arName: String!;
    private var _enName: String!;
    
    var arName:String{
        return _arName
    }
    
    var enName: String{
        return _enName
    }
    
    
    
    func downloadAllCategories(completed: DownloadComplete) {
        //print("hre");
        let urlStr = "\(URL_BASE)\(URL_CATS)";
        print(urlStr);
        let url = NSURL(string: urlStr)!;
        let app = UIApplication.sharedApplication().delegate as! AppDelegate;
        let context = app.managedObjectContext;
        let entity = NSEntityDescription.entityForName("Items", inManagedObjectContext: context)!;
        
        Alamofire.request(.GET, url).responseJSON { response in
            if let JSON = response.result.value {
               // print("JSON: \(JSON)")
                if let dicts = JSON as? [Dictionary<String, AnyObject>]{
                    print(dicts.count);
                    for dict in dicts {
                        let cat = Items(entity: entity, insertIntoManagedObjectContext: context);
                        if let englishName = dict["EnglishName"] as? String{
                            cat.enName = englishName;
                        }
                        if let name = dict["Name"] as? String{
                            //self._arName = name;
                            cat.arName = name;
                        }
                        context.insertObject(cat);
                        do{
                            try context.save();
                        }catch{
                            print("Coudn't save recipe");
                        }
                    }
                    completed();
                }// if dic
                else{
                    print("NOT INSIDE")
                }
                
            }// if json
            
        }// alamo
        
    }// service
}