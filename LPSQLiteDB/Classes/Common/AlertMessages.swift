//
//  AlertMessages.swift
//  VenueStreet
//
//  Created by Geekyworks Pvt. Ltd. on 2/21/16.
//  Copyright © 2016 Geekyworks Pvt. Ltd. All rights reserved.
//

import Foundation

class AlertMessages {
    /// Get message string with index
    class func getMessage(at index: Int) -> String {
        switch index {

        // MARK: - Student Add Or Edit Validation.

        case 1 : return "Please, fill all the required fields."
        case 2 : return "Please, Enter name."
        case 3 : return "Please, Enter only character in name."
        case 4 : return "Please, Enter address."
        case 5 : return "Please, Enter email."
        case 6 : return "Please, Enter valid email."
        case 7 : return "Please, Enter roll number."
        case 8 : return "Please, Enter mobile number."
        case 9 : return "Please, Enter Phone number (Min. 10 characters and Max. 15 characters)."
        case 10 : return "User Already Exist."
        case 11 : return "Congratulations, you have successfully registered."
        case 12 : return "Your student information has been updated successfully."
        case 13 : return "Are you sure, You want to delete this student."
            
        default:
            return "Oops! Something went wrong! Please try again or contact customer care."
        }
    }
}
