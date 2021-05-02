//
//  SpyNavigationController.swift
//  TextFieldsAttributesTests
//
//  Created by Denis Yaremenko on 3/30/21.
//

import UIKit

class SpyNavigationController: UINavigationController {
    
    var pushedViewController: UIViewController!
  
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushedViewController = viewController
    }
      
}
