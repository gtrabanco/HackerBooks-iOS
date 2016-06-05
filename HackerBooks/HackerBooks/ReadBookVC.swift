//
//  ReadBookVC.swift
//  HackerBooks
//
//  Created by Gabriel Trabanco Llano on 5/6/16.
//  Copyright © 2016 Gabriel Trabanco Llano. All rights reserved.
//

import UIKit

class ReadBookVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var webPDFView: UIWebView!
    
    // MARK: - Properties
    var book:Book? {
        
        didSet {
            self.updateUI()
        }
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: - Private
    func updateUI() {
        self.title = self.book?.title ?? "No book"
        
        self.webPDFView.loadRequest(NSURLRequest(URL: NSURL(string: (self.book?.pdfUrlString)!)!))
    }

}
