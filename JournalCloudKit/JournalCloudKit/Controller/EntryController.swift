//
//  EntryController.swift
//  JournalCloudKit
//
//  Created by Hin Wong on 3/30/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import CloudKit

class EntryController {
    
    //MARK: - SOURCE OF TRUTH AND SHARED INSTANCE
    
    static let shared = EntryController()
    var entries: [Entry] = []
    let privateDB = CKContainer.default().privateCloudDatabase
    
    //MARK: - CRUD
    
    func createEntryWith(title: String, body: String, completion: @escaping(_ result:Result<Entry?, EntryError>) -> Void) {
        
        let entry = Entry(title: title, body: body)
        entries.append(entry)
    }
    
    func saveEntry(entry: Entry, completion: @escaping (_ result: Result<Entry?, EntryError>) -> Void) {
       
        let record = CKRecord(entry: entry)
        CKContainer.default().privateCloudDatabase.save(record) { (record, error) in
            
            //error handling
            if let error = error {
                print(error, error.localizedDescription)
                completion(.failure(.ckError(error)))
            }
            
            // data handling
            guard let record = record,
                let entry = Entry(ckRecordID: record) else {return completion(.failure(.couldNotUnwrap))}
            self.entries.insert(entry, at: 0)
            return completion(.success(entry))
        }
        
    }
    
    func fetchEntriesWith(completion: @escaping(_ result: Result<[Entry]?, EntryError>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryConstants.RecordType, predicate: predicate)
        CKContainer.default().privateCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            // error handling
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.ckError(error)))
            }
            
            // data handling
            guard let records = records else {return completion(.failure(.couldNotUnwrap))}
            let entries: [Entry] = records.compactMap(Entry.init(ckRecordID:))
            
            self.entries = entries
            return completion(.success(entries))
        }
    }
    
    
    
}
