//
//  ViewController.swift
//  weatherCheck
//
//  Created by Ekrem Doğan on 13.01.2015.
//  Copyright (c) 2015 Ekrem Doğan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var city: UITextField!
    @IBOutlet var message: UILabel!
    @IBAction func buttonPressed(sender: AnyObject) {
        
        var urlString = "http://www.weather-forecast.com/locations/" + city.text.stringByReplacingOccurrencesOfString(" ", withString: "") + "/forecasts/latest"
        var url = NSURL(string: urlString)
        
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) {(data, response, error) in
            if error == nil {
                var html = NSString(data: data, encoding: NSUTF8StringEncoding)
                if ((html?.containsString("<span class=\"phrase\">")) != false) {
                    
                    var htmlArray = html?.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    var firstHalf = htmlArray?[1] as? NSString
                    var secondHalf = firstHalf?.componentsSeparatedByString("</span>")
                    var result = secondHalf?[0].stringByReplacingOccurrencesOfString("&deg;", withString: "°")
                    dispatch_async(dispatch_get_main_queue(), {
                        self.message.text = result
                    })
                    
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.message.text = "couldn't find city, try again."
                    })
                }
            }
        }
        
        task.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

