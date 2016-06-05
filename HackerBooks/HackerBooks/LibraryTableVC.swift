//
//  LibraryTableVC.swift
//  HackerBooks
//
//  Created by Gabriel Trabanco Llano on 8/1/16.
//  Copyright © 2016 Gabriel Trabanco Llano. All rights reserved.
//

import UIKit

class LibraryTableVC: UITableViewController {
    
    var model:Library = Library()
    var bookViewController:BookViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load the model
        self.loadModel()
        
        //Appearance
        self.proxyForAppearance()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.bookViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? BookViewController
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.model.numberOfSections()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.numberOfRowsInSection()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "bookCellId"
        let cell:UITableViewCell
        if let c = tableView.dequeueReusableCellWithIdentifier(cellId) {
            cell = c
        } else {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        }

        // Configure the cell...
        
        let book = self.model[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.authors
        cell.imageView?.image = book.image
        cell.accessoryType = .DisclosureIndicator

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //First check if it is the segure we want
        if segue.identifier! == "BookViewController" {
            
            //print("Trying to make the segue \(segue.identifier)")
            //print(segue.destinationViewController.dynamicType)
            
            //If there is a selected row make it work
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let book = self.model[indexPath.row]
                let controller = segue.destinationViewController as? BookViewController
                controller?.book = book
                controller?.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller?.navigationItem.leftItemsSupplementBackButton = true
                
            }
        }
    }
    
    
    //MARK: - Private methods
    func loadModel() {
        do {
            
            let json = try Storage.get(stringURL: "https://keepcodigtest.blob.core.windows.net/containerblobstest/books_readable.json", storeType: .StorageDocuments)
            let jsonObjBooks = try decode(json.data)
            self.model = Library(books: jsonObjBooks)
        } catch {
            
            fatalError("Errors loading the model")
        }
    }
    
    func proxyForAppearance() {
        self.navigationController?.navigationBar.opaque = true
    }
}
