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
        let viewFromXib = loadViewFromNib()
        viewFromXib.frame = bounds
        viewFromXib.tag = 100
        addSubview(viewFromXib)
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "NoResultsView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}
