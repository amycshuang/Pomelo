//
//  QuickStudy.swift
//  Pomelo
//
//  Created by Amy Chin Siu Huang on 9/1/20.
//  Copyright © 2020 Amy Chin Siu Huang. All rights reserved.
//

import UIKit
import SnapKit
import UserNotifications

class QuickStudy: UIViewController {
    
    var cancelButton: UIBarButtonItem!
    var timeLabel: UILabel!
    var taskLabel: UILabel!
    var taskTextField: UITextField!
    var lengthLabel: UILabel!
    var lengthTextField: UITextField!
    var startButton: UIButton!
    var circle: CircularProgressBar!
    
    var timePicker: UIPickerView!
    var toolbar: UIToolbar!
    var minutes: Int = 0
    var seconds: Int = 0
    
    var timer: Timer?
    var endTime: Date?
    var secondsRemaining: TimeInterval = 0
    let padding: CGFloat = 10
    var defaults = UserDefaults.standard
    let endTimeKey = "endTime"
    
    var notificationContent = UNMutableNotificationContent()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavBar()
        
        circle = CircularProgressBar(frame: CGRect(origin: self.view.center, size: CGSize(width: 225, height: 225)))
        circle.setLineColor(color: .seaGreen)
        view.addSubview(circle)
        
        timeLabel = UILabel()
        timeLabel.textColor = .seaGreen
        timeLabel.font = Font.robotoFont(font: .medium, size: 50)
        circle.addSubview(timeLabel)
        updateLabel()
        
        taskLabel = UILabel()
        taskLabel.text = "Task"
        taskLabel.textColor = .black
        taskLabel.font = Font.robotoFont(font: .regular, size: 18)
        view.addSubview(taskLabel)
        
        taskTextField = UITextField()
        taskTextField.backgroundColor = .textFieldGray
        taskTextField.layer.cornerRadius = 10
        taskTextField.clipsToBounds = true
        taskTextField.setLeftPadding(padding: padding)
        taskTextField.setRightPadding(padding: padding)
        view.addSubview(taskTextField)
        
        lengthLabel = UILabel()
        lengthLabel.text = "Length"
        lengthLabel.textColor = .black
        lengthLabel.font = Font.robotoFont(font: .regular, size: 18)
        view.addSubview(lengthLabel)
        
        timePicker = UIPickerView()
        timePicker.delegate = self
    
        lengthTextField = UITextField()
        lengthTextField.backgroundColor = .textFieldGray
        lengthTextField.layer.cornerRadius = 10
        lengthTextField.clipsToBounds = true
        lengthTextField.setLeftPadding(padding: padding)
        lengthTextField.setRightPadding(padding: padding)
        lengthTextField.inputView = timePicker
        view.addSubview(lengthTextField)
        
