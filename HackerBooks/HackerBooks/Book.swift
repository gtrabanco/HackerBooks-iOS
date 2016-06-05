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

//MARK: - BookKeys
//Those avaible keys to search by
enum BookKeys:String {
    case authors
    case tags
    case title
}

class Book {
    
    //MARK: - Properties
    let authors:String
    let imageUrlString:String
    let pdfUrlString:String
    let tags:Tags
    let title:String
    
    
    //MARK: - Calculated properties
    var imageData:NSData? {
        get {
            do {
                let result = try Storage.get(stringURL: self.imageUrlString, storeType: .StorageDocuments)
                return result.data
            } catch {
                return nil
            }
        }
    }
    
    var image:UIImage {
        get {
            if let data = self.imageData, img = UIImage(data: data) {
                return img
            }
            
            return UIImage(named: "noImage")!
        }
    }
    
    var pdfData:NSData? {
        get {
            do {
                let result = try Storage.get(stringURL: self.pdfUrlString, storeType: .StorageDocuments)
                return result.data
                
            } catch {
                return nil
            }
        }
    }
    
    
    init(title: String, authors: String, imageUrl: String, pdfUrl: String, tags: Tags) {
        self.title = title
        self.authors = authors
        self.imageUrlString = imageUrl
        self.pdfUrlString = pdfUrl
        self.tags = tags
    }
    
    convenience init(book: strictBook) {
        self.init(title: book.title, authors: book.authors, imageUrl: book.imageUrlString, pdfUrl: book.pdfUrlString, tags: book.tags)
    }
}


//MARK: - Equatable

extension Book:Equatable {
    
    //MARK: - Comparison Proxy
    func proxyForComparison() -> String {
        
        let tags = self.tags.joinWithSeparator(", ")
        
        return "\(self.title)\(self.authors)\(tags)"
    }
}

func ==(lhs: Book, rhs: Book) -> Bool {
    
    guard lhs !== rhs else {
        return false
    }
    
    guard lhs.dynamicType == rhs.dynamicType else {
        return false
    }
    
    return lhs.proxyForComparison() == rhs.proxyForComparison()
}


//MARK: - Comparable

extension Book:Comparable {
    func proxyForSorting()->String {
        return "\(self.title)\(self.authors)"
    }
}

func <(lhs: Book, rhs: Book) -> Bool {
    
    return lhs.proxyForSorting() < rhs.proxyForSorting()
}

func >(lhs: Book, rhs: Book) -> Bool {
    return lhs.proxyForSorting() > rhs.proxyForSorting()
}

//MARK: - CustomStringConvertible
extension Book:CustomStringConvertible {
    var description:String {
        get {
            return "<\(self.dynamicType): \(self.title) \(self.authors)>"
        }
    }
}
