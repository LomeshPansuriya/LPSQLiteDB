//
//  LPAddEditViewController.swift
//  LPSQLiteDB
//
//  Created by Lomesh Pansuriya on 18/04/17.
//  Copyright © 2017 Lomesh Pansuriya. All rights reserved.
//

import UIKit

class LPAddEditViewController: UITableViewController, UITextFieldDelegate {

    var txtName:UITextField!
    var txtAddress:UITextField!
    var txtEmail:UITextField!
    var txtMobileNumber:UITextField!
    var txtRollNumber:UITextField!
    var txtCurrentTextField:UITextField!
    
    var studentInfo = LPStudentInfo()
    var viewType:LPViewType = .Add
    
    @IBOutlet weak var btnAddEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAddEditView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Init ViewController.
    
    func initAddEditView() {
        btnAddEdit.setTitle(viewType.rawValue, for: UIControlState.normal)
        switch viewType {
        case .Add:
            btnDelete.isHidden = true
            break
        case .Edit:
            btnDelete.isHidden = false
            break
        }
    }
    
    // MARK: - UIButton Action.
    
    @IBAction func onAddEdit(_ sender: Any) {
        if let textField = txtCurrentTextField {
            textField.resignFirstResponder()
        }
        if isValidate() {
            switch viewType {
            case .Add:
                processToAdd()
                break
            case .Edit:
                processToEdit()
                break
            }
        }
    }
    
    @IBAction func onDelete(_ sender: Any) {
        processToDelete()
    }
    
    // MARK: - TextField Delegate.
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        txtCurrentTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let val = textField.text {
            switch textField.tag {
            case 0: studentInfo.name = val; break
            case 1: studentInfo.address = val; break
            case 2: studentInfo.email = val; break
            case 3:
                if let intVal = Int(val) {
                    studentInfo.rollNumber = intVal
                }
                break
            case 4:
                if let intVal = Int(val) {
                    studentInfo.mobileNumber = intVal
                }
            default: break
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == txtMobileNumber.tag || textField.tag == txtRollNumber.tag {
            if (string == " ") {
                return false
            }
            // Create an `NSCharacterSet` set which includes everything *but* the digits
            let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
            // At every character in this "inverseSet" contained in the string,
            // split the string up into components which exclude the characters
            // in this inverse set
            let components = string.components(separatedBy: inverseSet)
            // Rejoin these components
            let filtered = components.joined(separator: "")  // use join("", components) if you are using Swift 1.2
            // If the original string is equal to the filtered string, i.e. if no
            // inverse characters were present to be eliminated, the input is valid
            // and the statement returns true; else it returns false
            if string == filtered {
                guard let text = textField.text else { return true }
                let newLength = text.characters.count + string.characters.count - range.length
                return newLength <= 15
            } else {
                return string == filtered
            }
        }
        return true
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! LPTextFieldCell
        
        cell.txtContent.tag = indexPath.row
        
        switch indexPath.row {
        case 0:
            txtName = cell.txtContent
            txtName.placeholder = "Enter Name"
            txtName.text = studentInfo.name
            break
        case 1:
            txtAddress = cell.txtContent
            txtAddress.placeholder = "Enter Address"
            txtAddress.text = studentInfo.address
            break
        case 2:
            txtEmail = cell.txtContent
            txtEmail.placeholder = "Enter Email Address"
            txtEmail.keyboardType = UIKeyboardType.emailAddress
            txtEmail.text = studentInfo.email
            break
        case 3:
            txtRollNumber = cell.txtContent
            txtRollNumber.placeholder = "Enter RollNumber"
            txtRollNumber.keyboardType = UIKeyboardType.decimalPad
            if viewType == .Edit {
                txtRollNumber.text = String(studentInfo.rollNumber)
            }
            break
        case 4:
            txtMobileNumber = cell.txtContent
            txtMobileNumber.placeholder = "Enter MobileNumber"
            txtMobileNumber.keyboardType = UIKeyboardType.decimalPad
            if viewType == .Edit {
                txtMobileNumber.text = String(studentInfo.mobileNumber)
            }
            break
        default:
            break
        }

        return cell
    }

    // MARK: - OtherMethods
    
    func processToAdd() {
        if studentInfo.insertIntoDB() {
            let alert = UIAlertController(title: LPConstants.alertTitle, message: AlertMessages.getMessage(at: 11), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { _ in
              _ =  self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func processToEdit() {
        if let textField = txtCurrentTextField {
            textField.resignFirstResponder()
        }
        if studentInfo.updateFromDB() {
            let alert = UIAlertController(title: LPConstants.alertTitle, message: AlertMessages.getMessage(at: 12), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { _ in
                _ =  self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func processToDelete() {
        if let textField = txtCurrentTextField {
            textField.resignFirstResponder()
        }
        let alert = UIAlertController(title: LPConstants.alertTitle, message: AlertMessages.getMessage(at: 13), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: { _ in
            if self.studentInfo.deleteIntoDB() {
                _ =  self.navigationController?.popViewController(animated: true)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - OtherMethods
    
    func isValidate() -> Bool {
         self.studentInfo.name = self.studentInfo.name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        self.studentInfo.address = self.studentInfo.address.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        self.studentInfo.email = self.studentInfo.email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if self.studentInfo.name.characters.count == 0 && self.studentInfo.address.characters.count == 0 &&
            self.studentInfo.email.characters.count == 0 && txtRollNumber.text?.characters.count == 0 && txtMobileNumber.text?.characters.count == 0 {
            showAlert(message: AlertMessages.getMessage(at: 1))
            return false
        }
        
        if self.studentInfo.name.characters.count == 0 {
            showAlert(message: AlertMessages.getMessage(at: 2))
            return false
        } else if !Utility.shared.isValidUserName(userName: self.studentInfo.name) {
            showAlert(message: AlertMessages.getMessage(at: 3))
            return false
        } else if self.studentInfo.address.characters.count == 0 {
            showAlert(message: AlertMessages.getMessage(at: 4))
            return false
        } else if self.studentInfo.email.characters.count == 0 {
            showAlert(message: AlertMessages.getMessage(at: 5))
            return false
        } else if !Utility.shared.isValidEmail((txtEmail!.text)!) {
            showAlert(message: AlertMessages.getMessage(at: 6))
            return false
        } else if txtRollNumber.text?.characters.count == 0 {
            showAlert(message: AlertMessages.getMessage(at: 7))
            return false
        } else if txtMobileNumber.text?.characters.count == 0 {
            showAlert(message: AlertMessages.getMessage(at: 8))
            return false
        } else if txtMobileNumber!.text!.characters.count < 10 || txtMobileNumber!.text!.characters.count > 15 {
            self.showAlert(message: AlertMessages.getMessage(at:9))
            return false
        }
        
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
