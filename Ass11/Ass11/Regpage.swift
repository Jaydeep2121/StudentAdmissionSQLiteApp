//
//  Regpage.swift
//  Ass11
//
//  Created by DCS on 14/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Regpage: UIViewController {
    var Student:stud?
    let temp = SqliteHandler.shared
    private let titlelabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Add Student"
        label.font = UIFont.italicSystemFont(ofSize: 30)
        label.font = UIFont(name: "HelveticaNeue-UltraLight", size: 30)
        return label
    }()
    private let spidtextfield:UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter SPID"
        textfield.layer.borderWidth = 1
        let img = UIImageView(frame: CGRect(x: 20, y: 50, width: 40, height: 20))
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "id")
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftViewMode = .always
        textfield.rightView = img
        textfield.rightViewMode = .always
        return textfield
    }()
    private let nametextfield:UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter Name"
        let img = UIImageView(frame: CGRect(x: 20, y: 50, width: 40, height: 20))
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "contact")
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftViewMode = .always
        textfield.rightView = img
        textfield.rightViewMode = .always
        textfield.layer.borderWidth = 1
        return textfield
    }()
    private let emailtextfield:UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter Email"
        textfield.layer.borderWidth = 1
        let img = UIImageView(frame: CGRect(x: 20, y: 50, width: 40, height: 20))
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "email")
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftViewMode = .always
        textfield.rightView = img
        textfield.rightViewMode = .always
        return textfield
    }()
    private let passtextfield:UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter Password"
        let img = UIImageView(frame: CGRect(x: 20, y: 50, width: 40, height: 20))
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "key")
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftViewMode = .always
        textfield.rightView = img
        textfield.rightViewMode = .always
        textfield.layer.borderWidth = 1
        return textfield
    }()
    private let mysegment : UISegmentedControl = {
       let sg = UISegmentedControl()
        sg.insertSegment(withTitle: "Male", at: 0, animated: true)
        sg.insertSegment(withTitle: "Female", at: 1, animated: true)
        sg.insertSegment(withTitle: "Other", at: 2, animated: true)
        return sg
    }()
    private let mysegment1 : UISegmentedControl = {
        let sg = UISegmentedControl()
        sg.insertSegment(withTitle: "Bcom", at: 0, animated: true)
        sg.insertSegment(withTitle: "BCA", at: 1, animated: true)
        sg.insertSegment(withTitle: "BBA", at: 2, animated: true)
        sg.insertSegment(withTitle: "All", at: 3, animated: true)
        return sg
    }()
    private let savebutton:UIButton = {
        let button = UIButton()
        button.setTitle("SAVE", for: .normal)
        button.addTarget(self, action: #selector(savenote), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .green
        button.layer.cornerRadius = 6
        return button
    }()
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titlelabel)
        view.addSubview(spidtextfield)
        view.addSubview(nametextfield)
        view.addSubview(emailtextfield)
        view.addSubview(passtextfield)
        view.addSubview(mysegment)
        view.addSubview(mysegment1)
        view.addSubview(savebutton)
        if let s = Student{
            spidtextfield.isEnabled = false
            nametextfield.text = s.name
            emailtextfield.text = s.email
            passtextfield.text = s.pass
            if s.gen == "Male"{
                mysegment.selectedSegmentIndex = 0
            }else if s.gen == "Female"{
                mysegment.selectedSegmentIndex = 1
            }else{
                mysegment.selectedSegmentIndex = 2
            }
            if s.cour == "Bcom"{
                mysegment1.selectedSegmentIndex = 0
            }else if s.cour == "BCA"{
                mysegment1.selectedSegmentIndex = 1
            }else if s.cour == "BBA"{
                mysegment1.selectedSegmentIndex = 2
            }else{
                mysegment1.selectedSegmentIndex = 3
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titlelabel.frame = CGRect(x: 10, y: 30, width: view.width-10, height: 100)
        spidtextfield.frame = CGRect(x: 30, y: titlelabel.bottom+20, width: view.width-60, height: 40)
        nametextfield.frame = CGRect(x: 30, y: spidtextfield.bottom + 20, width: view.width-60, height: 40)
        emailtextfield.frame = CGRect(x: 30, y: nametextfield.bottom + 20, width: view.width-60, height: 40)
        mysegment.frame = CGRect(x: 30, y: emailtextfield.bottom+10, width: view.width-60, height: 30)
        passtextfield.frame = CGRect(x: 30, y: mysegment.bottom+10, width: view.width-60, height: 40)
        mysegment1.frame = CGRect(x: 30, y: passtextfield.bottom+10, width: view.width-60, height: 30)
        savebutton.frame = CGRect(x: 30, y: mysegment1.bottom+30, width: view.width-60, height: 40)
    }
}
extension Regpage{
    @objc private func savenote(){
        let id = spidtextfield.text!
        let name = nametextfield.text!
        let email = emailtextfield.text!
        let segm = mysegment.titleForSegment(at: mysegment.selectedSegmentIndex)!
        let pass = passtextfield.text!
        let cour = mysegment1.titleForSegment(at: mysegment1.selectedSegmentIndex)!
        if let student = Student {
            let updstd = stud(spid: student.spid, name: name, email: email, gen: segm, pass: pass, cour: cour)
            print("UPDATE\(updstd)")
            update(Student:updstd)
        }else{
            print("Insert \(id),\(name),\(email),\(String(describing: segm)),\(cour)")
            let insstd = stud(spid: Int(id)!, name: name, email: email, gen: segm, pass: pass, cour: cour)
            insert(Student:insstd)
        }
    }
    private func insert(Student:stud){
        SqliteHandler.shared.insert(e: Student) { (success) in
            if success {
                let alert = UIAlertController(title: "Success", message: "Data Added", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.resetfields()
            } else {
                print("Insert failed, recevied mesage at VC")
            }
        }
    }
    private func update(Student:stud) {
        SqliteHandler.shared.update(e: Student) { (success) in
            if success {
                let alert = UIAlertController(title: "Success", message: "Data Update", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.resetfields()
            } else {
                print("Update failed, recevied mesage at VC")
            }
        }
    }
    private func resetfields()
    {
        spidtextfield.text=""
        nametextfield.text=""
        emailtextfield.text=""
        mysegment.selectedSegmentIndex = UISegmentedControl.noSegment
        passtextfield.text=""
        mysegment1.selectedSegmentIndex = UISegmentedControl.noSegment
    }
}
