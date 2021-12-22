//
//  Notes.swift
//  DataBase
//
//  Created by DCS on 13/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class liststud: UIViewController {
    private let myTable = UITableView()
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
    private let addview:UIButton = {
        let button = UIButton()
        button.setTitle("View Notice", for: .normal)
        button.addTarget(self, action: #selector(add_notice), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 6
        return button
    }()
    private let addstud:UIButton = {
        let button = UIButton()
        button.setTitle("Add Student", for: .normal)
        button.addTarget(self, action: #selector(add_note), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 6
        return button
    }()
    private var notes = [stud]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(myTable)
        view.addSubview(logout)
        view.addSubview(addstud)
        view.addSubview(addview)
        myTable.dataSource = self
        myTable.delegate = self
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addview.frame = CGRect(x: 10, y: 20, width: 150, height: 40)
        addstud.frame = CGRect(x: addview.left+210, y: 20, width: 150, height: 40)
        myTable.frame = CGRect(x: 0,y: 70, width: view.frame.size.width,
                               height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        logout.frame = CGRect(x: 160, y: 15, width: 60, height: 60)
    }
    override func viewWillAppear(_ animated: Bool) {
        notes = SqliteHandler.shared.fetch()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        myTable.reloadData()
    }
    @objc func add_note()
    {
        let vc = Regpage()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func add_notice(){
        let sc = listnotice()
        navigationController?.pushViewController(sc, animated: true)
    }
    @objc func logoutclick(){
        UserDefaults.standard.set(nil, forKey:"usrid")
        let vc = LoginVC()
        navigationController?.pushViewController(vc, animated: true)
        self.dismiss(animated: true)
    }
}
extension liststud: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let emp = notes[indexPath.row]
        cell.textLabel?.text = "\(emp.name) \t | \t \(emp.email) \t | \t \(emp.gen)  \t | \t \(emp.cour)"
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Regpage()
        vc.Student = notes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id = notes[indexPath.row].spid
        SqliteHandler.shared.delete(for: id) { (success) in
            if success {
                print("Deleted in VC")
                self.notes.remove(at: indexPath.row)
                self.myTable.deleteRows(at: [indexPath], with: .automatic)
            } else {
                print(id)
                print("not Deleted in VC")
            }
        }
    }
    
}
