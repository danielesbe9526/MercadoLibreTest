//
//  ItemCollectionViewCell.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 31/10/20.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTittle: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    func setup() {
        self.dropShadow(color: .gray, opacity: 0.3, offSet: CGSize(width: -1, height: 1), radius: 5, scale: true)
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        
        let view = loadViewFromNib()
        itemImage.contentMode = .scaleAspectFill
        view.frame = bounds
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CollectionViewCell", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}
