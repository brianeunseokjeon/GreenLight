//
//  RegisterViewController.swift
//  GreenLight
//
//  Created by brian은석 on 27/08/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var pw: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func register(_ sender: Any) {
        print(1)
        Auth.auth().createUser(withEmail: id.text ?? "", password: pw.text ?? "") { (user, error) in
            if user !=  nil{
                print("register success")
            }
            else{
                print("register failed")
            }
        }
    }
}
