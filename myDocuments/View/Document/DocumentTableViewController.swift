//
//  DocumentTableViewController.swift
//  myDocuments
//
//  Created by Wesley Brito on 03/11/18.
//  Copyright © 2018 Wesley Brito. All rights reserved.
//

import UIKit

class DocumentTableViewController: UITableViewController {

    var listFilterDocuments = [DocumentModel]()
    let documentController = DocumentController()
    
    @IBOutlet weak var searchBarDocument: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDocuments()
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listFilterDocuments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentTableViewCell", for: indexPath)
        if let cell = cell as? DocumentTableViewCell {
            cell.labelNome.text = listFilterDocuments[indexPath.row].nome
        }
        return cell
    }

    
    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
    func loadDocuments() {
        documentController.loadDocuments { (result) in
            if let result = result as? [DocumentModel] {
                self.listFilterDocuments = result
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Erro", message: "Erro na requisição", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }

}

extension DocumentTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listFilterDocuments = documentController.filterListDocuments(name: searchText, documents: self.listFilterDocuments)
        self.tableView.reloadData()
    }
}
