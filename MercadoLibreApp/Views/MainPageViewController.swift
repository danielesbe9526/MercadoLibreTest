//
//  MainPageViewController.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 29/10/20.
//

import UIKit

class MainPageViewController: UIViewController {
    
    // MARK: - Vars

    private var itemsPerRow: CGFloat = 3
    private var sectionInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    var categories: [Category] = []
    var searchResults : [Result] = []
    let client = Client()

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var heigthTableSearch: NSLayoutConstraint!
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        collection.delegate = self
        
        client.fetchCategories { (result) in
            switch result {
            case .succes(let object):
                self.categories = object
                self.collection.reloadData()
            case .failure(let error):
                print(error.hashValue)
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let flowLayout = collection.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        itemsPerRow = UIDevice.current.orientation.isLandscape ? 6 : 3
        collection.reloadData()
        flowLayout.invalidateLayout()
    }
}

// MARK: - CollectionView Data source

extension MainPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category",for: indexPath) as! CategoryCollectionViewCell
        cell.tittle.text = categories[indexPath.row].name
        return cell
    }
}

// MARK: - CollectionView delegate

extension MainPageViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ( view.frame.width / itemsPerRow) - 20, height: (view.frame.width / itemsPerRow) - 20)
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return sectionInsets
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return sectionInsets.left
     }
}

// MARK: - TableView Data source

extension MainPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row].title
        return cell
    }
}

// MARK: - searchBar delegate

extension MainPageViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.heigthTableSearch.constant = UIScreen.main.bounds.height / 2.2
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        client.search(with: searchText) { (result) in
            switch result {
            case .succes(let object):
                if let results = object.results {
                    self.searchResults = results
                    self.searchTable.reloadData()
                }
            case .failure(let error):
                print(error.hashValue)
            }
        }
    }
}
