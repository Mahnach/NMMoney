//
//  TelephoneAppointmentVC.swift
//  NMMoney
//
//  Created by Евгений Махнач on 24.08.2018.
//  Copyright © 2018 Евгений Махнач. All rights reserved.
//

import UIKit
import DropDown
import RealmSwift

class VideoVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var commentField: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet var buttonsTimeArray: [UIButton]!
    
    @IBOutlet weak var mortgageField: UITextField!
    
    @IBOutlet weak var dateCollectionView: UICollectionView!
    
    fileprivate var isKeyboardShow = false
    var dateArray = [Singleton]()
    @IBOutlet weak var checkBox: UIView!
    @IBOutlet weak var branchField: UITextField!
    @IBOutlet weak var booked: UIButton!
    
    let realm = try! Realm()
    var selectedBranch = ""
    var selectedDate = ""
    var selectedTime = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        booked.roundCorners(.allCorners, radius: 12)
        let checkbox = Checkbox(frame: checkBox.frame)
        checkbox.checkedBorderColor = .clear
        checkbox.uncheckedBorderColor = .clear
        numberField.tag = 1
        checkbox.borderStyle = .square
        dateCollectionView.delegate = self
        dateCollectionView.dataSource = self
        dateLabel.isHidden = true
        setTextFieldsDelegates()
        hideKeyboardWhenTappedAround()
        timeLabel.isHidden = true
        view.addSubview(checkbox)
        activity.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        checkbox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
        for element in self.buttonsTimeArray {
            element.isHidden = true
        }
        if let layout = dateCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal  // .horizontal
        }
        let flow = dateCollectionView.collectionViewLayout as! UICollectionViewFlowLayout

        flow.minimumInteritemSpacing = 3.2
        flow.minimumLineSpacing = 3.2
        
        var hours = 8
        for element in buttonsTimeArray {
            element.tag = hours
            var buttonTitle = ""
            if hours < 10 {
                buttonTitle = "0" + String(describing: hours) + ":" + "00"
            } else {
                buttonTitle = String(describing: hours) + ":" + "00"
            }
            element.setTitle(buttonTitle, for: .normal)
            element.addBorder(side: .Bottom, color: UIColor.lightGray, width: 1)
            element.addBorder(side: .Left, color: UIColor.lightGray, width: 1)
            element.addBorder(side: .Right, color: UIColor.lightGray, width: 1)
            element.addBorder(side: .Top, color: UIColor.lightGray, width: 1)

            element.addTarget(self, action: #selector(self.clickTime), for: .touchUpInside)
            hours += 1
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        RealmService.deleteSlots()
        dateCollectionView.reloadData()
    }
    
    func setTextFieldsDelegates() {
        self.emailField.delegate = self
        self.numberField.delegate = self
        self.firstNameField.delegate = self
        self.lastNameField.delegate = self
        self.commentField.delegate = self
    }
    
    
    @objc func clickTime(_ sender: UIButton) {
        let tag = sender.tag
        for element in buttonsTimeArray {
            if element.tag == tag {
                selectedTime = String(describing: tag) + ":00"
                timeLabel.text = selectedTime
                timeLabel.isHidden = false
                element.backgroundColor = UIColor.Text.lightRed
                element.setTitleColor(UIColor.white, for: .normal)
            } else {
                element.backgroundColor = UIColor.white
                element.setTitleColor(UIColor.black, for: .normal)
            }
        }
    }
    
    @objc func checkboxValueChanged(sender: Checkbox) {
        print("checkbox value change: \(sender.isChecked)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func scrollToRight(_ sender: UIButton) {
        if dateCollectionView.contentOffset.x >= 0 && dateCollectionView.contentOffset.x < CGFloat(dateArray.count * 55 / 12)  {
            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.dateCollectionView.contentOffset.x += 100
                print(self.dateCollectionView.contentOffset.x)
            }, completion: nil)
        } else {
            self.dateCollectionView.contentOffset.x = CGFloat(dateArray.count * 55 / 12)
        }
    }
    
    @IBAction func scrollToLeft(_ sender: UIButton) {
        if dateCollectionView.contentOffset.x <= 0 {
            dateCollectionView.contentOffset.x = 0
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.dateCollectionView.contentOffset.x -= 100
            }, completion: nil)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dateArray.count == 0 {
            return 0
        }
        let remainder = dateArray.count % 12
        if remainder > 0 {
            return ((dateArray.count / 12) + 1)
        } else {
            return (dateArray.count / 12)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dateCollectionView.dequeueReusableCell(withReuseIdentifier: "kDateCollectionCell", for: indexPath) as! DateCollectionCell
        
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        if let date = Calendar.current.date(byAdding: .day, value: 60, to: Date()) {
            
            let y = String(describing: year) //RealmService.getBranchTime().last!.year!
            let m = String(describing: month) //RealmService.getBranchTime().last!.month!
            let d = String(describing: day) //RealmService.getBranchTime().last!.day!
            let dateString = y + "-" + m + "-" + d
            let day = Date().allDates(till: date, startDate: dateString)
            let remainder = dateArray.count % 12

            if remainder != 0 {
                if indexPath.row == 0 {
                    cell.day.text = dateArray[0].day!
                    cell.month.text = monthToString(month: dateArray[0].month!)
                    cell.dayWeek.text = String(dateArray[0].weekDay!.prefix(3))
                }
                else {
                    cell.day.text = dateArray[remainder + (indexPath.row - 1) * 12].day!
                    cell.month.text = monthToString(month: dateArray[remainder + (indexPath.row - 1) * 12].month!)
                    cell.dayWeek.text = String(dateArray[remainder + (indexPath.row - 1) * 12].weekDay!.prefix(3))
                    }
            } else {
                cell.day.text = dateArray[indexPath.row * 12].day!
                cell.month.text = monthToString(month: dateArray[indexPath.row * 12].month!)
                cell.dayWeek.text = String(dateArray[indexPath.row * 12].weekDay!.prefix(3))
            }

//            cell.day.text = day[indexPath.row].dayOfDate()
//            cell.month.text = day[indexPath.row].monthOfDate()?.prefix(3).uppercased()
//            cell.dayWeek.text = day[indexPath.row].dayOfWeek()?.uppercased()
        }

        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 2.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        timeLabel.text = ""

        for element in buttonsTimeArray {
            element.isHidden = true
            element.backgroundColor = UIColor.white
            element.setTitleColor(UIColor.black, for: .normal)
        }
        let remainder = dateArray.count % 12
        if remainder != 0 {
            if indexPath.row == 0 {
                var arr = [Int]()
                arr.removeAll()
                for i in 0..<remainder {
                    arr.append(Int(dateArray[i].hours!)!)
                }
                for element in arr {
                    for btn in buttonsTimeArray {
                        if element == btn.tag {
                            btn.isHidden = false
                        }
                    }
                }
            } else {
                var arr = [Int]()
                arr.removeAll()
                let start = remainder + (indexPath.row - 1) * 12
                let finish = remainder + (indexPath.row) * 12
                for i in start..<finish {
                    arr.append(Int(dateArray[i].hours!)!)
                }

                for element in arr {
                    for btn in buttonsTimeArray {
                        if element == btn.tag {
                            btn.isHidden = false
                        }
                    }
                }
            }
        } else {
            for element in buttonsTimeArray {
                element.isHidden = false
            }
        }
    
        var indexes = [Int]()
        for i in 0..<dateArray.count {
            if !dateArray[i].available {
                indexes.append(i)
            }
        }

        guard let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionCell else { return }
        
        
        for index in indexes {
            if indexPath.row == 0 {
                if index < remainder {
                    for btn in buttonsTimeArray {
                        if btn.tag == Int(dateArray[index].hours!)! {
                            btn.isHidden = true
                        }
                    }
                }
            }
            if indexPath.row > 0 {
                if dateArray[index].day == cell.day.text {
                    for btn in buttonsTimeArray {
                        if btn.tag == Int(dateArray[index].hours!)! {
                            btn.isHidden = true
                        }
                    }
                }
            }
        }
        
        
//        for index in indexes {
//            if index >= remainder {
//                let page = (index - remainder) / 12
//                if page == indexPath.row {
//                    if index <= 12 {
//                        buttonsTimeArray[index].isHidden = true
//                    } else {
//                        buttonsTimeArray[index % 12].isHidden = true
//                    }
//                }
//            } else {
//                if indexPath.row == 0 {
//                    buttonsTimeArray[index].isHidden = true
//                }
//            }
//
//        }
            print(indexes)
        

        cell.layer.borderWidth = 0
        cell.day.textColor = UIColor.red
        selectedDate = cell.dayWeek.text! + " " + cell.day.text! + " " + cell.month.text!
        dateLabel.text = selectedDate
        dateLabel.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionCell else { return }
        cell.layer.borderWidth = 2
        cell.day.textColor = UIColor.black
    }

    func monthToNumber(monthString: String) -> Int {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "LLLL"
        if let date = df.date(from: monthString) {
            let month = Calendar.current.component(.month, from: date)
            return month
        }
        return 0
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string == "\n") {
            textField.resignFirstResponder()
        }
        
        if textField.tag == 1 {
            switch string {
            case "0","1","2","3","4","5","6","7","8","9":
                
                guard let text = textField.text else { return true }
                let newLength = text.count + string.count - range.length
                return newLength <= 11 // Bool
                
            default :
                let array = Array(string)
                if array.count == 0 {
                    return true
                }
                
            }
            return false
        }
        return true
    }
    
    @IBAction func changePhone(_ sender: UITextField) {
        if numberField.text?.first != "0" {
            numberField.text = ""
        }
    }

    @IBAction func changeFname(_ sender: UITextField) {
        if firstNameField.text?.count == 1 {
            firstNameField.text? = (firstNameField.text?.uppercased())!
        }
    }
    
    @IBAction func changeLastName(_ sender: UITextField) {
        if lastNameField.text?.count == 1 {
            lastNameField.text? = (lastNameField.text?.uppercased())!
        }
    }
    
    @IBAction func bookNow(_ sender: UIButton) {
        var isValid = false
        if (emailField.text?.contains("@"))! {
            if (emailField.text?.contains("."))! {
                isValid = true
            }
        }
        
        if !isValid {
            let alert = UIAlertController(title: "Warning", message: "Please enter a valid email", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            }))
            self.present(alert, animated: true, completion: nil)
        } else {

        if (mortgageField.text?.isEmpty)! || (emailField.text?.isEmpty)! || (numberField.text?.isEmpty)! || (branchField.text?.isEmpty)! || (lastNameField.text?.isEmpty)! || (firstNameField.text?.isEmpty)! || dateLabel.isHidden || timeLabel.text == "" {
            let alert = UIAlertController(title: "Warning", message: "Please, fill the fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                }))
            self.present(alert, animated: true, completion: nil)
        } else {

        let bookInstance = BookModel()
        let predicate = NSPredicate(format: "name LIKE [c] %@", selectedBranch)
        let branch = realm.objects(BranchModel.self).filter(predicate)
        
        let splittedDate = dateLabel.text!.components(separatedBy: " ")
        let month = monthToNumber(monthString: splittedDate[2])
        var monthString = ""
        if month < 10 {
            monthString = "0" + String(describing: month)
        } else {
            monthString = String(describing: month)
        }
        let timeString = timeLabel.text!
        let splittedTime = timeString.components(separatedBy: ":")
            
        let hours = Int(splittedTime[0])
        var finalTime = ""
        if hours! < 10 {
            finalTime = "0" + splittedTime[0] + ":" + splittedTime[1]
        } else {
            finalTime = splittedTime[0] + ":" + splittedTime[1]
        }
        let finalDate = "2018" + "-" + monthString + "-" + splittedDate[1] + "T" + finalTime + ":00"
        bookInstance.date = finalDate
        bookInstance.email = emailField.text!
        bookInstance.fname = firstNameField.text!
        bookInstance.lname = lastNameField.text!
        bookInstance.number = numberField.text!
        bookInstance.name = firstNameField.text! + " " + lastNameField.text!
        bookInstance.branchName = selectedBranch
        bookInstance.branchId = branch.first!.id
        bookInstance.reason = mortgageField.text!
        bookInstance.bookingType = 2
        bookInstance.modifiedDate = branch.first!.modifiedDate
        bookInstance.comment = commentField.text
        RealmService.writeIntoRealm(object: bookInstance)
            
        SaveBook.saveBook { (completion) in
            if completion {
                self.pushVC(identifier: "kThanksVC")
            }
        }
        }
        }
    }

    @IBAction func mortgageOpen(_ sender: UIButton) {
        let dropDown = DropDown()
        dropDown.anchorView = mortgageField
        dropDown.dataSource = ["First time buyer", "Remortgage", "Moving home", "Buy to let"]
        
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.mortgageField.text = item
        }
    }
    
    @IBAction func branchOpen(_ sender: UIButton) {
        let dropDown = DropDown()
        dropDown.anchorView = mortgageField
        var array = [String]()
        for element in RealmService.getBranches() {
            array.append(element.name!)
        }
        dropDown.dataSource = array
        
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.branchField.text = item
            let predicate = NSPredicate(format: "name LIKE [c] %@", item)
            let branch = self.realm.objects(BranchModel.self).filter(predicate)
            let br = String(describing: branch.first!.id)
            UserDefaults.standard.set("2", forKey: "appType")
            UserDefaults.standard.set(br, forKey: "branchId")
            self.getSlots()
            self.selectedBranch = item
            self.splitDate(branchName: item)
            self.dateCollectionView.reloadData()
        }
    }
    
    func getSlots() {
        GetSlots.getSlots { (completion, arr) in
            if completion {
                self.dateArray.removeAll()
                self.dateArray = arr
                self.dateCollectionView.reloadData()
            }
        }
    }
    
    func monthToString(month: String) -> String {
        switch month {
        case "01":
            return "JAN"
        case "02":
            return "FEB"
        case "03":
            return "MAR"
        case "04":
            return "APR"
        case "05":
            return "MAY"
        case "06":
            return "JUN"
        case "07":
            return "JUL"
        case "08":
            return "AUG"
        case "09":
            return "SEP"
        case "10":
            return "OCT"
        case "11":
            return "NOV"
        case "12":
            return "DEC"
        default:
            return ""
        }
    }
    
    func splitDate(branchName: String){

        let predicate = NSPredicate(format: "name LIKE [c] %@", branchName)
        let branch = realm.objects(BranchModel.self).filter(predicate)
        let fullDate = branch.first!.modifiedDate!.components(separatedBy: "T")
        let date = fullDate[0]
        let time = fullDate[1]
        
        let splittedDate = date.components(separatedBy: "-")
        let splittedTime = time.components(separatedBy: ":")
        RealmService.deleteBranchTime()
        let timeInstance = BranchTimeModel()
        timeInstance.year = splittedDate[0]
        timeInstance.month = splittedDate[1]
        timeInstance.day = splittedDate[2]
        timeInstance.hour = splittedTime[0]
        timeInstance.minute = splittedTime[1]
        timeInstance.second = splittedTime[2]
        timeInstance.name = branch.first!.name!
        RealmService.writeIntoRealm(object: timeInstance)
        
    }

    @IBAction func backToStartVC(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
}

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEEEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
    func monthOfDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
    func dayOfDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}


extension Date {
    
    func allDates(till endDate: Date, startDate: String) -> [Date] {


        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard var date = dateFormatter.date(from: startDate) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        
       
        var array: [Date] = []
        while date <= endDate {
            array.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        return array
    }

}

extension VideoVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == self.emailField ||
            textField == self.numberField ||
            textField == self.firstNameField ||
            textField == self.lastNameField) &&
            !isKeyboardShow {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.view.frame.origin.y -= 150
            }
            isKeyboardShow = true
        }
        if (textField == self.commentField && !isKeyboardShow) {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.view.frame.origin.y -= 350
            }
            isKeyboardShow = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == self.emailField ||
            textField == self.numberField ||
            textField == self.firstNameField ||
            textField == self.lastNameField) &&
            isKeyboardShow {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.view.frame.origin.y += 150
            }
            isKeyboardShow = false
        }
        if (textField == self.commentField && isKeyboardShow) {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.view.frame.origin.y += 350
            }
            isKeyboardShow = false
        }
    }
    
}

