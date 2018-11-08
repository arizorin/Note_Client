//
//  SQLController.swift
//  note
//
//  Created by Arseniy Zorin on 27/10/2018.
//  Copyright © 2018 ArseniyZ. All rights reserved.
//

import Foundation
import UIKit

class sqlController{
    
    var delegateNote: NoteDelegateController?
    
    func fetchNotesFromServer(tableView: UITableView, user: User){
        let urlString = "http://trponote.eu5.net/Api/note/notes.php?userID=\(user.id)"
        guard let url = URL(string: urlString) else {return}
    
        URLSession.shared.dataTask(with: url){ (data,response,error) in
            guard let data = data else {return}
            do{
                var note = try JSONDecoder().decode([Note].self, from: data)
                note.sort(by: { (a, b) -> Bool in
                   return a.createDate > b.createDate
                });
                self.delegateNote?.getNotesFromServer(notesArray: note)
                 DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
            catch let jsonError{
                print(jsonError)
            }
            }.resume()
    }
    
    

    func saveNote(user: User, note: Note){
        let qureis = ["token":"\(user.token)","userID":"\(user.id)", "name": "\(note.name)", "text":"\(note.text)", "id":"\(note.id)", "createDate":"\(note.createDate)"]
        let baseUrl = URL(string:"http://trponote.eu5.net/Api/note/saveNote.php")!
    
        guard let url = baseUrl.urlwith(qureis) else {return}
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
        }
        task.resume()
      //  request.httpBody = params.data(using: .utf8)

    }
    
    
    func addNote(user: User, note: Note){
        let qureis = ["token":"\(user.token)","userID":"\(user.id)", "name": "\(note.name)", "text":"\(note.text)", "createDate":"\(note.createDate)"]
        print(qureis)
        let baseUrl = URL(string:"http://trponote.eu5.net/Api/note/addNote.php")!
        print("\(baseUrl)")
        guard let url = baseUrl.urlwith(qureis) else {return}
        print(url)
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
        }
        task.resume()
        //  request.httpBody = params.data(using: .utf8)
    }
    
    func deleteNote(user: User, note: Note){
        let qureis = ["token":"\(user.token)","userID":"\(user.id)", "id": "\(note.id)"]
        let baseUrl = URL(string:"http://trponote.eu5.net/Api/note/deleteNote.php")!
        guard let url = baseUrl.urlwith(qureis) else {return}
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
        }
        task.resume()
        //  request.httpBody = params.data(using: .utf8)
    }
    
    
    func registerUser(email: String, password: String, login: String){
        let qureis = ["name":"\(login)","password":"\(password)", "email": "\(email)"]
        let baseUrl = URL(string:"http://trponote.eu5.net/Api/user/Register.php")!
        guard let url = baseUrl.urlwith(qureis) else {return}
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
        }
        task.resume()
        //  request.httpBody = params.data(using: .utf8)
    }
    
    func checkToken(token: String, id: Int, completion: @escaping (_ status: Codes?) -> Void){
        let qureis = ["token":"\(token)","userID":"\(id)"]
        let baseUrl = URL(string:"http://trponote.eu5.net/Api/user/checkToken.php")!
        guard let url = baseUrl.urlwith(qureis) else {return}
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data else {return}
            let code = try? JSONDecoder().decode(Codes.self, from: data)
            print(code)
            completion(code)
            
        }
        task.resume()
        //  request.httpBody = params.data(using: .utf8)
    }
       //?token=8de456c8fc3e7da1e6d0ebf02e4bb180&userID=1000&name=ffffff&text=aaaaaa&createDate=02.03.2019
}
