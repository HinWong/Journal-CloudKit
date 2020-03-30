//
//  Entry.swift
//  JournalCloudKit
//
//  Created by Hin Wong on 3/30/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import CloudKit

//MARK: - CONSTANTS

struct EntryConstants {
    
    static let TitleKey = "title"
    static let BodyKey = "body"
    static let TimestampKey = "timestamp"
    static let RecordType = "Entry"
}

// MARK: - MODEL

class Entry {
    
    let title: String
    let body: String
    let timestamp: Date
    let ckRecordID: CKRecord.ID
    
    init(title: String, body: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
}

extension Entry {
    
    convenience init?(ckRecordID: CKRecord) {
        guard let title = ckRecordID["title"] as? String,
            let body = ckRecordID["body"] as? String,
            let timestamp = ckRecordID["timestamp"] as? Date
            else { return nil }
        
        self.init(title: title, body: body, timestamp: timestamp)
    }
}

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryConstants.RecordType, recordID: entry.ckRecordID)
        
        self.setValuesForKeys([EntryConstants.TitleKey: entry.title,
                               EntryConstants.BodyKey: entry.body,
                               EntryConstants.TimestampKey: entry.timestamp])
    }
}
