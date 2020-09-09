//
//  TimerCollectionViewCell.swift
//  Pomelo
//
//  Created by Amy Chin Siu Huang on 9/1/20.
//  Copyright © 2020 Amy Chin Siu Huang. All rights reserved.
//

import UIKit

class TimerCollectionViewCell: UICollectionViewCell {
    
    var subjectLabel: UILabel!
    var divider: UILabel!
    var timeLabel: UILabel!
    var playlistLabel: UILabel!
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.17
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: 0, height: 8)
        contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: 12).cgPath

        subjectLabel = UILabel()
        subjectLabel.textColor = .black
        subjectLabel.font = Font.robotoFont(font: .medium, size: 22)
        contentView.addSubview(subjectLabel)
        
        divider = UILabel()
        divider.textColor = .black
        divider.text = "|"
        contentView.addSubview(divider)
        
        timeLabel = UILabel()
        timeLabel.textColor = .black
        timeLabel.font = Font.robotoFont(font: .regular, size: 14)
        contentView.addSubview(timeLabel)
        
        playlistLabel = UILabel()
        playlistLabel.textColor = .lightGray
        playlistLabel.font = Font.robotoFont(font: .medium, size: 16)
        contentView.addSubview(playlistLabel)
        
        setUpConstraints()
    }
    
    func configure(for timer: PomeloTimer) {
        subjectLabel.text = timer.subject
        timeLabel.text = timer.length
        playlistLabel.text = timer.playlist
        switch timer.category {
        case .humanities:
            contentView.backgroundColor = .humanitiesPink
        case .math:
            contentView.backgroundColor = .mathBlue
        case .lanaguage:
            contentView.backgroundColor = .languageYellow
        case .science:
            contentView.backgroundColor = .scienceGreen
        case .other:
            contentView.backgroundColor = .otherViolet
        }
    }
    
    func setUpConstraints() {
        subjectLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(20)
            make.top.equalTo(contentView.snp.top).offset(15)
        }
        divider.snp.makeConstraints { (make) in
            make.bottom.equalTo(subjectLabel.snp.bottom)
            make.left.equalTo(subjectLabel.snp.right).offset(5)
            make.height.equalTo(subjectLabel.snp.height)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(subjectLabel.snp.centerY).offset(2)
            make.left.equalTo(divider.snp.right).offset(5)
        }
        playlistLabel.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel.snp.left)
            make.top.equalTo(subjectLabel.snp.bottom).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
