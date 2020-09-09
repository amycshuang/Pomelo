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
    
    var addTimerButton: UIButton!
    var timerCollectionView: UICollectionView!
    var timerReuseIdentifier = "timerReuseIdentifier"
    var timers: [PomeloTimer] = []
    let padding: CGFloat = 20
    var addTimerPopup: AddTimerPopup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavBar()
        
        let timerLayout = UICollectionViewFlowLayout()
        timerLayout.scrollDirection = .vertical
        timerLayout.minimumInteritemSpacing = padding
        timerLayout.minimumLineSpacing = padding
        
        timerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: timerLayout)
        timerCollectionView.backgroundColor = .white
        timerCollectionView.register(TimerCollectionViewCell.self, forCellWithReuseIdentifier: timerReuseIdentifier)
        timerCollectionView.dataSource = self
        timerCollectionView.delegate = self
        view.addSubview(timerCollectionView)
        
        testTimers()
        setUpConstraints()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addTimerButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTimerButton.isHidden = false
    }
    
    func testTimers() {
        var timer1 = PomeloTimer(subject: "Math", length: "30 minutes", playlist: "BTS August", category: .math)
        var timer2 = PomeloTimer(subject: "Humanities", length: "30 minutes", playlist: "BTS August", category: .humanities)
        var timer3 = PomeloTimer(subject: "Language", length: "30 minutes", playlist: "BTS August", category: .lanaguage)
        var timer4 = PomeloTimer(subject: "Science", length: "30 minutes", playlist: "BTS August", category: .science)
        var timer5 = PomeloTimer(subject: "Self-Study", length: "30 minutes", playlist: "BTS August", category: .other)
        timers = [timer1, timer2, timer3, timer4, timer5, timer3, timer4, timer5]
    }
    
    @objc func presentAddTimerView() {
        addTimerPopup = AddTimerPopup()
        addTimerPopup.alpha = 0
        addTimerPopup.timerDelegate = self
        view.addSubview(addTimerPopup)
        setPopupConstraints()
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.addTimerPopup.alpha = 1
            self.addTimerPopup.center.y = self.view.center.y
        }, completion: nil)
        
    }
    
    func setPopupConstraints() {
        addTimerPopup.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(280)
            make.height.equalTo(260)
        }
    }
    
    @objc func signoutUser() {
        GIDSignIn.sharedInstance()?.signOut()
        let sceneDelegate = self.view.window!
        sceneDelegate.rootViewController = SignIn()
    }
    
    func setUpNavBar() {
        title = "Pomelo Timers"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.font: Font.robotoFont(font: .bold, size: 28)]
        navigationController?.navigationBar.tintColor = .black
        
        addTimerButton = UIButton()
        addTimerButton.setImage(UIImage(named: "addtimericon"), for: .normal)
        addTimerButton.addTarget(self, action: #selector(presentAddTimerView), for: .touchUpInside)
        navigationController?.navigationBar.addSubview(addTimerButton)
    }
    
    func setUpConstraints() {
        addTimerButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(navigationController?.navigationBar.snp.bottom as! ConstraintRelatableTarget).offset(-13)
            make.trailing.equalTo(navigationController?.navigationBar.snp.trailing as! ConstraintRelatableTarget).offset(-30)
        }
        
        timerCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(25)
        }
    }

}

extension Main: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = timerCollectionView.dequeueReusableCell(withReuseIdentifier: timerReuseIdentifier, for: indexPath) as! TimerCollectionViewCell
        let timer = timers[indexPath.item]
        cell.configure(for: timer)
        return cell
    }
}

extension Main: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = timerCollectionView.frame.width - 50
        return CGSize(width: width, height: 90)
    }
}

extension Main: UICollectionViewDelegate {
    
}

extension Main: AddTimerProtocol {
    
    func quickStudy() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.addTimerPopup.center.y = self.view.frame.height
            self.addTimerPopup.alpha = 0
        }) { (Bool) in
            self.addTimerPopup.removeFromSuperview()
            let vc = QuickStudy()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            self.present(navVC, animated: true, completion: nil)
        }
    }
    
    func newpomeloTimer() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.addTimerPopup.center.y = self.view.frame.height
            self.addTimerPopup.alpha = 0
        }) { (Bool) in
            self.addTimerPopup.removeFromSuperview()
            let vc = NewTimer()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .overFullScreen
            self.present(navVC, animated: true, completion: nil)
        }
    }
    
    func cancelAdd() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.addTimerPopup.center.y = self.view.frame.height
            self.addTimerPopup.alpha = 0
        }) { (Bool) in
            self.addTimerPopup.removeFromSuperview()
        }
    }
    
    
}
