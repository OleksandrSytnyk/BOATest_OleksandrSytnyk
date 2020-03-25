//
//  BusinessManager.swift
//  BOATest_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/24/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation

struct BusinessManager {
  static let shared = BusinessManager()
  
  func getFiles(successHandler: @escaping ([File]) -> Void, errorHandler: @escaping (String?) -> Void) {
    
    // TODO - handle business logic on error handling, caching, etc
    NetworkManager.shared.getFiles(successHandler: successHandler, errorHandler: errorHandler)
  }

}
