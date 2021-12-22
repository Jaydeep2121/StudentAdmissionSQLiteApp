//
//  ViewController.swift
//  Ass11
//
//  Created by DCS on 14/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class changepwd: UIViewController {
    var Student:stud?
    let temp = SqliteHandler.shared
    private let titlelabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Proceed with your"
        label.font = UIFont.italicSystemFont(ofSize: 20)
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        return label
    }()
    private let loginlabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Change Password"
        label.font = UIFont.italicSystemFont(ofSize: 25)
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        return label
    }()
    private let usertext:UITextField = {
        let textfield = UITextField()
        textfield.textColor = .black
        textfield.placeholder = "Password"
        textfield.textAlignment = .center
        textfield.layer.cornerRadius = 15.0
        textfield.backgroundColor = .white
        textfield.layer.borderWidth = 0
        textfield.layer.shadowColor = UIColor.black.cgColor
        textfield.layer.shadowOffset = CGSize(width: 3, height: 3)
        textfield.layer.shadowOpacity = 0.7
        textfield.layer.shadowRadius = 4.0
        textfield.font = UIFont.init(name: "Montserrt.bold.rawValue", size: 18.0)
        return textfield
    }()
    private let passtext:UITextField = {
        let textfield = UITextField()
        textfield.textColor = .black
        textfield.placeholder = "Confirm Password"
        textfield.textAlignment = .center
        textfield.layer.cornerRadius = 15.0
        textfield.backgroundColor = .white
        textfield.layer.borderWidth = 0
        textfield.layer.shadowColor = UIColor.black.cgColor
        textfield.layer.shadowOffset = CGSize(width: 3, height: 3)
        textfield.layer.shadowOpacity = 0.7
        textfield.layer.shadowRadius = 4.0
        textfield.font = UIFont.init(name: "Montserrt.bold.rawValue", size: 18.0)
        return textfield
    }()
    private let loginbutton:UIButton = {
        let button = UIButton()
        button.setTitle("Change", for: .normal)
        button.addTarget(self, action: #selector(ChangeClickbtn), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .red
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height))
        imageViewBackground.image = UIImage(named: "img1.jpg")
        view.addSubview(imageViewBackground)
        view.addSubview(titlelabel)
        view.addSubview(loginlabel)
        view.addSubview(usertext)
        view.addSubview(passtext)
        view.addSubview(loginbutton)
    }
    @objc func ChangeClickbtn(){
        var alert = UIAlertController()
        if usertext.text == passtext.text && usertext.text != "" && passtext.text != "" {
            print("hi change passwd")
            let passd = usertext.text!
                if let myid = UserDefaults.standard.string(forKey: "usrid"){
                let updstd = stud(spid: Int(myid)!, name: "", email: "", gen: "", pass: passd, cour: "")
                Changepwd(Student:updstd)
            }
        }else{
            alert = UIAlertController(title: "Not Same", message: "Password and confirm Password is not same", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            usertext.text = ""
            passtext.text = ""
        }
    }
    private func Changepwd(Student:stud) {
        SqliteHandler.shared.updatepwd(e: Student) { (success) in
            if success {
                let alert = UIAlertController(title: "Success", message: "Password Changed!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.usertext.text = ""
                self.passtext.text = ""
            } else {
                print("Update failed, recevied mesage at VC")
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titlelabel.frame = CGRect(x: 5, y: 200, width: view.width-150, height: 50)
        loginlabel.frame = CGRect(x: 5, y: 230, width: view.width-100, height: 50)
        usertext.frame = CGRect(x: 37, y: loginlabel.frame.origin.y+90, width: view.width-100, height: 50)
        passtext.frame = CGRect(x: 37, y: usertext.frame.origin.y+70, width: view.width-100, height: 50)
        loginbutton.frame = CGRect(x: 37, y: passtext.frame.origin.y+70, width: view.width-100, height: 50)
    }
}

