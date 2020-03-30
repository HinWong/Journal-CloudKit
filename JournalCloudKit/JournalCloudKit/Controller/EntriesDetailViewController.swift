//
//  EntriesDetailViewController.swift
//  JournalCloudKit
//
//  Created by Hin Wong on 3/30/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class EntriesDetailViewController: UIViewController {

    @IBOutlet weak var entriesTitleLabel: UITextField!
    @IBOutlet weak var entriesBodyText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        entriesBodyText.text = ""
        entriesTitleLabel.text = ""
    }
    
}
