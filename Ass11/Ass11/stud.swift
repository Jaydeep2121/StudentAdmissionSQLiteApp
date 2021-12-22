//
//  stud.swift
//  Ass11
//
//  Created by DCS on 15/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
class stud{
    var spid:Int = 0
    var name:String = ""
    var email:String = ""
    var gen:String = ""
    var pass:String = ""
    var cour:String = ""
    
    init(spid:Int,name:String,email:String,gen:String,pass:String,cour:String) {
        self.spid = spid
        self.name = name
        self.email = email
        self.gen = gen
        self.pass = pass
        self.cour = cour
    }
}


