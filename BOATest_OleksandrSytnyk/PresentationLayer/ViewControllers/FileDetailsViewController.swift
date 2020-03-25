//
//  FileDetailsViewController.swift
//  BOATest_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/24/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

class FileDetailsViewController: UIViewController {
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var deviceTypeLabel: UILabel!
  @IBOutlet weak var versionLabel: UILabel!
  @IBOutlet weak var downloadURLLabel: UILabel!

  var fileViewModel: FilePresentable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = fileViewModel?.name.localized
    configureDataLabels()
  }
  
  func configureDataLabels() {
    typeLabel.text = fileViewModel?.type
    deviceTypeLabel.text = fileViewModel?.deviceType
    versionLabel.text = fileViewModel?.version
    downloadURLLabel.text = fileViewModel?.downloadUrl
  }
}
