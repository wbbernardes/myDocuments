//
//  UserTableViewController.swift
//  myDocuments
//
//  Created by Wesley Brito on 03/11/18.
//  Copyright © 2018 Wesley Brito. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    let userController = UserController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        userController.loadUsers { result in
            if result as! Bool {
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Erro", message: "Erro na requisição", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userController.getNumberElements()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath)
        if let cell = cell as? UserTableViewCell {
            cell.labelName.text = userController.getNome(indexPath.row)
            cell.labelEmail.text = userController.getEmail(indexPath.row)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        userController.didSelectUser(id: indexPath.row + 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DocumentTableViewController {
            vc.userID = userController.selectedID()
        }
    }

}
