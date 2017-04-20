//
//  UIViewController.swift
//  VenueStreet
//
//  Created by Geekyworks Pvt. Ltd. on 2/21/16.
//  Copyright © 2016 Geekyworks Pvt. Ltd. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(message msg: String) {
        let alert = UIAlertController(title: LPConstants.alertTitle, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
