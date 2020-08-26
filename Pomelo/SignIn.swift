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
import Lottie

class SignIn: UIViewController {

    var welcomeLabel: UILabel!
    var signInButton: GIDSignInButton!
    var animatiomView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        self.navigationController?.navigationBar.isHidden = true
        
        
        welcomeLabel = UILabel()
        welcomeLabel.font = .systemFont(ofSize: 40, weight: .bold)
        welcomeLabel.textAlignment = .center
        welcomeLabel.numberOfLines = 0
        welcomeLabel.alpha = 0
        welcomeLabel.text = "Pomelo"
        view.addSubview(welcomeLabel)
        
        signInButton = GIDSignInButton()
        signInButton.style = .wide
        signInButton.colorScheme = .light
        signInButton.alpha = 0
        view.addSubview(signInButton)
        
        animatiomView = AnimationView(name: "pomeloanimation")
        animatiomView.animationSpeed = 2.5
        view.addSubview(animatiomView)
        
        setUpConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animatiomView.play()
        animatiomView.loopMode = .autoReverse
        welcomeLabel.fadeIn(button: signInButton)
    }
    
    func setUpConstraints() {
        
        welcomeLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.top.equalTo(view.snp.top).offset(150)
            make.centerX.equalToSuperview()
        }
        
        animatiomView.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.width.height.equalTo(250)
        }
        
        signInButton.snp.makeConstraints { (make) in
            make.top.equalTo(animatiomView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
    }

}
