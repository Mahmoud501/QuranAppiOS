//
//  TestedAyat.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/24/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class TestedAyat: BaseViewController {

    
    @IBOutlet weak var TVAyat: UITableView!
    @IBOutlet weak var vuStartQuran: UIView!

    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension TestedAyat {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    
}


extension TestedAyat {
    
    func setupUI() {
        self.setupColoredBackground()
        TVAyat.register(UINib.init(nibName: "HomeAyaCell", bundle: nil), forCellReuseIdentifier: "AyaCell")
        TVAyat.register(UINib.init(nibName: "HomeSurhaCell", bundle: nil), forCellReuseIdentifier: "SurhaNameCell")
        TVAyat.rowHeight = UITableView.automaticDimension
        TVAyat.estimatedRowHeight = 44
    }
    
}

extension TestedAyat {
    
    static func createVC() -> TestedAyat {
        let vc = UIStoryboard.init(name: "Test", bundle: nil).instantiateViewController(withIdentifier: "TestedAyat") as! TestedAyat
        vc.modalPresentationStyle = .fullScreen
        UIImpactFeedbackGenerator.init(style: .light).impactOccurred()
        return vc
    }
    
}
