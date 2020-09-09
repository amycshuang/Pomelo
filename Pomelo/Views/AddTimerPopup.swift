//
//  AddTimerPopup.swift
//  Pomelo
//
//  Created by Amy Chin Siu Huang on 9/1/20.
//  Copyright © 2020 Amy Chin Siu Huang. All rights reserved.
//

import UIKit
import SnapKit

class AddTimerPopup: UIView {
    
    var instructionLabel: UILabel!
    var quickStudyButton: UIButton!
    var newTimerButton: UIButton!
    var cancelButton: UIButton!
    
    weak var timerDelegate: AddTimerProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightWhite
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
        instructionLabel = UILabel()
        instructionLabel.font = Font.robotoFont(font: .medium, size: 26)
        instructionLabel.textColor = .darkGray
        instructionLabel.text = "Choose An Option"
        self.addSubview(instructionLabel)
        
        quickStudyButton = UIButton()
        quickStudyButton.setTitle("Quick Study", for: .normal)
        quickStudyButton.backgroundColor = .seaGreen
        quickStudyButton.layer.cornerRadius = 16
        quickStudyButton.clipsToBounds = true
        quickStudyButton.setTitleColor(.darkGray, for: .normal)
        quickStudyButton.titleLabel?.font = Font.robotoFont(font: .regular, size: 22)
        quickStudyButton.addTarget(self, action: #selector(presentQuickStudy), for: .touchUpInside)
        self.addSubview(quickStudyButton)
        
        newTimerButton = UIButton()
        newTimerButton.setTitle("New Timer", for: .normal)
        newTimerButton.backgroundColor = .niceBlue
        newTimerButton.layer.cornerRadius = 16
        newTimerButton.clipsToBounds = true
        newTimerButton.setTitleColor(.darkGray, for: .normal)
        newTimerButton.titleLabel?.font = Font.robotoFont(font: .regular, size: 22)
        newTimerButton.addTarget(self, action: #selector(presentNewTimer), for: .touchUpInside)
        self.addSubview(newTimerButton)
        
        cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.lightGray, for: .normal)
        cancelButton.titleLabel?.font = Font.robotoFont(font: .regular, size: 24)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        self.addSubview(cancelButton)
        
        setUpConstraints()
    }
    
    @objc func presentQuickStudy() {
        timerDelegate?.quickStudy()
    }
    
    @objc func presentNewTimer() {
        timerDelegate?.newpomeloTimer()
    }
    
    @objc func cancel() {
        timerDelegate?.cancelAdd()
    }
    
    func setUpConstraints() {
        
        instructionLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(30)
        }
        
        quickStudyButton.snp.makeConstraints { (make) in
            make.width.equalTo(self.snp.width).offset(-80)
            make.height.equalTo(50)
            make.top.equalTo(instructionLabel.snp.bottom).offset(15)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        newTimerButton.snp.makeConstraints { (make) in
            make.width.equalTo(quickStudyButton.snp.width)
            make.height.equalTo(50)
            make.top.equalTo(quickStudyButton.snp.bottom).offset(15)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(newTimerButton.snp.bottom).offset(15)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
