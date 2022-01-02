//
//  ImageContainer.swift
//  DalilApp
//
//  Created by Mahmoud on 4/2/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation
import UIKit

protocol ImageContainerBussinessRole {
    func insertImage(image:UIImage)
    func deleteImage(index:Int)
    func isFull()->Bool
}

protocol ImageContainerDataSoure {
    var imgs :[UIImage]?{get set}
    var limit :Int{get set}

}


class ImageContainer :ImageContainerDataSoure ,ImageContainerBussinessRole
{
    var imgs: [UIImage]? = [UIImage]()
    var limit: Int = 0
    
    func insertImage(image: UIImage) {
        if limit > imgs!.count{
            self.imgs?.append(image)
        }
    }
    
    func deleteImage(index: Int) {
        self.imgs?.remove(at: index)
    }
    
    func isFull() -> Bool {
        return limit == imgs!.count
    }
    
    func append(_ photoURL: URL?, finish: @escaping () -> Void , err: @escaping () -> Void  ) {

        guard let imageURL = photoURL else { return  }

        DispatchQueue.global(qos: .userInitiated).async {
            do{
                let imageData: Data = try Data(contentsOf: imageURL)

                DispatchQueue.main.async {
                    if let image = UIImage(data: imageData) {
                        self.imgs?.append(image)
                        finish()
                    }
                }
            }catch{
                DispatchQueue.main.async {
                    err()
                }
            }
        }
    }

    
}
