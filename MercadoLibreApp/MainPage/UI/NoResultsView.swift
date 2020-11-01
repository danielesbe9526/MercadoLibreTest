//
//  NoResultsView.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 30/10/20.
//

import UIKit

class NoResultsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        let viewFromXib = instanceFromNib()
        viewFromXib.bounds = self.bounds
        addSubview(viewFromXib)
    }
    
    func instanceFromNib() -> NoResultsView {
            let view = UINib(nibName: "NoResultsView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! NoResultsView
            return view
     }
}
