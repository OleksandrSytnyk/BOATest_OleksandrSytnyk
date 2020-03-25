//
//  MainViewController.swift
//  BOATest_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 3/24/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

class FilesViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  var fileViewModels: [FilePresentable]?
  var showFileDetails = "ShowFileDetails"
  var selectedFileIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = "Files".localized
    navigationController?.delegate = self
    setTableView()
    getFiles()
  }
  
  func setTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = UIView()
  }
  
  func getFiles() {
    BusinessManager.shared.getFiles(successHandler: { [weak self] files in
      guard let strongSelf = self else { return }
      strongSelf.fileViewModels = files.map {
        return FileViewModel(file: $0)
      }
      DispatchQueue.main.async {
        strongSelf.tableView.reloadData()
      }
    }, errorHandler: { [weak self] error in
        let alert = UIAlertController(title: "Error".localized, message: "Failed getting Files".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: .cancel, handler: nil))

        self?.present(alert, animated: true)
    })
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    if let fileDetailsViewController = segue.destination as? FileDetailsViewController {
      fileDetailsViewController.fileViewModel = fileViewModels?[selectedFileIndex]
    }
  }
}

// MARK: - UITableViewDataSource methods

extension FilesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fileViewModels?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath)
    if let fileViewModels = fileViewModels {
      cell.textLabel?.text = fileViewModels[indexPath.row].name
    }
    return cell
  }
}

// MARK: - UITableViewDelegate methods

extension FilesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    selectedFileIndex = indexPath.row
    performSegue(withIdentifier: showFileDetails, sender: nil)
  }
}

// MARK: - UINavigationControllerDelegate methods

extension FilesViewController: UINavigationControllerDelegate{
  func navigationController(
    _ navigationController: UINavigationController,
    animationControllerFor operation: UINavigationController.Operation,
    from fromVC: UIViewController,
    to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animator = AnimationController()
    animator.popStyle = (operation == .pop)
    return animator
  }
}