        startButton = UIButton()
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.timerGrayColor, for: .normal)
        startButton.backgroundColor = .seaGreen
        startButton.layer.cornerRadius = 20
        startButton.clipsToBounds = true
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        view.addSubview(startButton)
        
        setUpNotifications()
        setUpObservers()
        setUpToolBar()
        setUpConstraints()
    }
    
    func setUpNotifications() {
        notificationContent.title = "Pomelo"
        notificationContent.body = "Yay! Your quick timer is up!"
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge, .provisional]) { granted, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setUpObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(movedToBackground), name: UIScene.willDeactivateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(movedToForeground), name: UIScene.willEnterForegroundNotification, object: nil)
    }
    
    @objc func movedToBackground() {
        if timer != nil && endTime != nil {
            timer?.invalidate()
            defaults.setValue(endTime, forKey: endTimeKey)
        }
    }
    
    @objc func movedToForeground() {
        if let date = defaults.value(forKey: endTimeKey) as? Date {
            if date > Date() {
                let dateDifference = Int(date.timeIntervalSinceNow)
                let dateDifferenceDouble = Double(dateDifference)
                secondsRemaining = dateDifferenceDouble
                startTimer()
            }
            else {
                endTimer()
            }
            defaults.setValue(nil, forKey: endTimeKey)
        }
    }
    
    func setUpToolBar() {
        toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 44)))
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneSelectingTime))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        lengthTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneSelectingTime() {
        setLength()
        view.endEditing(true)
    }
    
    func setLength() {
        lengthTextField.text = "\(minutes) min and \(seconds) s"
        secondsRemaining = TimeInterval((60*minutes) + seconds)
    }
    
    @objc func startTapped() {
        if taskTextField.text?.trimmingCharacters(in: .whitespaces).count != 0 {
            if timer == nil || timer != nil && endTime == nil {
                startTimer()
            }
            else if timer != nil && endTime != nil {
                pauseTimer()
            }
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Please enter a task name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func tickTimer() {
        secondsRemaining = secondsRemaining - 1
        if secondsRemaining >= 0 {
             updateLabel()
         }
        if secondsRemaining == 0 {
            endTimer()
        }
    }
    
    func startTimer() {
        if lengthTextField.text?.count == 0 {
            setLength()
        }
        if secondsRemaining != 0 {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickTimer), userInfo: nil, repeats: true)
            endTime = Date(timeIntervalSinceNow: secondsRemaining)
            setTextFieldStartBackground()
            if secondsRemaining >= 0 {
                updateLabel()
            }
            startButton.setTitle("Pause", for: .normal)
            startButton.backgroundColor = .white
            if let endTime = endTime {
                startNotification(endTime: endTime)
            }
        }
    }
    
    func setTextFieldStartBackground() {
        taskTextField.backgroundColor = .clear
        taskTextField.isUserInteractionEnabled = false
        lengthTextField.backgroundColor = .clear
        lengthTextField.isUserInteractionEnabled = false
    }
    
    func startNotification(endTime: Date) {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: endTime)
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: notificationContent, trigger: notificationTrigger)

        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if let error = error {
            print(error.localizedDescription)
           }
        }
    }
    
    func endTimer() {
        timer?.invalidate()
        timer = nil
        endTime = nil
        startButton.setTitle("Restart", for: .normal)
        startButton.backgroundColor = .seaGreen
        taskTextField.backgroundColor = .textFieldGray
        taskTextField.isUserInteractionEnabled = true
        lengthTextField.backgroundColor = .textFieldGray
        lengthTextField.isUserInteractionEnabled = true
        setLength()
        updateLabel()
    }
    
    func pauseTimer() {
        timer?.invalidate()
        endTime = nil
        startButton.setTitle("Continue", for: .normal)
        startButton.backgroundColor = .seaGreen
    }
    
    func updateLabel() {
        let totalSeconds = Int(secondsRemaining)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        
        if minutes < 10 && seconds < 10 {
            timeLabel.text = "0\(minutes):0\(seconds)"
        }
        else if minutes < 10 && !(seconds < 10) {
            timeLabel.text = "0\(minutes):\(seconds)"
        }
        else if seconds < 10 && !(minutes < 10){
            timeLabel.text = "\(minutes):0\(seconds)"
        }
        else {
            timeLabel.text = "\(minutes):\(seconds)"
        }
    }
    
    func setUpNavBar() {
        title = "Quick Study"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.font: Font.robotoFont(font: .bold, size: 16)]
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelQuickTimer))
        cancelButton.tintColor = .darkGray
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.font: Font.robotoFont(font: .regular, size: 16)], for: .normal)
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    @objc func cancelQuickTimer() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpConstraints() {
        let textFieldHeight: CGFloat = 28
        let textFieldWidth: CGFloat = 222
        
        circle.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.width.height.equalTo(225)
            make.top.equalTo(view.snp.top).offset(128)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(circle.snp.centerX)
            make.centerY.equalTo(circle.snp.centerY)
            make.height.equalTo(60)
        }
        startButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(540)
            make.width.equalTo(180)
            make.height.equalTo(38)
        }
        taskLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(50)
            make.top.equalTo(view.snp.top).offset(416)
        }
        taskTextField.snp.makeConstraints { (make) in
            make.left.equalTo(taskLabel.snp.right).offset(40)
            make.top.equalTo(taskLabel.snp.top)
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
        }
        lengthLabel.snp.makeConstraints { (make) in
            make.left.equalTo(taskLabel.snp.left)
            make.top.equalTo(taskLabel.snp.bottom).offset(40)
        }
        lengthTextField.snp.makeConstraints { (make) in
            make.left.equalTo(taskTextField.snp.left)
            make.top.equalTo(lengthLabel.snp.top)
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
        }
    }

}

extension QuickStudy: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.width/2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            if row == 1 {
                return "\(row) minutes"
            }
            return "\(row) minutes"
        case 1:
            if row == 1 {
                return "\(row) seconds"
            }
            return "\(row) seconds"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            minutes = row
        case 1:
            seconds = row
        default:
            break
        }
    }
    
}
