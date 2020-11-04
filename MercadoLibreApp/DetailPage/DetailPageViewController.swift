//
//  DetailPageViewController.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 1/11/20.
//

import UIKit

class DetailPageViewController: UIViewController {
    
    var item: Result?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var freeShiping: UILabel!
    @IBOutlet weak var adrees: UILabel!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var stack2: UIStackView!
    @IBOutlet weak var cuantity: UILabel!
    @IBOutlet weak var soldCuantity: UILabel!
    @IBOutlet weak var stack1Height: NSLayoutConstraint!
    @IBOutlet weak var stack2Height: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        navigationController?.editButtonItem.tintColor = .white
        setUpUI()
    }
    
    private func setUpUI() {
        image.loadImagesFrom(item?.thumbnail ?? "https://lunawood.com/wp-content/uploads/2018/02/placeholder-image.png")
        condition.text = item?.condition
        soldCuantity.text = "- \(item?.soldQuantity ?? 0) vendidos"
        itemTitle.text = item?.title
        itemPrice.text = "\(Utils.shared.formatPrice(item?.price)) \(item?.currencyID ?? "COP")"
        cuantity.text = "\(item?.availableQuantity ?? 0)"
        freeShiping.isHidden = !(item?.shipping?.freeShipping ?? false)
        adrees.text = "\(item?.address?.stateName ?? "") - \(item?.address?.cityName ?? "")"
        
        addAttributes()
    }
    
    private func addAttributes() {
        guard let attributes = item?.attributes else { return }

        var leftStack = true
        
        stack1Height.constant = CGFloat(attributes.count * 20)
        stack2Height.constant = CGFloat(attributes.count * 20)
        
        for attribute in attributes {
            let stackAttribute = UIStackView(frame:.zero)
            stackAttribute.axis = .vertical
            
            let NameLabel = UILabel(frame: .zero)
            NameLabel.translatesAutoresizingMaskIntoConstraints = false
            NameLabel.textColor = UIColor.gray
            NameLabel.text = "\(attribute.name ?? "")"
            NameLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
            
            let AttributeLabel = UILabel(frame: .zero)
            AttributeLabel.translatesAutoresizingMaskIntoConstraints = false
            AttributeLabel.textColor = UIColor.black
            AttributeLabel.text = "\(attribute.valueName ?? "")"
            AttributeLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)

            stackAttribute.addArrangedSubview(NameLabel)
            stackAttribute.addArrangedSubview(AttributeLabel)

            if leftStack {
                leftStack.toggle()
                stack.addArrangedSubview(stackAttribute)
            } else {
                leftStack.toggle()
                stack2.addArrangedSubview(stackAttribute)
            }
        }
    }
}
