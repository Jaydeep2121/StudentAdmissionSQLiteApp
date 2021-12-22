//
//  Regpage.swift
//  Ass11
//
//  Created by DCS on 14/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NoticeVC: UIViewController {
    var S1:notice?
    let temp = SqliteHandler.shared
    private let titlelabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Add Notice"
        label.font = UIFont.italicSystemFont(ofSize: 30)
        label.font = UIFont(name: "HelveticaNeue-UltraLight", size: 30)
        return label
    }()
    private let titletextfield:UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter Title"
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
    private let desctextfield:UITextView = {
        let textfield = UITextView()
        textfield.layer.borderWidth = 1
        return textfield
    }()
    private let Datepicker : UIDatePicker = {
        let dp = UIDatePicker()
        dp.timeZone = NSTimeZone.local
        dp.datePickerMode = UIDatePicker.Mode.date
        return dp
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
        button.setTitle("Publish", for: .normal)
        button.addTarget(self, action: #selector(savenotice), for: .touchUpInside)
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
        view.addSubview(titletextfield)
        view.addSubview(desctextfield)
        view.addSubview(Datepicker)
        view.addSubview(mysegment1)
        view.addSubview(savebutton)
        if let n = S1{
            titletextfield.text = n.title
            desctextfield.text = n.data
            if n.course == "Bcom"{
                mysegment1.selectedSegmentIndex = 0
            }else if n.course == "BBA"{
                mysegment1.selectedSegmentIndex = 1
            }else if n.course == "BCA"{
                mysegment1.selectedSegmentIndex = 2
            }else if n.course == "ALL"{
                mysegment1.selectedSegmentIndex = 3
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titlelabel.frame = CGRect(x: 10, y: 30, width: view.width-10, height: 100)
        titletextfield.frame = CGRect(x: 30, y: titlelabel.bottom+20, width: view.width-60, height: 40)
        desctextfield.frame = CGRect(x: 30, y: titletextfield.bottom + 20, width: view.width-60, height: 100)
        Datepicker.frame = CGRect(x: 30, y: desctextfield.bottom + 20, width: view.width-60, height: 70)
        mysegment1.frame = CGRect(x: 30, y: Datepicker.bottom+40, width: view.width-60, height: 30)
        savebutton.frame = CGRect(x: 30, y: mysegment1.bottom+20, width: view.width-60, height: 40)
    }
}
extension NoticeVC{
    @objc private func savenotice(){
        let title = titletextfield.text!
        let descr = desctextfield.text!
        let cal = Calendar.current
        let components = cal.dateComponents([.day,.month,.year], from: Datepicker.date)
        let cour = mysegment1.titleForSegment(at: mysegment1.selectedSegmentIndex)!
        let don = "\(components.day!)-\(components.month!)-\(components.year!)"
        if S1 != nil {
            let updstd = notice(title: title, data: descr, pdate: don, course: cour)
            update(Student:updstd)
        }else{
            let insstd = notice(title: title, data: descr, pdate: don, course: cour)
            insertnotice(Student:insstd)
        }
    }
    private func insertnotice(Student:notice){
        SqliteHandler.shared.insertnotice(e: Student) { (success) in
            if success {
                let alert = UIAlertController(title: "Success", message: "Notice Published..", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.resetfields()
            } else {
                print("Insert failed, recevied mesage at VC")
            }
        }
    }
    private func update(Student:notice) {
        SqliteHandler.shared.updatenotice(e: Student) { (success) in
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
        titletextfield.text=""
        desctextfield.text=""
        mysegment1.selectedSegmentIndex = UISegmentedControl.noSegment
    }
}
