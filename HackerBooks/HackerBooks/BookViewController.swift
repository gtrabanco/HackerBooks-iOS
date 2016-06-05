//
//  BookViewController.swift
//  HackerBooks
//
//  Created by Gabriel Trabanco Llano on 8/1/16.
//  Copyright © 2016 Gabriel Trabanco Llano. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    // MARK - Properties
    var book:Book? {
        didSet {
            self.updateUI()
        }
    }
    
    
    // MARK: - Outlets

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var favoritedImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    // MARK: - Actions
    @IBAction func readActionButton(sender: UIButton) {
        
    }
    
    // MARK: - Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ReadBooKViewController" {
            //let destinationVC = sender?.destinationViewController as? ReadBookVC
        }
    }
    
    
    // MARK: - UpdateUI
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Private
    private func updateUI() {
        
        //Check that the book is not empty
        if let book = self.book {
            if let coverImg = self.coverImage, titleTxt = self.titleLabel, authorsLbl = self.authorLabel, tagsLbl = self.tagsLabel {
                
                self.title = book.title
                titleTxt.text = book.title
                coverImg.image = book.image
                authorsLbl.text = book.authors
                tagsLbl.text = book.tags.joinWithSeparator(", ")
            }
        }
    }

}
