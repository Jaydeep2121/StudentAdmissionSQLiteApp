//
//  Regpage.swift
//  Ass11
//
//  Created by DCS on 14/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewStudentNotice: UIViewController {
    var S1:notice?
    let temp = SqliteHandler.shared
    private var notes = [notice]()
    private let titlelabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "My NoticeBoard"
        label.font = UIFont.italicSystemFont(ofSize: 30)
        label.font = UIFont(name: "HelveticaNeue-UltraLight", size: 30)
        return label
    }()
    private let titletextfield:UITextField = {
        let textfield = UITextField()
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
        
        let cors=UserDefaults.standard.string(forKey: "cod")
        notes = SqliteHandler.shared.fetchdata_notice(e:cors!)
        var alert = UIAlertController()
        if notes.isEmpty{
            alert = UIAlertController(title: "No Notice", message: "No Further Notice", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            titletextfield.text = notes[0].title
            desctextfield.text = notes[0].data
            if notes[0].course == "Bcom"{
                mysegment1.selectedSegmentIndex = 0
            }else if notes[0].course == "BBA"{
                mysegment1.selectedSegmentIndex = 1
            }else if notes[0].course == "BCA"{
                mysegment1.selectedSegmentIndex = 2
            }else if notes[0].course == "ALL"{
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
    }
}

