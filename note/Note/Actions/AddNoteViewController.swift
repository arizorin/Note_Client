//
//  AddNoteViewController.swift
//  note
//
//  Created by Arseniy Zorin on 26/10/2018.
//  Copyright © 2018 ArseniyZ. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {

    var delegate: NoteDelegateController?
    
    var note: Note{
        let text = noteText.text ?? " "
        let name = "Note"
        let date = "\(Date())"
        let id = 2
        return Note(id: id, name: name, text: text, createDate: date)
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let df = DateFormatter()
        df.dateStyle = .medium
        dateLabel.text = df.string(from: Date())
        self.hideKeyboardWhenTappedAround()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.addNote(note: note)
    }
  

}
