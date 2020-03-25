//
//  FileViewModel.swift
//  BOATest_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/24/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation

protocol FilePresentable {
  var name: String { get }
  var type: String { get }
  var deviceType: String { get }
  var version: String { get }
  var downloadUrl: String { get }
}

struct FileViewModel {
  var file: File
  
  init(file: File) {
    self.file = file
  }
}

extension FileViewModel: FilePresentable {
  var name: String {
    return file.name
  }
  
  var type: String {
    return file.type
  }
  
  var deviceType: String {
    return file.deviceType
  }
  
  var version: String {
    return file.version
  }
  
  var downloadUrl: String {
    return file.urlString
  }
}
