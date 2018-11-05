//
//  DocumentTableViewController.swift
//  myDocuments
//
//  Created by Wesley Brito on 03/11/18.
//  Copyright © 2018 Wesley Brito. All rights reserved.
//

import UIKit

class DocumentTableViewController: UITableViewController {

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var listFilterDocuments = [DocumentModel]()
    let documentController = DocumentController()
    var userID: Int?
    
    @IBOutlet weak var searchBarDocument: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        //searchBar
        searchBarDocument.delegate = self
        self.searchBarDocument.showsCancelButton = false
        self.searchBarDocument.delegate = self
        
//        definesPresentationContext = true
//
//        self.activeActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDocuments()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
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
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            documentController.deleteDocument(i: indexPath.row) { (result) in
                print(result as Any)
                if result as! Bool {
                    self.loadDocuments()
                    self.tableView.reloadData()
                } else {
                    let alert = UIAlertController(title: "Erro", message: "Erro na requisição", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func loadDocuments() {
        documentController.loadDocuments(userID: userID!) { (result) in
            if let result = result as? [DocumentModel] {
                self.listFilterDocuments = result
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Erro", message: "Erro na requisição", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier ?? "") {
        case "AddItem":
            if let vc = segue.destination as? DocumentViewController {
                vc.userID = userID
            }
            break
        case "ShowDetail":
            guard let DocumentDetailViewController = segue.destination as? DocumentViewController, let selectedDocumentCell = sender as? DocumentTableViewCell, let indexPath = tableView.indexPath(for: selectedDocumentCell) else { fatalError("Unexpected destination: \(segue.destination)") }
            let selectedDocument = listFilterDocuments[indexPath.row]
            DocumentDetailViewController.document = selectedDocument
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "")")
        }
    }
    
    //Activity Indicator
    func activeActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }

}

extension DocumentTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listFilterDocuments = documentController.filterListDocuments(name: searchText, documents: listFilterDocuments)
        self.tableView.reloadData()
    }
}
