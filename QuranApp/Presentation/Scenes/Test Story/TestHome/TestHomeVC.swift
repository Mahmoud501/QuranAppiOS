//
//  TestHomeVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/24/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import DownloadButton

class TestHomeVC: BaseViewController {

    var presenter = TestHomePresenter()


    @IBOutlet weak var lblResultPrecent: UILabel!
    @IBOutlet weak var vuDownload: PKDownloadButton!
    @IBOutlet weak var TVBody: UITableView!

    
}


extension TestHomeVC {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        presenter.filerSurhas { [weak self] in
            guard let self = self else { return }
            self.TVBody.reloadData()
            let precent: Double = Double(Double(self.presenter.total_count) / 6236.0)
            let Intprecent = Int(precent * 1000)
            let final = Double(Double(Intprecent) / Double(1000))
            self.vuDownload.stopDownloadButton.progress = CGFloat(final)
            let str = String(format: "%.1f", (final * 100))
            self.lblResultPrecent.text = (str).description

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


extension TestHomeVC {
    
    func setupUI() {
        setupColoredBackground()
        if AppFactory.isIPad == true {
            vuDownload.setupButton(radiusPrecent: 0.8)
        }else {
            vuDownload.setupButton(radiusPrecent: 0.5)
        }
        
        vuDownload.setCirleCornerRadius()
        self.vuDownload.state = .downloading
        self.vuDownload.stopDownloadButton.progress = 0
        lblResultPrecent.text = " "
        self.vuDownload.stopDownloadButton.stopButtonWidth  = 0
        TVBody.delegate = self
        TVBody.dataSource = self
        TVBody.register(UINib.init(nibName: "THCell1", bundle: nil), forCellReuseIdentifier: "THCell1")
        TVBody.rowHeight = UITableView.automaticDimension
        TVBody.estimatedRowHeight = 44

    }
    
}



extension TestHomeVC {
    
    static func createVC() -> TestHomeVC {
        let vc = UIStoryboard.init(name: "Test", bundle: nil).instantiateViewController(withIdentifier: "TestHomeVC") as! TestHomeVC
        vc.modalPresentationStyle = .fullScreen
        return vc
    }

    
}
