//
//  ViewController.swift
//  What's The weather
//
//  Created by Oludemilade Raji on 6/24/16.
//  Copyright © 2016 Don Rajon Media. All rights reserved.
//

import UIKit

extension NSString {
    func condenseWhitespace() -> String {
        let components = self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return components.filter { !$0.isEmpty }.joinWithSeparator(" ")
    }
}
var finalURL = NSURL(string: "")
class ViewController: UIViewController {
    
    
    
    @IBOutlet var userInputCity: UITextField!
    
    var valueCity:String = ""
    
    @IBAction func checkWeather(sender: AnyObject) {
        let url1 = "http://www.weather-forecast.com/locations/"
        let url2 = "/forecasts/latest"
        
        var newTypeString = NSString(string: userInputCity.text!)
        
        newTypeString = newTypeString.stringByReplacingOccurrencesOfString(".", withString: " ")
        
        newTypeString = newTypeString.stringByTrimmingCharactersInSet( NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        newTypeString = newTypeString.condenseWhitespace()
        
        newTypeString = newTypeString.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).joinWithSeparator("-")
        
        valueCity = String(newTypeString).condenseWhitespace()
        
        let url3 = url1 + valueCity + url2
        finalURL = NSURL(string: url3)!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(finalURL!) { (data, response, error) -> Void in
            //Will happen when task completes.
            if let UrlContent = data {
                let webContent = NSString(data: UrlContent, encoding: NSUTF8StringEncoding)
                
                
                print(webContent)
                
                /* //Sometimes Queue takes a long time. We can force the queue to display
                 dispatch_async(dispatch_get_main_queue(), {
                 self.webView.loadHTMLString(String(webContent!), baseURL: nil)
                 })*/
                
            }
            else
            {
                print(error)
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

