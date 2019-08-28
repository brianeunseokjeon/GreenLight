//
//  SaveViewController.swift
//  GreenLight
//
//  Created by brian은석 on 28/08/2019.
//  Copyright © 2019 brian. All rights reserved.
//

import UIKit
import Firebase

class SaveViewController: UIViewController {

    let quoteLabel = UILabel()
    let quoteTextField = UITextField()
    let authorTextField = UITextField()
    let saveButton = UIButton()
    let fetchButton = UIButton()
    var docRef: DocumentReference!
    var quoteListener: ListenerRegistration!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        actionTarget()
        docRef = Firestore.firestore().document("sampleData/inspiration")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 서버에서 무언갈 고칠때 앱에서도 변경
        let verboseOption = 
        
        
       quoteListener = docRef.addSnapshotListener { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists,
                let myData = docSnapshot.data() else {return}
            let latestQuote = myData["quote"] as? String ?? ""
            let latestAuthor = myData["author"] as? String ?? ""
            self.quoteLabel.text = "내용:\(latestQuote) ----저자:\(latestAuthor)"
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        quoteListener.remove()
    }
    
    private func setupUI() {
        let baselayoutsetting = [quoteLabel,quoteTextField,authorTextField,saveButton,fetchButton]
        baselayoutsetting.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        quoteLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 30).isActive = true
        quoteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        quoteLabel.text = "하이"
        
        
        quoteTextField.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor,constant: 50).isActive = true
        quoteTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 50).isActive = true
        quoteTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -50).isActive = true
        quoteTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        quoteTextField.backgroundColor = #colorLiteral(red: 0.9061310887, green: 0.9154139161, blue: 0.5471322536, alpha: 1)

        authorTextField.topAnchor.constraint(equalTo: quoteTextField.bottomAnchor,constant: 50).isActive = true
        authorTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 50).isActive = true
        authorTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -50).isActive = true
        authorTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true

        authorTextField.backgroundColor = #colorLiteral(red: 0.8258843422, green: 0.9507638812, blue: 0.9530327916, alpha: 1)

        saveButton.topAnchor.constraint(equalTo: authorTextField.bottomAnchor,constant: 50).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 50).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -50).isActive = true
        saveButton.setTitle("저장", for: .normal)
        saveButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        saveButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        fetchButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor,constant: 20).isActive = true
        fetchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 50).isActive = true
        fetchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -50).isActive = true
        fetchButton.setTitle("패치", for: .normal)
        fetchButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        fetchButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
    }
    private func actionTarget() {
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        fetchButton.addTarget(self, action: #selector(fetchAction), for: .touchUpInside)
    }
    @objc func fetchAction() {
        docRef.getDocument { (docSnapshot, error) in
            guard let docSnapshot = docSnapshot, docSnapshot.exists,
            let myData = docSnapshot.data() else {return}
            let latestQuote = myData["quote"] as? String ?? ""
            let latestAuthor = myData["author"] as? String ?? ""
            self.quoteLabel.text = "내용:\(latestQuote) ----저자:\(latestAuthor)"
        }
    }
    
    @objc func saveAction() {
        guard let quoteText = quoteTextField.text, !quoteText.isEmpty else { return }
        guard let quoteAuthor = authorTextField.text, !quoteAuthor.isEmpty else { return}
      
        let dataToSave :[String:Any] = ["quote":quoteText,"author":quoteAuthor]
        
        docRef.setData(dataToSave) { (error) in
            if let error = error {
                print("Oh no! Got an error: \(error.localizedDescription)" )
            } else {
                print("Data has been saved")
            }
        }

    }
}
