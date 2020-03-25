//
//  NetworkManager.swift
//  BOATest_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/24/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
  static let shared = NetworkManager()
  
  private var dataTask: URLSessionDataTask? = nil
  
  func getFiles(successHandler: @escaping ([File]) -> Void, errorHandler: @escaping (String?) -> Void) {
    let session = URLSession.shared
    
    guard let url = URL(string: "https://mservice.bankofamerica.com/mgateway/public/v5/bootstrap/mobileInitialize/BA_APPLE_HANDSET/8.1.0/subsequentUse") else {
      print("Wrong url!".localized)
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("en-US", forHTTPHeaderField: "Accept-Language")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("APPLE", forHTTPHeaderField: "device-type")
    request.setValue("SMRTPH", forHTTPHeaderField: "platformType")

    let task = session.dataTask(with: request) { data, response, error in
      
      if error != nil || data == nil {
        print("Client error!".localized)
        return
      }
      
      guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
        print("Server error!".localized)
        return
      }
      
      guard let mime = response.mimeType, mime == "application/json" else {
        print("Wrong MIME type for files!".localized)
        return
      }
      
      guard let data = data else {
        print("Wrong data!".localized)
        return
      }
      
      let decoder = JSONDecoder()
      do {
          let fileList = try decoder.decode(FileList.self, from: data)
          successHandler(fileList.files)
      } catch let error {
          print("Decoding error: \(error.localizedDescription)")
      }
    }
    task.resume()
  }
}
