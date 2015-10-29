//
//  MasterViewController.swift
//  Grand Central Dispatch
//
//  Created by Yohannes Wijaya on 10/29/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = Array<Dictionary<String, String>>()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
        guard let url = NSURL(string: urlString) else { return }
        guard let data = try? NSData(contentsOfURL: url, options: []) else { return }
        let jsonObject = JSON(data: data)
        guard jsonObject["metadata"]["responseInfo"]["status"].intValue == 200 else { return }
        self.parseJSON(jsonObject)
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row] 
        cell.textLabel!.text = object["title"]
        cell.detailTextLabel!.text = object["body"]
        return cell
    }
    
    // MARK: - Local Methods
    
    func parseJSON(jsonObject: JSON) {
        for result in jsonObject["results"].arrayValue {
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let signature = result["signatureCount"].stringValue
            let jobj = ["title": title, "body": body, "signature": signature]
            self.objects.append(jobj)
        }
        self.tableView.reloadData()
    }

}

