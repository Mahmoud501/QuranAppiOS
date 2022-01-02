//
//  SearchTextVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/28/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//


import UIKit

class SearchTextVC: BaseViewController {

    var presenter: SearchTextPresenter!
    var didSearchWith: ((CAyatModel?)->())?    
    
    @IBOutlet weak var TVResult: UITableView!
    @IBOutlet weak var txtsearchbar: UISearchBar!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBAction func backClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentChange(_ sender: Any) {
        self.txtsearchbar.text = ""
        getHome()
    }
    
}


extension SearchTextVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchTextPresenter()
        setupUI()
        getHome()
    }
}


extension SearchTextVC: UISearchBarDelegate {
    func setupUI() {
        self.setupColoredBackground()
        TVResult.delegate = self
        TVResult.dataSource = self
        TVResult.estimatedRowHeight = 44
        TVResult.rowHeight = UITableView.automaticDimension
        txtsearchbar.delegate = self
        txtsearchbar.becomeFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        _ = presenter.search(text: searchText)
        self.TVResult.reloadData()
        self.updateCount()
        if (self.presenter.arr?.count ?? 0 ) > 0 {
            self.TVResult.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: false)
        }        
    }
    
    func getHome() {
        presenter.getHome(type: segment.selectedSegmentIndex) { [weak self] in
            guard let self = self else { return }
            self.TVResult.reloadData()
            self.updateCount()
        }
    }
    
    func updateCount() {
        let count = (self.presenter.arr?.count ?? 0).description
        self.lblTitle.text = "Search".localized + " (" + count + ")"
    }
}


extension SearchTextVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.arr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)        
        cell.textLabel?.textAlignment = .right
        if UIDevice.current.userInterfaceIdiom == .pad {
            cell.textLabel?.font = UIFont.init(name: cell.textLabel?.font.fontName ?? "", size: 28)
        }else {
            cell.textLabel?.font = UIFont.init(name: cell.textLabel?.font.fontName ?? "", size: 17)
        }
        cell.textLabel?.text = self.presenter.arr?[indexPath.row].text
        cell.textLabel?.attributedText = String.colorText(text: cell.textLabel?.text ?? "", searchText: [self.txtsearchbar.text ?? ""])
        cell.textLabel?.numberOfLines = 0
        return cell
    }
      
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TVResult.deselectRow(at: indexPath, animated: true)
        let searchItem = presenter.arr?[indexPath.row]
        let ayah = presenter.getAyah(row: searchItem?.index ?? 0)
        didSearchWith?(ayah)
        self.dismiss(animated: true, completion: nil)
    }
}



extension SearchTextVC {
    
    static func createVC() -> SearchTextVC {
        let vc = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SearchTextVC") as! SearchTextVC
        return vc
    }
    
}

extension String {
   static func colorText(text: String, searchText: [String]) -> NSMutableAttributedString? {
          var attributedString = NSMutableAttributedString(string: text)
          for item in searchText {
              attributedString = getAllRanges(text: text, searchText: item, attributedString: attributedString, startIndex: 0)!
          }
          return attributedString
      }
      
    static func getAllRanges(text: String, searchText: String, attributedString: NSMutableAttributedString, startIndex: Int) ->  NSMutableAttributedString? {
          let myrange = NSRange.init(location: startIndex, length: text.count - startIndex)
          let startRange = Range<String.Index>.init(myrange, in: text)
          if let r = text.range(of: searchText, options: String.CompareOptions.forcedOrdering, range: startRange, locale: nil) {
              let range = NSRange(r, in: text)
              attributedString.addAttribute(.backgroundColor, value: UIColor.yellow, range: range)
              return getAllRanges(text: text, searchText: searchText, attributedString: attributedString, startIndex: range.location + 1)
          }else {
              return attributedString
          }
      }
}
