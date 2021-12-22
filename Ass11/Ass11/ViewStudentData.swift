//
//  Regpage.swift
//  Ass11
//
//  Created by DCS on 14/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewStudentData: UIViewController {
    var S2:stud?
    let temp = SqliteHandler.shared
    private var notes = [stud]()
    private let titlelabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "My Profile"
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
    private let chagebtn:UIButton = {
        let button = UIButton()
        button.setTitle("Change Password >>", for: .normal)
        button.addTarget(self, action: #selector(chagepwd), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .blue
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
        view.addSubview(chagebtn)
        
        let myid=UserDefaults.standard.integer(forKey: "usrid")
        notes = SqliteHandler.shared.fetchdata(id: myid) {_ in}
            spidtextfield.isEnabled = false
            nametextfield.isEnabled = false
            emailtextfield.isEnabled = false
            passtextfield.isEnabled = false
            mysegment.isEnabled = false
            mysegment1.isEnabled = false
            spidtextfield.text = "\(notes[0].spid)"
            nametextfield.text = notes[0].name
            emailtextfield.text = notes[0].email
            passtextfield.text = notes[0].pass
            if notes[0].gen == "Male"{
                mysegment.selectedSegmentIndex = 0
            }else if notes[0].gen == "Female"{
                mysegment.selectedSegmentIndex = 1
            }else{
                mysegment.selectedSegmentIndex = 2
            }
            if notes[0].cour == "Bcom"{
                mysegment1.selectedSegmentIndex = 0
            }else if notes[0].cour == "BCA"{
                mysegment1.selectedSegmentIndex = 1
            }else if notes[0].cour == "BBA"{
                mysegment1.selectedSegmentIndex = 2
            }else{
                mysegment1.selectedSegmentIndex = 3
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
        chagebtn.frame = CGRect(x: 30, y: mysegment1.bottom+50, width: view.width-60, height: 50)
    }
}
extension ViewStudentData{
    @objc func chagepwd(){
        let sc = changepwd()
        navigationController?.pushViewController(sc, animated: true)
    }
}
