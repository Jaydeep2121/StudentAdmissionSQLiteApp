//
//  StudentVC.swift
//  Ass11
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//
import UIKit
import Foundation
class StudentVC: UIViewController {
    private let logout:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(logoutclick), for: .touchUpInside)
        let img = UIImage(named: "LogOut.jpeg")
        button.setImage(img, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .green
        button.layer.cornerRadius = 6
        return button
    }()
    private let studviewbtn:UIButton = {
        let button = UIButton()
        button.setTitle("View Profile", for: .normal)
        button.addTarget(self, action: #selector(viewprofile), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .green
        button.layer.cornerRadius = 6
        return button
    }()
    private let noticeviewbtn:UIButton = {
        let button = UIButton()
        button.setTitle("View NoticeBoard", for: .normal)
        button.addTarget(self, action: #selector(viewnotice), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .green
        button.layer.cornerRadius = 6
        return button
    }()
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(logout)
        view.addSubview(studviewbtn)
        view.addSubview(noticeviewbtn)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logout.frame = CGRect(x: 270, y: 20, width: 100, height: 90)
        studviewbtn.frame = CGRect(x: 90, y: 200, width: 200, height: 70)
        noticeviewbtn.frame = CGRect(x: 90, y: studviewbtn.bottom+20, width: 200, height: 70)
    }
}
extension StudentVC{
    @objc func viewprofile(){
        let vc = ViewStudentData()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func viewnotice(){
        let vc = ViewStudentNotice()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func logoutclick(){
       UserDefaults.standard.set(nil, forKey:"usrid")
       let vc = LoginVC()
       navigationController?.pushViewController(vc, animated: true)
       self.dismiss(animated: true)
    }
}
