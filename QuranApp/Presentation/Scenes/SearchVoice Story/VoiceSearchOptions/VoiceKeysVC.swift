//
//  VoiceKeysVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/27/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class VoiceKeysVC: BaseViewController {

    var arr: [String] = []
    
    @IBOutlet weak var TVKeys: UITableView!
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}


extension VoiceKeysVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        arr = [
            "guid.t1".localized,
            "guid.t2".localized,
            "guid.t3".localized,
            "guid.t4".localized,
            "guid.t5".localized,
            "guid.t6".localized,
            "guid.t7".localized]
        self.TVKeys.reloadData()
    }
}


extension VoiceKeysVC {
    func setupUI() {
        self.setupColoredBackground()
        TVKeys.delegate = self
        TVKeys.dataSource = self
        TVKeys.estimatedRowHeight = 44
        TVKeys.rowHeight = UITableView.automaticDimension
    }
}

extension VoiceKeysVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arr[indexPath.row]
        if UIApplication.isArabic {
            cell.textLabel?.textAlignment = .right
        }else {
            cell.textLabel?.textAlignment = .left
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            cell.textLabel?.font = UIFont.init(name: cell.textLabel?.font.fontName ?? "", size: 28)
        }
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TVKeys.deselectRow(at: indexPath, animated: true)
    }
}



extension VoiceKeysVC {
    
    static func createVC() -> VoiceKeysVC {
        let vc = UIStoryboard.init(name: "SearchVoice", bundle: nil).instantiateViewController(withIdentifier: "VoiceKeysVC") as! VoiceKeysVC
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
}
