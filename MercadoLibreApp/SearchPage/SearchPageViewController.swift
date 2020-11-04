//
//  SearchPageViewController.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 31/10/20.
//

import UIKit

class SearchPageViewController: UIViewController {

    var items = [Result]()
    var searchResponse : SearchResponse?
    
    private var itemsPerRow: CGFloat = 2
    private var sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var numberResultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

        if let total = searchResponse?.paging?.total {
            numberResultsLabel.text = "\(total) resultados"
        }
        
        if let results = searchResponse?.results {
            items = results
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        itemsPerRow = UIDevice.current.orientation.isLandscape ? 5 : 2
        collectionView.reloadData()
        flowLayout.invalidateLayout()
    }
}

extension SearchPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCollectionViewCell
        cell.configureCell(with: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailPageViewController
        vc.item = items[indexPath.row]
        self.navigationController?.show(vc, sender: nil)
    }
}

extension SearchPageViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / itemsPerRow) - 20, height: (view.frame.width / itemsPerRow) + 30 )
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return sectionInsets
     }
}
