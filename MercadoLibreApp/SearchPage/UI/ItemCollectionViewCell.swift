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
    @IBOutlet weak var itemCondition: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    private func setup() {
        let view = loadViewFromNib()
        itemImage.contentMode = .scaleAspectFill
        view.frame = bounds
        addSubview(view)
        
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CollectionViewCell", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func configureCell(with result: Result) {
        
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 5.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5
        self.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        itemTittle.text = result.title
        itemCondition.text = result.condition
        priceLabel.text = Utils.shared.formatPrice(result.price)
        itemSubtitle.isHidden = !(result.shipping?.freeShipping ?? false)
        itemImage.loadImagesFrom(result.thumbnail ?? "https://lunawood.com/wp-content/uploads/2018/02/placeholder-image.png")
        itemImage.layer.cornerRadius = 5
    }
}
