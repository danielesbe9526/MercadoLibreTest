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
        
        if let total = searchResponse?.paging?.total {
            numberResultsLabel.text = "\(total) resultados"
        }
        
        if let results = searchResponse?.results {
            items = results
        }
    }
}

extension SearchPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCollectionViewCell
        cell.itemTittle.text = items[indexPath.row].title
        cell.priceLabel.text = "$ \(items[indexPath.row].price ?? 0)"
        cell.itemSubtitle.text = items[indexPath.row].stopTime ?? "2020"
        cell.itemImage.loadImagesFrom(items[indexPath.row].thumbnail ?? "https://lunawood.com/wp-content/uploads/2018/02/placeholder-image.png")
        return cell
    }
}

extension SearchPageViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / itemsPerRow) - 20, height: (view.frame.width / itemsPerRow) + 40 )
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return sectionInsets
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
