//
//  SelectReciterVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/14/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class SelectReciterVC: BaseViewController, UISearchBarDelegate {
    
    var didSelectReciter: (() -> ())?
    var presenter: SelectReciterPresenter = SelectReciterPresenter()
    var ScrollY: CGFloat = 0
    var type = 0 // 0 -> come from splach to present home ,, 1 come from side menu to side menu
    
    //
    
    @IBOutlet weak var txtSearch: UISearchBar!
    @IBOutlet weak var TVReciter: UITableView!
    @IBOutlet weak var segmentMenu: UISegmentedControl!

    @IBAction func semgentChange(_ sender: Any) {
        self.txtSearch.text = ""
        search()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.getReciters { [weak self] in
            guard let self = self else { return }
            self.TVReciter.reloadData()
            if let index = presenter.getIndex() {
                let indexPath = IndexPath.init(row: index, section: 1)
                DispatchQueue.main.asyncAfter(deadline: .now()  + 0.1, execute: {
                   self.TVReciter.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.middle, animated: false)
                })
            }
        }
    }
    
    func setupUI() {
        self.txtSearch.delegate = self
        setupColoredBackground()
        TVReciter.rowHeight = UITableView.automaticDimension
        TVReciter.estimatedRowHeight = 44
        TVReciter.register(UINib.init(nibName: "ReciterCell", bundle: nil), forCellReuseIdentifier: "ReciterCell")
    }

    func search() {
        presenter.filter(type: segmentMenu.selectedSegmentIndex, Search: self.txtSearch.text!,finish: { [weak self] in
            guard let self = self else { return }
            self.TVReciter.reloadData()
        })
    }


}


extension SelectReciterVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        return (presenter.reciters?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath) as! SelectReciterHeaderCell
            cell.name = presenter.getName()
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReciterCell", for: indexPath) as! ReciterCell
            let reciter = presenter.reciters?[indexPath.row]
            if reciter?.type == presenter.current_type && reciter?.id == presenter.current_reciter {
                cell.vuContain.backgroundColor = .c3
            }else {
                cell.vuContain.backgroundColor = .white
            }
            cell.reciter = reciter
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TVReciter.deselectRow(at: indexPath, animated: true)
        let reciter = presenter.reciters?[indexPath.row]
        presenter.saveSelectedReciter(reciter: reciter!)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        if type == 0 {
            SplachVC.home(animatedUIView: self.view)
        }else {
            AppFactory.homeVC?.didChangeReciter()
            let selectReciter = self.sideMenuController?.sliderVC()
            selectReciter?.bind()
            selectReciter?.refreehTable()
            didSelectReciter?()
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == TVReciter {
         
            if scrollView.contentOffset.y > ScrollY {
                if (scrollView.contentOffset.y - ScrollY ) > (UIScreen.main.bounds.size.width / 2) {
                    //self.TVReciter.bounces = false
                    //self.TVReciter.bouncesZoom = false
                    ScrollY = scrollView.contentOffset.y
                }
            }else {
                //self.TVReciter.bounces = true
                //self.TVReciter.bouncesZoom = true
                ScrollY = scrollView.contentOffset.y
            }
            
        }
    }
}


extension SelectReciterVC {
    static func createVC() -> SelectReciterVC {
          let vc = UIStoryboard.init(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "SelectReciterVC") as! SelectReciterVC
          vc.modalPresentationStyle = .fullScreen
          return vc
      }
    
}
