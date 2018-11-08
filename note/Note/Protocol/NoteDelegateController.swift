//
//  NoteDelegateController.swift
//  note
//
//  Created by Arseniy Zorin on 31/10/2018.
//  Copyright © 2018 ArseniyZ. All rights reserved.
//

import Foundation
protocol NoteDelegateController{
    func addNote(note: Note)
    func saveNote(index: Int, note: Note)
    func getNotesFromServer(notesArray:[Note])
}
