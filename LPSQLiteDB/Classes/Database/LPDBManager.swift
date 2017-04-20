//
//  LPDBManager.swift
//  LPSQLiteDB
//
//  Created by Lomesh Pansuriya on 18/04/17.
//  Copyright © 2017 Lomesh Pansuriya. All rights reserved.
//

import UIKit
import SQLite

class LPDBManager: NSObject {
    static let sharedInstance = LPDBManager()
    
    var db: Connection = try! Connection("")
    var isConnected:Bool = false
    
    override init() {
        super.init()
        
        if copyDefaultDatabase(dbname: "MyDatabase.db") {
            db = try! Connection(getDatabasePath(dbname: "MyDatabase.db"))
            print("Database : \(db)")
            if db.handle != nil {
                isConnected = true
            }
        }
        
        // Create
        if self.isConnected {
            self.createTables()
        }
    }
    
    // Create Tables
    func createTables() {
        do {
            try db.run(LPTables.Student.tblStudent.create(ifNotExists: true) { t in
                t.column(LPTables.Student.id)
                t.column(LPTables.Student.name)
                t.column(LPTables.Student.address)
                t.column(LPTables.Student.email)
                t.column(LPTables.Student.mobileNo)
                t.column(LPTables.Student.rollNo)
            })
        }
        catch {
        }
    }
    
    
    // MARK: - Other Methods
    func insertStudent(studentInfo: LPStudentInfo) -> Bool {
        do {
            let stmt = try db.prepare("INSERT OR REPLACE INTO student_master (name, address, email, rollno, mobileno) VALUES (?, ?, ?, ?, ?)")
            try stmt.run(studentInfo.name, studentInfo.address, studentInfo.email, studentInfo.rollNumber, studentInfo.mobileNumber)
        }
        catch {
            return false
        }
        return true
    }
    
    func updateStudent(studentInfo: LPStudentInfo) -> Bool {
        do {
            let alice = LPTables.Student.tblStudent.filter(LPTables.Student.id == studentInfo.id)
            try db.run(alice.update(LPTables.Student.name <- studentInfo.name, LPTables.Student.address <- studentInfo.address, LPTables.Student.email <- studentInfo.email, LPTables.Student.rollNo <- studentInfo.rollNumber, LPTables.Student.mobileNo <- studentInfo.mobileNumber))
        }
        catch {
            return false
        }
        return true
    }
    
    
    func deleteAllStudent() -> Bool {
        do {
            let stmt = try db.prepare("DELETE FROM student_master")
            try stmt.run()
        }
        catch {
            return false
        }
        return true
    }
    
    func deleteStudent(id: Int) -> Bool {
        do {
            let stmt = try db.prepare("DELETE FROM student_master WHERE sid = (\(id))")
            try stmt.run()
        }
        catch {
            return false
        }
        return true
    }
    
    
    // MARK: Class Methods
    func getDatabasePath(dbname: String) -> String {
        let fileManager = FileManager.default
        
        let documentDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        if documentDir.count > 0 {
            if let docDirPath = documentDir.first {
                return docDirPath.appendingPathComponent(dbname).path
            }
        }
        
        return ""
    }
    
    func copyDefaultDatabase(dbname: String) -> Bool {
        let fileManager = FileManager.default
        let destinationPath = getDatabasePath(dbname: dbname)
        if fileManager.fileExists(atPath: destinationPath) {
            // Database already exists at destination path
            return true
        }
        else {
            // Change default database file name here which you have added in resources.
            if let sourcePath = Bundle.main.path(forResource: "MyDatabase", ofType: "db") {
                do {
                    try fileManager.copyItem(atPath: sourcePath, toPath:destinationPath)
                    return true
                }
                catch {
                    // Failure
                }
            }
        }
        return false
    }
}
