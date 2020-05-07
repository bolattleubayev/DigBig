//
//  DigClass.swift
//  DigBig
//
//  Created by macbook on 5/3/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import Foundation

struct DigClass {
    var title: String
    var teacher: String
    var classImage: Data
    var digItems: Array<DigItem>
    
    init(title: String, teacher: String, classImage: Data, digItems: Array<DigItem>) {
        self.title = title
        self.teacher = teacher
        self.classImage = classImage
        self.digItems = digItems
    }
    
    init() {self.init(title: "", teacher: "", classImage: Data(), digItems: [])}
}
