//
//  FileManager+Extensions.swift
//  PhotoJournal
//
//  Created by Juan Ceballos on 1/28/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import Foundation

extension FileManager {
  // returns a URL to the documents directory for the app
  static func getDocumentsDirectory() -> URL  {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
  
  // function takes a filename as a parameter, appends to the document directory's URL and returns that path
  // this path will be used to write (save) date or read (retrieve) data
  static func pathToDocumentsDirectory(with filename: String) -> URL {
    return getDocumentsDirectory().appendingPathComponent(filename)
  }
}

