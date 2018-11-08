//
//  UserRegisterViewController.swift
//  note
//
//  Created by Arseniy Zorin on 03/11/2018.
//  Copyright © 2018 ArseniyZ. All rights reserved.
//

import UIKit

class UserRegisterViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func registerUser(_ sender: UIButton) {
        if let login = loginField.text, let password = passwordField.text, let email = emailField.text{
                sqlController().registerUser(email: email, password: password, login: login)
                navigationController?.popViewController(animated: true)
        }        
    }
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
         self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
