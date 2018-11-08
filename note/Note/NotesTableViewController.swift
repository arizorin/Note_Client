//
//  NotesTableViewController.swift
//  note
//
//  Created by Arseniy Zorin on 25/10/2018.
//  Copyright © 2018 ArseniyZ. All rights reserved.
//
import UIKit
import Foundation

class NotesTableViewController: UITableViewController, NoteDelegateController, UISearchBarDelegate{

    var Notes:[Note] = []
    var filteredNotes: [Note] = []
    var currentUser: User?
 
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
    }
 
    override func viewDidAppear(_ animated: Bool) {
        let sqlGetter = sqlController()
        sqlGetter.delegateNote = self
        sqlGetter.fetchNotesFromServer(tableView: tableView, user:currentUser!)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView!.reloadData()
    }
    
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isSearching{
            return filteredNotes.count
        }
        return Notes.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        
        if isSearching{
            let currentNote = filteredNotes[indexPath.row]
            cell.textLabel?.text = currentNote.name
            cell.detailTextLabel?.text = "\(currentNote.createDate)"
            return cell
        }
        else{
        let currentNote = Notes[indexPath.row]
        cell.textLabel?.text = currentNote.name
        cell.detailTextLabel?.text = "\(currentNote.createDate)"
        
        return cell
        }
    }
 
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let currentNoteindex = tableView.indexPathForSelectedRow{
        if segue.identifier == "showNote"{
            if let destination = segue.destination as? ShowNoteViewController{
                destination.note = Notes[currentNoteindex.row]
                destination.noteIndex = currentNoteindex
                destination.delegate = self
                
            }
          }
        }
        if segue.identifier == "addNote"{
            if let destination = segue.destination as? AddNoteViewController{
                destination.delegate = self
            }
        }
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteNote(Notes.remove(at: indexPath.row))
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func logoutUser(_ sender: UIBarButtonItem) {
        eraseData { (Bool) in
            if Bool == true{
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "logout", sender: self)
                }
            }
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }else{
            isSearching = true
            filteredNotes = Notes.filter({ (Note) -> Bool in
                return Note.text.range(of: searchBar.text ?? "") != nil
            })
            tableView.reloadData()
        }
        
    }
    
    func eraseData(completion: @escaping (_ status: Bool) -> Void){
        currentUser?.token = "EMPTY"
        Notes.removeAll()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("notes_test").appendingPathExtension("plist")
        let encodedUser = try? PropertyListEncoder().encode(currentUser)
        try? encodedUser?.write(to: archiveURL, options: .noFileProtection)
        completion(true)
    }
    
    
    func deleteNote(_ note: Note){
        sqlController().deleteNote(user: currentUser!, note: note)
    }
    
    func addNote(note: Note) {
        Notes.append(note)
        sqlController().addNote(user: currentUser!, note: note)
    }
    
    func saveNote(index: Int, note: Note) {
        Notes[index] = note
        sqlController().saveNote(user: currentUser!, note: note)
    }

    func getNotesFromServer(notesArray: [Note]) {
        Notes = notesArray
    }

}
