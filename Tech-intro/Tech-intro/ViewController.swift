//
//  ViewController.swift
//  Tech-intro
//
//  Created by Wilhelm Eklund on 02/09/15.
//  Copyright (c) 2015 Wilhelm Eklund. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableview: UITableView!
    var imageList = Array<String>() {
        didSet {
            dispatch_async(dispatch_get_main_queue(), {
                self.tableview.reloadData()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableview.delegate = self
        self.tableview.dataSource = self
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
                    println("animalsList has \(animalsList.count) images")
                } else {
                    print("JSON data has no 'animals' field. \(responseDict)")
                }
            }
        })
        task.resume()
    }
    
    // MARK: - Table view methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "tableCell"
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if nil == cell {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        let imagePath = self.imageList[indexPath.row]
        cell?.textLabel?.text = "Image \(indexPath.row): \(imagePath)"
        // Show the image, but load in background queue
        let backgroundQueue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
        dispatch_async(backgroundQueue) {
            if let url = NSURL(string: imagePath) {
                if let data = NSData(contentsOfURL: url) {
                    dispatch_async(dispatch_get_main_queue(), {
                        // Update table cell in main queue
                        cell?.textLabel?.text = "Image \(indexPath.row)"
                        cell?.imageView?.image = UIImage(data: data)
                        cell?.setNeedsDisplay()
                        println("Got image \(indexPath.row)")
                    })
                }
            }
        }
        return cell!
    }
}

