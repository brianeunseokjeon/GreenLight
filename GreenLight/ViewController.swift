//
//  ViewController.swift
//  GreenLight
//
//  Created by brian은석 on 27/08/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
  
    func status() {
        if let user = Auth.auth().currentUser {
            emailTextField.placeholder = "이미 로그인 된 상태"
            passwordTextField.placeholder = "이미 로그인 된 상태"
            
        } else {
            emailTextField.placeholder = "로그아웃"
            passwordTextField.placeholder = "로그아웃"
        }
    }
    @IBAction func loginButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (user, error) in
            if user != nil {
                self.status()
                print("success")
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            status()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController")
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
}

