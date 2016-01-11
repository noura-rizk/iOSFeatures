//
//  TransitController.swift
//  FeaturesApp
//
//  Created by Noura Rizk on 1/6/16.
//  Copyright © 2016 Noura Rizk. All rights reserved.
//

import UIKit
import Alamofire
class TransitController: UIViewController {


    @IBOutlet weak var pdfWebView: UIWebView!
    @IBOutlet weak var progressView: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let pdf = NSBundle.mainBundle().URLForResource("myfile", withExtension: "pdf", subdirectory: nil, localization: nil)  {
            let req = NSURLRequest(URL: pdf)
            pdfWebView.loadRequest(req);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }



    @IBAction func downloadPdf(sender: AnyObject) {
        
        var fileName: String!
        var finalPath: NSURL!
        
        Alamofire.download(.GET, "http://box2d.org/manual.pdf") { temporaryURL, response in
            let fileManager = NSFileManager.defaultManager()
            let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            let pathComponent = response.suggestedFilename
            fileName = pathComponent;
            print(pathComponent);
            finalPath = directoryURL.URLByAppendingPathComponent(pathComponent!)
            return finalPath;
            }
            .progress{ bytesRead, totalBytesRead, totalBytesExpectedToRead in
                dispatch_async(dispatch_get_main_queue()) {
                    //    print("Total bytes read on main queue: \(totalBytesRead)")
                    let x = Float(totalBytesRead);
                    let y = Float(totalBytesExpectedToRead)
                    let progress = Float(x / y);
                   // print(progress)
                    self.progressView.setProgress(progress, animated: true);
                    if(progress == 1.0){
                       // print(finalPath);
                       
                       /* if let pdf = NSBundle.mainBundle().URLForResource(fileName, withExtension: "pdf", subdirectory: nil, localization: nil)  {
                            let req = NSURLRequest(URL: finalPath);
                            self.pdfWebView.loadRequest(req);
                        }*/
                        //self.pdfWebView.loadRequest();
                    }
                }
            }
            .response { request, response, data, error in
                print("request-=\(request)");
                print("RESPONSEEE\(response)");
                print("data\(data)");
                if let error = error {
                    print("Failed with error: \(error)")
                } else {
                    print("Downloaded file successfully")
                    let req = NSURLRequest(URL: finalPath);
                    self.pdfWebView.loadRequest(req);
                }
        }
        
       /* let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
        print(destination)
        Alamofire.download(.GET, "http://box2d.org/manual.pdf", destination: destination)
            .progress{ bytesRead, totalBytesRead, totalBytesExpectedToRead in
                dispatch_async(dispatch_get_main_queue()) {
                //    print("Total bytes read on main queue: \(totalBytesRead)")
                    var x = Float(totalBytesRead);
                    var y = Float(totalBytesExpectedToRead)
                    var progress = Float(x / y);
                    print(progress)
                    self.progressView.setProgress(progress, animated: true);
                    if(progress == 1.0){
                    //self.pdfWebView.loadRequest();
                    }
                }
            }
            .response { _, _, _, error in
                if let error = error {
                    print("Failed with error: \(error)")
                } else {
                    print("Downloaded file successfully")
                }
        }*/
        
    }
}
