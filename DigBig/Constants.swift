//
//  Constants.swift
//  DigBig
//
//  Created by macbook on 5/3/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    static func modifyNavigationController(navigationController: UINavigationController?) {
        // Modifying the Navigation Bar
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.3411764706, blue: 0.5725490196, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
        if let customFont = UIFont(name: "Avenir", size: 25.0) {
            navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0), NSAttributedString.Key.font: customFont]
        }
    }
    
//    static let classes = [DigClass(title: "English", teacher: "Arthur McFater", classImage: UIImage(named: "englishVertical")!.pngData() ?? Data(), digItems: [DigItem(title: "Homework", type: "Presentation", text: "https://drive.google.com/file/d/113tG_28LP4VfnE3oZWEXuvYDgeG98bd1/view?usp=sharing", date: "1st of May, 2020", imageAttachment: UIImage(named: "abIconTest1")!.pngData() ?? Data()), DigItem(title: "Classwork", type: "Document", text: "https://drive.google.com/file/d/1NyHAHsiXc4m6UqHgAGvv3SE_BaIWB-b1/view?usp=sharing", date: "2nd of May, 2020", imageAttachment: UIImage(named: "abIconTest1")!.pngData() ?? Data()), DigItem(title: "Homework", type: "Link", text: "https://stackoverflow.com/users/5289524/bolat-tleubayev?tab=profile", date: "3rd of May, 2020", imageAttachment: UIImage(named: "abIconTest1")!.pngData() ?? Data())]),
//    DigClass(title: "Math", teacher: "Satti Tleubayeva", classImage: UIImage(named: "mathVertical")!.pngData() ?? Data(), digItems: [DigItem(title: "Classwork", type: "Document", text: "https://drive.google.com/file/d/1NyHAHsiXc4m6UqHgAGvv3SE_BaIWB-b1/view?usp=sharing", date: "1st of May, 2020", imageAttachment: UIImage(named: "abIconTest1")!.pngData() ?? Data())]),
//    DigClass(title: "Kazakh", teacher: "Zhanel Zhexenova", classImage: UIImage(named: "kazakhVertical")!.pngData() ?? Data(), digItems: [DigItem(title: "Homework", type: "Link", text: "https://stackoverflow.com/users/5289524/bolat-tleubayev?tab=profile", date: "1st of May, 2020", imageAttachment: UIImage(named: "abIconTest1")!.pngData() ?? Data())])]
}
