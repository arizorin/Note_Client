//
//  ShowNoteViewController.swift
//  note
//
//  Created by Arseniy Zorin on 26/10/2018.
//  Copyright © 2018 ArseniyZ. All rights reserved.
//

import UIKit

class ShowNoteViewController: UIViewController {
    
    var delegate: NoteDelegateController?
    
    var note: Note!
    var noteIndex: IndexPath!
    let vc = NotesTableViewController()
    
    @IBOutlet weak var noteDateLabel: UILabel!
    @IBOutlet weak var noteTextArea: UITextView!
    
    
 
    
    override func viewDidDisappear(_ animated: Bool) {
        getNoteData()
        delegate?.saveNote(index: noteIndex.row, note: note)

    }
    
    override func viewDidLoad() {
        setNoteData()
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    func getNoteData(){
        note.text = noteTextArea.text ?? ""
        note.name = "Note"
    }
    
    func setNoteData(){
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let noteDate = note.createDate
            noteDateLabel.text = noteDate
            noteTextArea.text = note.text
            navigationItem.title = note.name
    }
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        let objectsToShare = [noteTextArea.text]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        self.present(activityVC, animated: true, completion: nil)
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
