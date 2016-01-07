//
//  Book.swift
//  HackerBooks
//
//  Created by Gabriel Trabanco Llano on 9/12/15.
//  Copyright © 2015 Gabriel Trabanco Llano. All rights reserved.
//

import UIKit


/*
{
"authors": "David J.C. MacKay",
"image_url": "http://hackershelf.com/media/cache/84/e9/84e9b9e250c917f926f1762aabdd5d83.jpg",
"pdf_url": "http://www.inference.phy.cam.ac.uk/itprnn/book.pdf",
"tags": "information theory, learning algorithms",
"title": "Information Theory, Inference, and Learning Algorithms "
}
*/

typealias Tag = String
typealias Tags = [Tag]

struct strictBook {
    let authors:String
    let imageUrlString:String
    let pdfUrlString:String
    let tagsStr:String
    var tags:[String] {
        get {
            return self.tagsStr.componentsSeparatedByString(", ")
        }
    }
    let title:String
}

struct JSONBookKeys {
    static let authors  = "authors"
    static let imageURL = "image_url"
    static let pdfURL   = "pdf_url"
    static let tags     = "tags"
    static let title    = "title"
}

typealias JSONObject = [String:AnyObject]
typealias JSONArray  = [JSONObject]


enum JSONError:ErrorType {
    case NoData
    case MalFormatted
}


func decode(jsonData:NSData) throws -> [strictBook] {
    
    guard let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as? JSONArray else {
        throw JSONError.NoData
    }
    
    return try json.map({ (jsonObj) throws -> strictBook in
        guard let authors = jsonObj[JSONBookKeys.authors] as? String,
        imageURL = jsonObj[JSONBookKeys.imageURL] as? String,
        pdfURL = jsonObj[JSONBookKeys.pdfURL] as? String,
        tags = jsonObj[JSONBookKeys.tags] as? String,
        title = jsonObj[JSONBookKeys.title] as? String  else {
            //fatalError("JSON Object Error: Formatted of JSON is not correct")
            throw JSONError.MalFormatted
        }
        
        return strictBook(authors: authors, imageUrlString: imageURL, pdfUrlString: pdfURL, tagsStr: tags, title: title)
    })
}

//func decode(storage: (filepath: NSURL, data: NSData)) throws -> Library {}
