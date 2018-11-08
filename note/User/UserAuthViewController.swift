//
//  UserAuthViewController.swift
//  note
//
//  Created by Arseniy Zorin on 27/10/2018.
//  Copyright © 2018 ArseniyZ. All rights reserved.
//

import UIKit
import CoreData


class UserAuthViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    var myuser: User?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        self.hideKeyboardWhenTappedAround()
        
    }


    
    @IBAction func auth(_ sender:  Any) {
        let sv = UIViewController.displaySpinner(onView: self.view)
        if let username = usernameTextfield.text, let password = passwordTextfield.text{
        authUser(username: username, password: password) { (user) in
            UIViewController.removeSpinner(spinner: sv)
                if let user = user{
                    self.myuser = user
                    DispatchQueue.main.async{
                    self.saveUser(user: user)
                    self.performSegue(withIdentifier: "login", sender: nil)
                    }
                }
                else{
                    self.alertNotRegistered()
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login"{
            let destinationNav = segue.destination as! UINavigationController
            let destinationNote = destinationNav.topViewController as! NotesTableViewController
                destinationNote.currentUser = myuser
        }
    }
    
    @IBAction func unwindFromSegue(unwindSegue: UIStoryboardSegue) {
        passwordTextfield.text = ""
    }
    

}




extension UserAuthViewController{
    func authUser(username: String, password:String, completion: @escaping (_ user: User?) -> Void){
        if let url = URL(string: "http://trponote.eu5.net/Api/user/Auth.php?username=\(username)&password=\(password)"){
                URLSession.shared.dataTask(with: url){
                    data, response, error in
                    let JsonDecoder = JSONDecoder()
                    guard let data = data else {return}
                    if let user = try? JsonDecoder.decode(User.self, from: data){
                        completion(user)
                    }else{
                        completion(nil)
                    }
            }.resume()
        }
    }
    
    func alertNotRegistered(){
        DispatchQueue.main.async {
        let alert = UIAlertController(title: "Ошибка", message: "Пользователь с такими данными не найден!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func saveUser(user: User){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("notes_test").appendingPathExtension("plist")
        let encoder = PropertyListEncoder()
        let encodedUser = try? encoder.encode(user)
        try? encodedUser?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func getUser(){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("notes_test").appendingPathExtension("plist")
        let decoder = PropertyListDecoder()
        if let data = try? Data(contentsOf: archiveURL),
            let decodedUser = try? decoder.decode(User.self, from: data){
            myuser = decodedUser
            sqlController().checkToken(token: decodedUser.token, id: decodedUser.id){
                (codestatfs) in
                if codestatfs?.code == 1{
                    DispatchQueue.main.async{
                        self.performSegue(withIdentifier: "login", sender: nil)
                    }
                }
            }
           
        }
    }
}

