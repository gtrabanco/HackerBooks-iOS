//
//  Storage.swift
//  HackerBooks
//
//  Created by Gabriel Trabanco Llano on 12/12/15.
//  Copyright © 2015 Gabriel Trabanco Llano. All rights reserved.
//

import Foundation

/**
 * With this we create files based on a checksum from a String
 */

class Storage {
    
    enum StorageError:ErrorType {
        case NotURL
        case NotLocalURL
        case URLCouldNotBeenInitialized
        case URLReqFailed
        case NotDocumentsDirFound
        case NotFound
    }
    
    enum StorageType {
        case NoStorageNoCache
        case StorageDocuments
    }
    
    static var documents:NSURL? {
        get {
            if let documentsDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as String? {
                return NSURL(string: documentsDir)
            }
            
            return nil
        }
    }
    

    //Get a file from url and store it locally if not exists
    //Returning the NSURL to the local file and data as Set
    static func get(stringURL strUrl:String?, storeType:StorageType = .NoStorageNoCache) throws -> (filepath: NSURL, data: NSData) {
        
        var result:NSData
        
        guard let strUrl = strUrl, url = NSURL(string: strUrl) else {
            throw StorageError.NotURL
        }
        
        //Create the filepath to the local stored file
        let filepath = try getLocalFileForURL(strUrl)
        
        //Create the file manager
        let fm = NSFileManager.defaultManager()
        
        //Check if we need to download the data
        if storeType == StorageType.NoStorageNoCache || !fm.fileExistsAtPath(filepath.path!) {
            result = NSData(contentsOfURL: url)!
        } else {
            result = NSData(contentsOfURL: filepath)!
        }
        
        //Now if we have to store the file in the disk store it
        if storeType != StorageType.NoStorageNoCache {
            self.save(filepath, data: result)
        }
        
        
        return (filepath, result)
    }
    
    
    //MARK: - Private methods
    
    //Create a local url where the url file will be stored locally
    static private func getLocalFileForURL(strUrl:String?) throws -> NSURL {
        
        guard let strUrl = strUrl else {
            throw StorageError.NotURL
        }
        
        guard let url = NSURL(string: strUrl) else {
            throw StorageError.URLCouldNotBeenInitialized
        }
        
        
        if let file = url.lastPathComponent, documents = self.documents {
            return documents.URLByAppendingPathComponent(file)
        }
        
        //Is supposed the we will never be here
        throw StorageError.NotLocalURL
    }
    
    static private func save(filepath:NSURL, data:NSData) {
        
        let fm = NSFileManager.defaultManager()
        fm.createFileAtPath(filepath.path!, contents: data, attributes: [String:AnyObject]())
    }
    
}