//
//  ThanksVC.swift
//  NMMoney
//
//  Created by Евгений Махнач on 29.08.2018.
//  Copyright © 2018 Евгений Махнач. All rights reserved.
//

import UIKit
import RealmSwift
class ThanksVC: UIViewController {

    
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    @IBOutlet weak var branchText: UILabel!
    
    @IBOutlet weak var branchConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(RealmService.getBook())
        if RealmService.getBook().last!.branchName != nil {
            branchLabel.text = RealmService.getBook().last!.branchName
        } else {
            branchText.isHidden = true
            branchLabel.isHidden = true
            branchConstraint.constant = 35
        }
        reasonLabel.text = RealmService.getBook().last!.reason
        mailLabel.text = RealmService.getBook().last!.email
        phoneLabel.text = RealmService.getBook().last!.number
        nameLabel.text = RealmService.getBook().last!.name
        let fullDate = RealmService.getBook().last!.date
        let splittedDate = fullDate?.components(separatedBy: "T")
        let dateText = splittedDate?[0].components(separatedBy: "-")
        let month = Int(dateText![1])
        var monthString = ""
        if month! < 10 {
            monthString = "0" + dateText![1]
        } else {
            monthString = dateText![1]

        }
        dateLabel.text = dateText![2] + "/" + monthString + "/" + dateText![0]
        timeLabel.text = splittedDate?[1]
        finishBtn.roundCorners(.allCorners, radius: 12)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            self.pushVC(identifier: "kStartVC")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func finish(_ sender: UIButton) {
        pushVC(identifier: "kStartVC")
    }
}
