//
//  File.swift
//  BOATest_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/24/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation

struct File: Decodable {
    let name: String
    let urlString: String
    let version: String
    let deviceType: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case name = "file"
        case urlString = "downloadUrl"
        case version
        case deviceType
        case type
    }
}

struct FileList: Decodable {
    let files: [File]
    
    enum TopLevelCodingKeys: String, CodingKey {
        case mobileInitialize = "MobileInitialize"
        case authV2 = "inAuthV2"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TopLevelCodingKeys.self)
        let mobileInitializeContainer = try container.nestedContainer(keyedBy: TopLevelCodingKeys.self, forKey: TopLevelCodingKeys.mobileInitialize)
        files = try mobileInitializeContainer.decode([File].self, forKey: TopLevelCodingKeys.authV2)
    }
}
