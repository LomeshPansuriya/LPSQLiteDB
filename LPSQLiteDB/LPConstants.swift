//
//  LPConstants.swift
//  LPSQLiteDB
//
//  Created by Lomesh Pansuriya on 18/04/17.
//  Copyright © 2017 Lomesh Pansuriya. All rights reserved.
//

import UIKit

enum LPViewType: String {
    case Add = "Add", Edit = "Update"
}

class LPConstants: NSObject {

    static let alertTitle = "LPSQLite"
    
    struct segueIdentifiers {
        static let addEditView = "segueToAddEditView"
    }
}
