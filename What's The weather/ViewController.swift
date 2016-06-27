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
class ViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet var userInputCity: UITextField!
    
    var valueCity:String = ""
    
    @IBOutlet var weatherSummary: UILabel!
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
        
        if (finalURL != nil) {
            let task = NSURLSession.sharedSession().dataTaskWithURL(finalURL!) { (data, response, error) -> Void in
            //Will happen when task completes.
            if let UrlContent = data {
                let webContent = NSString(data: UrlContent, encoding: NSUTF8StringEncoding)
                let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if websiteArray.count >  1 {
                    let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                    
                    if weatherArray.count > 1 {
                        let weatherSum = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString:"º" )
                        dispatch_async(dispatch_get_main_queue(), {
                            self.weatherSummary.text = weatherSum
                        })
                    }
                }
                else
                {
                    self.weatherSummary.text = "Please Enter a Valid City"
                }
                
                
            }
            else
            {
                print(error)
            }
        }
        task.resume()
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userInputCity.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
     
    }
    
    //if user presses outside of the keyboard, it hides
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    //if user presses the return it should disappear
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

}

