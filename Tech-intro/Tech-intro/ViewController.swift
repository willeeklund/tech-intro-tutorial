//
//  ViewController.swift
//  Tech-intro
//
//  Created by Wilhelm Eklund on 02/09/15.
//  Copyright (c) 2015 Wilhelm Eklund. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageList = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.fetchAnimalList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchAnimalList() {
        // Boilerplate stuff to make network request
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration);
        let listURL = NSURL(string: "http://localhost:3000/animal_list_data")!
        let request = NSURLRequest(URL: listURL)
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if nil != error {
                print("Something went wrong fetching data. \(error)")
                return
            }
            // Parse response data as JSON and get the part we want
            var JSONError: NSError?
            if let responseDict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: &JSONError) as? NSDictionary {
                if nil != JSONError {
                    print("Something went wrong parsing JSON data. \(JSONError)")
                    return
                }
                if let animalsList = responseDict["animals"] as? Array<String> {
                    // Save list of images
                    self.imageList = animalsList
                } else {
                    print("JSON data has no 'animals' field. \(responseDict)")
                }
            }
        })
        task.resume()
    }
}

