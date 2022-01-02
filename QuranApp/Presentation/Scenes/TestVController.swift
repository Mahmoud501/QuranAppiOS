//
//  TestVController.swift
//  QuranApp
//
//  Created by Mahmoud Zaki on 04/02/2021.
//  Copyright © 2021 Wakeb. All rights reserved.
//

import UIKit

class TestVController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    static func createVC() -> UIViewController {
        return UIStoryboard.init(name: "Test", bundle: nil).instantiateViewController(withIdentifier: "TestVController")
    }
}

