//
//  Library.swift
//  HackerBooks
//
//  Created by Gabriel Trabanco Llano on 24/12/15.
//  Copyright © 2015 Gabriel Trabanco Llano. All rights reserved.
//

import Foundation

class Library:Indexable, GeneratorType, SequenceType {
    
    //Memory optimization to avoid ARC Errors
    //Read it in Swift book
    class BookWeak {
        weak var book:Book?
        
        init(book: Book) {
            self.book = book
        }
        
        deinit {
            self.book = nil
        }
    }
    
    //Errors
    enum LibraryError:ErrorType {
        case NoIndex
    }
    
    private var books: [BookWeak] = []
    
    
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
            self.books.append(Library.BookWeak(book: b))
        }
    }
    
    func addNew(books: [Book]) {
        for b in books {
            self.addNew(b)
        }
    }
    
    func addNew(book: strictBook...) {
        for b in book {
            self.addNew(Book(book: b))
        }
    }
    
    func addNew(books: [strictBook]) {
        for b in books {
            self.addNew(b)
        }
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
            return self.books[position].book!
        }
    }
    
    //MARK: - GeneratorType
    typealias Element = _Element
    
    var currentIndex = 0
    
    func next() -> Element? {
        guard let element = self.books[currentIndex++].book else {
            return nil
        }
        
        return element
    }
    
    
    //MARK: - SequenceType
    typealias Generator = AnyGenerator<Book>
    
    func generate() -> Generator {
        return anyGenerator(self.next)
    }
}