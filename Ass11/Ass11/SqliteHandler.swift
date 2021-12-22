//
//  SqliteHandler.swift
//  Ass11
//
//  Created by DCS on 15/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
import SQLite3

class SqliteHandler {
    static let shared = SqliteHandler()
    let dbpath = "studdb.sqllite"
    var db:OpaquePointer?
    private init(){
        db = opendatabase()
        createtable()
    }
    private func opendatabase()->OpaquePointer?{
        let docurl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileurl = docurl.appendingPathComponent(dbpath)
        
        var database:OpaquePointer? = nil
        if sqlite3_open(fileurl.path,&database) == SQLITE_OK {
            print("Opened connection to the database successfully at: \(fileurl)")
            return database
        }else{
            print("error connecting to the database")
            return nil
        }
    }
    private func createtable(){
//        CREATE TABLE IF NOT EXISTS student(
//            spid INTEGER PRIMARY KEY,
//            name TEXT,
//            email TEXT,
//            gender TEXT,
//            password TEXT,
//            course TEXT);
        let createTableString = """
           CREATE TABLE IF NOT EXISTS noticeb(
                title TEXT,
                data TEXT,
                pdate TEXT,
                course TEXT);
        """
        var creatTableStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &creatTableStatement, nil) == SQLITE_OK{
            if sqlite3_step(creatTableStatement)==SQLITE_DONE {
                print("notic created")
            }else{
                print("notic no created")
            }
        }else{
            print("notic table not prepared")
        }
        sqlite3_finalize(creatTableStatement)
    }
    func delete(for id:Int, completion: @escaping ((Bool) -> Void)) {
        let deletestr = "delete from student where spid=?;"
        
        var deletest:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deletestr, -1, &deletest, nil) == SQLITE_OK {
    
            sqlite3_bind_int(deletest, 1, Int32(id))
            print("id is:\(id)")
            if sqlite3_step(deletest) == SQLITE_DONE {
                print("deleted")
                completion(true)
            } else {
                print("not deleted")
                completion(false)
            }
            
        } else {
            print("delete statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(deletest)
    }
    func deletenotice(co:notice, completion: @escaping ((Bool) -> Void)) {
        
      let deletestr = "delete from noticeb where course=?;"
        
        var deletest:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deletestr, -1, &deletest, nil) == SQLITE_OK {
            sqlite3_bind_text(deletest, 1, co.course, -1, nil)
            if sqlite3_step(deletest) == SQLITE_DONE {
                print("deleted")
                completion(true)
            } else {
                print("not deleted")
                completion(false)
            }
        } else {
            print("delete statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(deletest)
    }
    func insert(e:stud, completion: @escaping ((Bool) -> Void)) {
        let insertstr = "INSERT INTO student (spid,name,email,gender,password,course) VALUES (?, ?, ? , ?, ?, ?);"
        
        var insertst:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertstr, -1, &insertst, nil) == SQLITE_OK {
            //int sqlite3_bind_text(sqlite3_stmt*,int,const char*,int,void(*)(void*));
            sqlite3_bind_int(insertst,  1, Int32(e.spid))
            sqlite3_bind_text(insertst, 2, (e.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 3, (e.email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 4, (e.gen as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 5, (e.pass as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 6, (e.cour as NSString).utf8String, -1, nil)
            if sqlite3_step(insertst) == SQLITE_DONE {
                print("inserted")
                completion(true)
            } else {
                print("not inserted")
                completion(false)
            }
            
        } else {
            print("Insert statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(insertst)
    }
    func insertnotice(e:notice, completion: @escaping ((Bool) -> Void)) {
        let insertstr = "INSERT INTO noticeb (title,data,pdate,course) VALUES (?, ?, ?, ?);"
        
        var insertst:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertstr, -1, &insertst, nil) == SQLITE_OK {
            //int sqlite3_bind_text(sqlite3_stmt*,int,const char*,int,void(*)(void*));
            sqlite3_bind_text(insertst, 1, (e.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 2, (e.data as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 3, (e.pdate as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 4, (e.course as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertst) == SQLITE_DONE {
                print("inserted")
                completion(true)
            } else {
                print("not inserted")
                completion(false)
            }
            
        } else {
            print("Insert statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(insertst)
    }
    func update(e:stud, completion: @escaping ((Bool) -> Void)) {
        let updatestr = "UPDATE student SET name = ?, email = ?, gender = ?, password = ?, course = ? WHERE spid = ?;"
        
        var updatest:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updatestr, -1, &updatest, nil) == SQLITE_OK {
            //int sqlite3_bind_text(sqlite3_stmt*,int,const char*,int,void(*)(void*));
            sqlite3_bind_text(updatest, 1, (e.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 2, (e.email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 3, (e.gen as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 4, (e.pass as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 5, (e.cour as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updatest,  6, Int32(e.spid))
            if sqlite3_step(updatest) == SQLITE_DONE {
                print("updated")
                completion(true)
            } else {
                print("not updated")
                completion(false)
            }
            
        } else {
            print("update statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(updatest)
    }
    func updatepwd(e:stud, completion: @escaping ((Bool) -> Void)) {
        let updatestr = "UPDATE student SET password = ? WHERE spid = ?;"
        
        var updatest:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updatestr, -1, &updatest, nil) == SQLITE_OK {
            //int sqlite3_bind_text(sqlite3_stmt*,int,const char*,int,void(*)(void*));
            sqlite3_bind_text(updatest, 1, (e.pass as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updatest,  2, Int32(e.spid))
            if sqlite3_step(updatest) == SQLITE_DONE {
                print("updated")
                completion(true)
            } else {
                print("not updated")
                completion(false)
            }
            
        } else {
            print("update statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(updatest)
    }
    func fetchid(id:Int , completion: @escaping ((Bool) -> Void))-> [stud] {
        let fetchstr = "SELECT spid,password,course FROM student where spid=?;"
        var emp = [stud]()
        var fetchst:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, fetchstr, -1, &fetchst, nil) == SQLITE_OK {
            sqlite3_bind_int(fetchst,  1, Int32(id))
            while sqlite3_step(fetchst) == SQLITE_ROW {
                let sid = Int(sqlite3_column_int(fetchst, 0))
                let passd = String(cString: sqlite3_column_text(fetchst, 1))
                let cord = String(cString: sqlite3_column_text(fetchst, 2))
                emp.append(stud(spid: sid, name: "", email: "", gen: "", pass: passd, cour: cord))
            }
        } else {
            print("fetch statement could not be prepared")
        }
        sqlite3_finalize(fetchst)
        return emp
    }
    func updatenotice(e:notice, completion: @escaping ((Bool) -> Void)) {
        let updatestr = "update noticeb set title=?,data=?,pdate=? where course=?"
        
        var updatest:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updatestr, -1, &updatest, nil) == SQLITE_OK {
            //int sqlite3_bind_text(sqlite3_stmt*,int,const char*,int,void(*)(void*));
            sqlite3_bind_text(updatest, 1, (e.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 2, (e.data as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 3, (e.pdate as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 4, (e.course as NSString).utf8String, -1, nil)
            print(updatestr)
            if sqlite3_step(updatest) == SQLITE_DONE {
                print("updated")
                completion(true)
            } else {
                print("not updated")
                completion(false)
            }
        } else {
            print("update statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(updatest)
    }
    func fetchnotice() -> [notice]{
        let fetchstr = "SELECT * FROM noticeb;"
        var emp = [notice]()
        var fetchst:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, fetchstr, -1, &fetchst, nil) == SQLITE_OK {
            
            while sqlite3_step(fetchst) == SQLITE_ROW {
                let titles = String(cString: sqlite3_column_text(fetchst, 0))
                let dscr = String(cString: sqlite3_column_text(fetchst, 1))
                let dates = String(cString: sqlite3_column_text(fetchst, 2))
                let cord = String(cString: sqlite3_column_text(fetchst, 3))
                emp.append(notice(title:titles,data:dscr,pdate:dates,course:cord))
            }
        } else {
            print("fetch statement could not be prepared")
        }
        sqlite3_finalize(fetchst)
        return emp
    }
    func fetchdata(id:Int , completion: @escaping ((Bool) -> Void)) -> [stud] {
        let fetchstr = "SELECT * FROM student WHERE spid=?;"
        var emp = [stud]()
        var fetchst:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, fetchstr, -1, &fetchst, nil) == SQLITE_OK {
            sqlite3_bind_int(fetchst,  1, Int32(id))
            while sqlite3_step(fetchst) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(fetchst, 0))
                let name =  String(cString: sqlite3_column_text(fetchst, 1))
                let email = String(cString: sqlite3_column_text(fetchst, 2))
                let gen = String(cString: sqlite3_column_text(fetchst, 3))
                let pass = String(cString: sqlite3_column_text(fetchst, 4))
                let cour = String(cString: sqlite3_column_text(fetchst, 5))
                emp.append(stud(spid: id, name:name,email: email,gen: gen,pass:pass, cour: cour))
            }
        } else {
            print("fetch statement could not be prepared")
        }
        sqlite3_finalize(fetchst)
        return emp
    }
    func fetchdata_notice(e:String) -> [notice] {
        let fetchstr = "SELECT * FROM noticeb WHERE course=?;"
        var emp = [notice]()
        var fetchst:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, fetchstr, -1, &fetchst, nil) == SQLITE_OK {
            sqlite3_bind_text(fetchst, 1, (e as NSString).utf8String, -1, nil)
            while sqlite3_step(fetchst) == SQLITE_ROW {
                let title =  String(cString: sqlite3_column_text(fetchst, 0))
                let data = String(cString: sqlite3_column_text(fetchst, 1))
                let dates = String(cString: sqlite3_column_text(fetchst, 2))
                let cour = String(cString: sqlite3_column_text(fetchst,3))
                emp.append(notice(title: title, data: data, pdate: dates, course: cour))
            }
        } else {
            print("fetch statement could not be prepared")
        }
        sqlite3_finalize(fetchst)
        return emp
    }
    func fetch() -> [stud] {
        let fetchstr = "SELECT * FROM student;"
        var emp = [stud]()
        var fetchst:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, fetchstr, -1, &fetchst, nil) == SQLITE_OK {
            
            while sqlite3_step(fetchst) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(fetchst, 0))
                let name =  String(cString: sqlite3_column_text(fetchst, 1))
                let email = String(cString: sqlite3_column_text(fetchst, 2))
                let gen = String(cString: sqlite3_column_text(fetchst, 3))
                let pass = String(cString: sqlite3_column_text(fetchst, 4))
                let cour = String(cString: sqlite3_column_text(fetchst, 5))
                emp.append(stud(spid: id, name:name,email: email,gen: gen,pass:pass, cour: cour))
            }
            
        } else {
            print("fetch statement could not be prepared")
            
        }
        sqlite3_finalize(fetchst)
        return emp
    }
    
}
