//
//  LPStudentInfo.swift
//  LPSQLiteDB
//
//  Created by Lomesh Pansuriya on 18/04/17.
//  Copyright © 2017 Lomesh Pansuriya. All rights reserved.
//

import UIKit

class LPStudentInfo: NSObject {

    lazy var id: Int = 0
    lazy var name: String = ""
    lazy var address: String = ""
    lazy var email: String = ""
    lazy var rollNumber: Int = 0
    lazy var mobileNumber: Int = 0

    func insertIntoDB() -> Bool {
        return LPDBManager.sharedInstance.insertStudent(studentInfo: self)
    }
    
    func updateFromDB() -> Bool {
        return LPDBManager.sharedInstance.updateStudent(studentInfo: self)
    }
    
    func deleteIntoDB() -> Bool {
        return LPDBManager.sharedInstance.deleteStudent(id: id)
    }
    
}

class LPStudents: NSObject {
    
    var studentList: Array<LPStudentInfo> = Array<LPStudentInfo>()
    
    override init() {
        super.init()
        loadFromDB()
    }
    
    func loadFromDB() {
        //"SELECT * FROM student_master"
        do {
            for student in try LPDBManager.sharedInstance.db.prepare(LPTables.Student.tblStudent) {
                let studentInfo = LPStudentInfo()
                studentInfo.id = student[LPTables.Student.id]
                studentInfo.name = student[LPTables.Student.name]
                studentInfo.address = student[LPTables.Student.address]
                studentInfo.email = student[LPTables.Student.email]
                studentInfo.rollNumber = student[LPTables.Student.rollNo]
                studentInfo.mobileNumber = student[LPTables.Student.mobileNo]
                self.studentList.append(studentInfo)
            }
        }
        catch {
            print("Exception")
        }
    }
}
