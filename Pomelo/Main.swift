//
//  Main.swift
//  Pomelo
//
//  Created by Amy Chin Siu Huang on 8/25/20.
//  Copyright © 2020 Amy Chin Siu Huang. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import GoogleSignIn

class Main: UIViewController {
    
    var signoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpNavBar()
        
        signoutButton = UIButton()
        signoutButton.setTitle("Sign Out", for: .normal)
        signoutButton.layer.cornerRadius = 12
        signoutButton.layer.borderWidth = 1
        signoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        signoutButton.setTitleColor(UIColor(red: 0.4549, green: 0.7255, blue: 1, alpha: 1.0), for: .normal)
        signoutButton.layer.borderColor = UIColor(red: 0.4549, green: 0.7255, blue: 1, alpha: 1.0).cgColor
        signoutButton.addTarget(self, action: #selector(signoutUser), for: .touchUpInside)
        view.addSubview(signoutButton)
        setUpConstraints()
    }
    
    func setUpNavBar() {
        title = "Pomelo Timers"
        navigationController?.navigationBar.barTintColor = .pomeloPink
        navigationController?.view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func signoutUser() {
        GIDSignIn.sharedInstance()?.signOut()
        let sceneDelegate = self.view.window!
        sceneDelegate.rootViewController = SignIn()
    }
    
    func setUpConstraints() {
        signoutButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
    


}

