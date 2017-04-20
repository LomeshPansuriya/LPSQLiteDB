//
//  LPTables.swift
//  LPSQLiteDB
//
//  Created by Lomesh Pansuriya on 18/04/17.
//  Copyright © 2017 Lomesh Pansuriya. All rights reserved.
//

import UIKit
import SQLite

class LPTables: NSObject {

    struct Student {
        static let tblStudent = Table("student_master")
        static let id = Expression<Int>("sid")
        static let name = Expression<String>("name")
        static let address = Expression<String>("address")
        static let email = Expression<String>("email")
        static let rollNo = Expression<Int>("rollno")
        static let mobileNo = Expression<Int>("mobileno")
    }
    
}
