//
//  NewTimer.swift
//  Pomelo
//
//  Created by Amy Chin Siu Huang on 9/1/20.
//  Copyright © 2020 Amy Chin Siu Huang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class NewTimer: UIViewController {
    
    var cancelButton: UIBarButtonItem!
    
    var subjectLabel: UILabel!
    var subjectTextField: UITextField!
    var lengthLabel: UILabel!
    var lengthTextField: UITextField!
    var categoryLabel: UILabel!
    var addNewTimerButton: UIButton!
    
    var subjectCollectionView: UICollectionView!
    let subjectReuseIdentifier = "subjectReuseIdentifier"
    var subjectRow1: [Subject] = [Subject(subject: .humanities, isSelected: false), Subject(subject: .math, isSelected: false), Subject(subject: .language, isSelected: false)]
    var subjectRow2: [Subject] = [Subject(subject: .science, isSelected: false), Subject(subject: .other, isSelected: false)]
    var selectedSubject: Subject?
    
    let textFieldPadding: CGFloat = 10
    let collectionViewPadding: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavBar()
        
        subjectLabel = UILabel()
        subjectLabel.text = "Subject"
        subjectLabel.textColor = .black
        subjectLabel.font = Font.robotoFont(font: .regular, size: 18)
        view.addSubview(subjectLabel)
        
        subjectTextField = UITextField()
        subjectTextField.backgroundColor = .textFieldGray
        subjectTextField.layer.cornerRadius = 10
        subjectTextField.clipsToBounds = true
        subjectTextField.setLeftPadding(padding: textFieldPadding)
        subjectTextField.setRightPadding(padding: textFieldPadding)
        view.addSubview(subjectTextField)
        
        lengthLabel = UILabel()
        lengthLabel.text = "Length"
        lengthLabel.textColor = .black
        lengthLabel.font = Font.robotoFont(font: .regular, size: 18)
        view.addSubview(lengthLabel)
        
        lengthTextField = UITextField()
        lengthTextField.backgroundColor = .textFieldGray
        lengthTextField.layer.cornerRadius = 10
        lengthTextField.clipsToBounds = true
        lengthTextField.setLeftPadding(padding: textFieldPadding)
        lengthTextField.setRightPadding(padding: textFieldPadding)
        view.addSubview(lengthTextField)
        
        categoryLabel = UILabel()
        categoryLabel.text = "Category"
        categoryLabel.textColor = .black
        categoryLabel.font = Font.robotoFont(font: .regular, size: 18)
        view.addSubview(categoryLabel)
        
        let subjectLayout = UICollectionViewFlowLayout()
        subjectLayout.scrollDirection = .vertical
        subjectLayout.minimumLineSpacing = collectionViewPadding
        subjectLayout.minimumInteritemSpacing = collectionViewPadding
        subjectLayout.sectionInset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        subjectCollectionView = UICollectionView(frame: .zero, collectionViewLayout: subjectLayout)
        subjectCollectionView.backgroundColor = .clear
        subjectCollectionView.dataSource = self
        subjectCollectionView.delegate = self
        subjectCollectionView.register(SubjectCell.self, forCellWithReuseIdentifier: subjectReuseIdentifier)
        view.addSubview(subjectCollectionView)
        
        addNewTimerButton = UIButton()
        addNewTimerButton.setTitle("Add New Timer", for: .normal)
        addNewTimerButton.setTitleColor(.timerGrayColor, for: .normal)
        addNewTimerButton.backgroundColor = .niceBlue
        addNewTimerButton.layer.cornerRadius = 20
        addNewTimerButton.clipsToBounds = true
        addNewTimerButton.addTarget(self, action: #selector(timerAdded), for: .touchUpInside)
        view.addSubview(addNewTimerButton)
        
        setUpConstraints()
        
    }
    
    func setUpNavBar() {
        title = "New Pomelo Timer"
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
    
    @objc func timerAdded() {
        print("adding timer...")
    }
    
    func setUpConstraints() {
        let fieldHeight: CGFloat = 28
        let fieldWidth: CGFloat = 222
        
        subjectLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(38)
            make.top.equalTo(view.snp.top).offset(170)
        }
        
        subjectTextField.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel.snp.right).offset(20)
            make.top.equalTo(subjectLabel.snp.top)
            make.width.equalTo(fieldWidth)
            make.height.equalTo(fieldHeight)
        }
        
        lengthLabel.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel.snp.left)
            make.top.equalTo(subjectLabel.snp.bottom).offset(45)
        }
        
        lengthTextField.snp.makeConstraints { (make) in
            make.left.equalTo(subjectTextField.snp.left)
            make.top.equalTo(lengthLabel.snp.top)
            make.width.equalTo(fieldWidth)
            make.height.equalTo(fieldHeight)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel.snp.left)
            make.top.equalTo(lengthLabel.snp.bottom).offset(45)
        }
        
        subjectCollectionView.snp.makeConstraints { (make) in
            make.left.equalTo(categoryLabel.snp.right).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.top.equalTo(categoryLabel.snp.top)
            make.height.equalTo(80)
        }
        
        addNewTimerButton.snp.makeConstraints { (make) in
            make.top.equalTo(subjectCollectionView.snp.bottom).offset(45)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(180)
            make.height.equalTo(48)
        }
        
    }

}

extension NewTimer: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return subjectRow1.count
        }
        else {
            return subjectRow2.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = subjectCollectionView.dequeueReusableCell(withReuseIdentifier: subjectReuseIdentifier, for: indexPath) as! SubjectCell
        if indexPath.section == 0 {
            let subject = subjectRow1[indexPath.item]
            cell.configure(for: subject)
        }
        else if indexPath.section == 1 {
            let subject = subjectRow2[indexPath.item]
            cell.configure(for: subject)
        }
        return cell
    }
    
    
}

extension NewTimer: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        resetSubjectSelection()
        if indexPath.section == 0 {
            let subject = subjectRow1[indexPath.item]
            subject.isSelected.toggle()
            selectedSubject = subject
            subjectCollectionView.reloadData()
        }
        else if indexPath.section == 1 {
            let subject = subjectRow2[indexPath.item]
            subject.isSelected.toggle()
            selectedSubject = subject
            subjectCollectionView.reloadData()
        }
    }
    
    func resetSubjectSelection() {
        for subjectItem in subjectRow1 {
            subjectItem.isSelected = false
        }
        for subjectItem in subjectRow2 {
            subjectItem.isSelected = false
        }
    }
}

extension NewTimer: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let label = UILabel(frame: .zero)
            label.text = subjectRow1[indexPath.item].getSubject()
            label.sizeToFit()
            return CGSize(width: label.frame.width + 14, height: 28)
        }
            let label = UILabel(frame: .zero)
            label.text = subjectRow2[indexPath.item].getSubject()
            label.sizeToFit()
            return CGSize(width: label.frame.width + 14, height: 28)
    }
}
