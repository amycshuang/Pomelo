//
//  SignIn.swift
//  Pomelo
//
//  Created by Amy Chin Siu Huang on 8/26/20.
//  Copyright © 2020 Amy Chin Siu Huang. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import SnapKit

class SignIn: UIViewController {

    var nameLabel: UILabel!
    var subLabel: UILabel!
    var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        self.navigationController?.navigationBar.isHidden = true
        
        
        nameLabel = UILabel()
        nameLabel.font = Font.robotoFont(font: .bold, size: 50)
        nameLabel.textAlignment = .center
        nameLabel.alpha = 0
        nameLabel.text = "Pomelo"
        view.addSubview(nameLabel)
        
        subLabel = UILabel()
        subLabel.font = Font.robotoFont(font: .regular, size: 20)
        subLabel.textAlignment = .center
        subLabel.alpha = 0
        subLabel.text = "study beautifully"
        view.addSubview(subLabel)
        
        signInButton = GIDSignInButton()
        signInButton.style = .wide
        signInButton.colorScheme = .light
        signInButton.alpha = 0
        view.addSubview(signInButton)
        
        setUpConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nameLabel.fadeIn(button: signInButton, subLabel: subLabel)
        if GIDSignIn.sharedInstance().hasPreviousSignIn() {
            DispatchQueue.main.async {
                GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            }
        }
    }
    
    func setUpConstraints() {
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY).offset(-80)
            make.centerX.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
        
        signInButton.snp.makeConstraints { (make) in
            make.top.equalTo(subLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
    }

}
