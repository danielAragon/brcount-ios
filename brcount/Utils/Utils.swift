//
//  Utils.swift
//  brcount
//
//  Created by Daniel Aragon Ore on 10/29/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import UIKit
class RoundButton: UIButton
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        initialSetup()
    }
    func initialSetup()
    {
        layer.cornerRadius = bounds.height / 2
        layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), cornerRadius: bounds.height / 2).cgPath
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    }
}
class RoundView: UIView
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        initialSetup()
    }
    func initialSetup()
    {
        layer.cornerRadius = 20
        layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), cornerRadius: 20).cgPath
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    }
}
class RoundBackground: UIView
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        initialSetup()
    }
    func initialSetup()
    {
        layer.cornerRadius = 8
//        layer.shadowColor = UIColor.gray.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    }
}
extension UIImageView {
    func setImage(fromNamedAsset name: String){
        self.image = UIImage(named: name)
    }
    
    func setImage(fromUrlString urlString: String,
                  withDefaultNamed defaultName: String?,
                  withErrornamed errorname: String?){
        //setImage: fromUrlString: withDefaultNamed: withErrorNamed
        guard let url = URL(string: urlString) else {
            if let name = defaultName {
                DispatchQueue.main.async {
                    self.setImage(fromNamedAsset: name)
                }
            }
            return
        }
        
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard
                let urlResponse = response as? HTTPURLResponse,
                urlResponse.statusCode == 200,
                let mineType = response?.mimeType,
                mineType.hasPrefix("image"),
                let data = data,
                error == nil,
                let image = UIImage(data: data) else {
                    if let name = errorname {
                        DispatchQueue.main.async {
                            self.setImage(fromNamedAsset: name)
                        }
                    }
                    return
            }
            DispatchQueue.main.async {
                self.image = image
            }
            }.resume()
    }
    
}

