//
//  searchTableViewController.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 29/10/20.
//

import UIKit

class searchTableViewController: UITableViewController {

    let data = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

extension searchTableViewController: UISearchBarDelegate {
    
}
