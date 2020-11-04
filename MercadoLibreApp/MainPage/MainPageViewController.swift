//
//  MainPageViewController.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 29/10/20.
//

import UIKit

class MainPageViewController: UIViewController {
    
    // MARK: - Variables

    private var itemsPerRow: CGFloat = 2
    private var sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var itemsPerCategory: [String: [Result]] = [:]
    var searchResults : [Result] = []
    var searchResponse : SearchResponse?
    var viewModel = MainPageViewModel()

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var heigthTableSearch: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var categoriesActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        collection.delegate = self
        viewModel.delegate = self
        viewModel.fetchCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.showsCancelButton = true
        activityIndicator.isHidden = true
        categoriesActivityIndicator.startAnimating()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let flowLayout = collection.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        itemsPerRow = UIDevice.current.orientation.isLandscape ? 5 : 2
        collection.reloadData()
        flowLayout.invalidateLayout()
    }
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: { action in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainPageViewController: MainPageDelegate {
    
    func fetchItemsByCategoryParameter(_ response: Response<[String : [Result]]>) {
        categoriesActivityIndicator.isHidden = true

        switch response {
        case .succes(let categories):
            if Array(categories.keys).count == 3 {
                itemsPerCategory = categories
                categoriesActivityIndicator.stopAnimating()
                collection.reloadData()
            }
        case .failure(let error):
            showAlert(with: error.errorDescription)
        }
    }
    
    func searchItem(_ response: Response<SearchResponse>) {
        activityIndicator.isHidden = true
        switch response {
        case .succes(let object):
            if let results = object.results {
                searchResponse = object
                activityIndicator.stopAnimating()
                searchResults = results
                if searchResults.isEmpty {
                    self.view.addSubview(NoResultsView(frame: CGRect(x: 0, y: searchBar.frame.maxY + 10, width: view.frame.width , height: view.frame.height * 0.5)))
                } else {
                    if let viewWithTag = self.view.viewWithTag(100) {
                        viewWithTag.removeFromSuperview()
                    }
                    searchTable.reloadData()
                }
            }
        case .failure(let error):
            showAlert(with: error.errorDescription)
        }
    }

    func fetchCategories(_ response: Response<[Category]>) {
        switch response {
        case .succes(let categories):
            viewModel.fetchItemsBy(categories: categories)
            collection.reloadData()
        case .failure(let error):
            categoriesActivityIndicator.isHidden = true
            showAlert(with: error.errorDescription)
        }
    }
}

// MARK: - CollectionView Data source

extension MainPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let key = Array(itemsPerCategory.keys)
        return key.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let keys = Array(itemsPerCategory.keys)
        let currentSection = keys[section]
        
        guard let items = itemsPerCategory[currentSection] else { return 0}

        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! ItemCollectionViewCell
        let keys = Array(itemsPerCategory.keys)
        let currentSection = keys[indexPath.section]
        
        guard let items = itemsPerCategory[currentSection] else { return cell}

        cell.configureCell(with: items[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderCollection
        
        let key = Array(itemsPerCategory.keys)
        sectionHeader.tittle.text =  key.count == 0 ? "" : key[indexPath.section]

        sectionHeader.layer.backgroundColor = UIColor.white.cgColor
        sectionHeader.layer.shadowColor = UIColor.gray.cgColor
        sectionHeader.layer.shadowOffset = CGSize(width: 0, height: 2.0)//CGSizeMake(0, 2.0);
        sectionHeader.layer.shadowRadius = 2.0
        sectionHeader.layer.shadowOpacity = 1.0
        sectionHeader.layer.masksToBounds = false
        sectionHeader.layer.shadowPath = UIBezierPath(roundedRect:sectionHeader.bounds, cornerRadius:sectionHeader.layer.cornerRadius).cgPath
        
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let keys = Array(itemsPerCategory.keys)
        let currentSection = keys[indexPath.section]
        
        guard let items = itemsPerCategory[currentSection] else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailPageViewController
        vc.item = items[indexPath.row]
        self.navigationController?.show(vc, sender: nil)
    }
}


// MARK: - CollectionView delegate

extension MainPageViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ( view.frame.width / itemsPerRow) - 20, height: view.frame.height * 0.34)
     }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
    }
}

// MARK: - TableView Data source

extension MainPageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailPageViewController
        vc.item = searchResults[indexPath.row]
        self.navigationController?.show(vc, sender: nil)
    }
}

// MARK: - searchBar delegate

extension MainPageViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        /// to avoid mocked data on back button
        searchBar.searchTextField.text = ""
        searchResults.removeAll()
        searchTable.reloadData()
        
        self.heigthTableSearch.constant = UIScreen.main.bounds.height / 2.2
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        viewModel.searchItem(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Search") as! SearchPageViewController
        vc.searchResponse = searchResponse
        clearSearchBar(searchBar)
        self.navigationController?.show(vc, sender: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearchBar(searchBar)
    }

    func clearSearchBar(_ searchBar: UISearchBar) {
        self.heigthTableSearch.constant = 0
        searchBar.searchTextField.text = ""
        searchResults.removeAll()
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        self.view.endEditing(true)
    }
}
