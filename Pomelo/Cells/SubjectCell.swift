//
//  SubjectCell.swift
//  Pomelo
//
//  Created by Amy Chin Siu Huang on 9/6/20.
//  Copyright © 2020 Amy Chin Siu Huang. All rights reserved.
//

import UIKit
import SnapKit

class SubjectCell: UICollectionViewCell {
    
    var subjectLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        
        subjectLabel = UILabel()
        subjectLabel.font = Font.robotoFont(font: .regular, size: 16)
        subjectLabel.textAlignment = .center
        contentView.addSubview(subjectLabel)
        
        setUpConstraints()
        
    }
    
    func configure(for subject: Subject) {
        subjectLabel.text = subject.getSubject()
        contentView.layer.borderColor = subject.getSubjectColor().cgColor
        if !subject.isSelected {
            subjectLabel.textColor = subject.getSubjectColor()
            contentView.backgroundColor = .white
        }
        else {
            subjectLabel.textColor = .white
            contentView.backgroundColor = subject.getSubjectColor()
        }
    }
    
    func setUpConstraints() {
        subjectLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
