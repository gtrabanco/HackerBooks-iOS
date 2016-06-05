//
//  Library.swift
//  HackerBooks
//
//  Created by Gabriel Trabanco Llano on 24/12/15.
//  Copyright © 2015 Gabriel Trabanco Llano. All rights reserved.
//

import Foundation

class Library:Indexable, GeneratorType, SequenceType, CustomStringConvertible {
    
    //Errors
    enum LibraryError:ErrorType {
        case NoIndex
    }
    
    private var books: [Book] = []

    
    
    //MARK: - Initializers
    
    init() {}
    
    convenience init(book: Book...) {
        self.init()
        self.addNew(book)
    }
    
    convenience init(books: [Book]) {
        self.init()
        self.addNew(books)
    }
    
    convenience init(book: strictBook...) {
        self.init()
        self.addNew(book)
    }
    
    convenience init(books: [strictBook]) {
        self.init()
        self.addNew(books)
    }
    
    //MARK: - Methods
    
    
    func addNew(book: Book...) {
        for b in book {
            self.books.append(b)
        }
    }
    
    func addNew(books: [Book]) {
        for b in books {
            self.addNew(b)
        }
    }
    
    func addNew(book: strictBook...) {
        for b in book {
            self.books.append(Book(book: b))
        }
    }
    
    func addNew(books: [strictBook]) {
        for b in books {
            self.addNew(b)
        }
    }
    
    
    
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return self.books.count
    }
    
    
    
    
    //MARK: - Indexable
    typealias Index = Int
    typealias _Element = Book
    
    var startIndex:Index {
        return 0
    }
    
    var endIndex:Index {
        return self.books.count - 1
    }
    
    subscript(position: Index) -> _Element {
        get {
            return self.books[position]
        }
    }
    
    //MARK: - GeneratorType
    typealias Element = _Element
    
    var currentIndex = 0
    
    func next() -> Element? {
        let el = self.books[currentIndex]
        currentIndex = currentIndex + 1
        return el
    }
    
    
    //MARK: - SequenceType
    typealias Generator = AnyGenerator<Book>
    
    func generate() -> Generator {
        return AnyGenerator(body: self.next)
    }
    
    //MARK: - CustomStringConvertible
    var description:String {
        get {
            for b in self.books {
                print(b)
            }
            
            return "\(self.dynamicType) with \(self.books.count) books"
        }
    }
}