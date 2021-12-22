//
//  ViewController.swift
//  Ass11
//
//  Created by DCS on 14/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    var Student:stud?
    let uname = "Admin"
    let upass = "admin123"
    private let notes = [stud]()
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
        label.text = "Login"
        label.font = UIFont.italicSystemFont(ofSize: 25)
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        return label
    }()
    private let forgetlabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Forgot Password?"
        label.font = UIFont.italicSystemFont(ofSize: 10)
        label.font = UIFont(name: "HelveticaNeue", size: 10)
        return label
    }()
    private let usertext:UITextField = {
        let textfield = UITextField()
        textfield.textColor = .black
        textfield.placeholder = "Username"
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
    private let loginbutton:UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginClickbtn), for: .touchUpInside)
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
        view.addSubview(forgetlabel)
        view.addSubview(usertext)
        view.addSubview(passtext)
        view.addSubview(loginbutton)
    }
    @objc func loginClickbtn(){
        var alert = UIAlertController()
        let sid = Int(usertext.text!) ?? 0
        let notes = SqliteHandler.shared.fetchid(id: sid) {_ in}
        if notes.isEmpty{
            if usertext.text == uname && passtext.text == upass {
                let sc = liststud()
                navigationController?.pushViewController(sc, animated: true)
            }else{
                alert = UIAlertController(title: "Failed to LoggedIn", message: "Incorrect Username OR Password", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
            }
        }else{
            if Int(usertext.text!) == notes[0].spid &&  passtext.text == notes[0].pass{
                UserDefaults.standard.setValue(notes[0].spid, forKey:"usrid")
                UserDefaults.standard.setValue(notes[0].cour, forKey:"cod")
                let vc = StudentVC()
                navigationController?.pushViewController(vc, animated: true)
                self.dismiss(animated: true)
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titlelabel.frame = CGRect(x: 5, y: 200, width: view.width-150, height: 50)
        loginlabel.frame = CGRect(x: 5, y: 230, width: view.width-245, height: 50)
        usertext.frame = CGRect(x: 37, y: loginlabel.frame.origin.y+90, width: view.width-100, height: 50)
        passtext.frame = CGRect(x: 37, y: usertext.frame.origin.y+70, width: view.width-100, height: 50)
        loginbutton.frame = CGRect(x: 37, y: passtext.frame.origin.y+70, width: view.width-100, height: 50)
        forgetlabel.frame = CGRect(x: 40, y: loginbutton.frame.origin.y+50, width: view.width-100, height: 30)
    }
}

