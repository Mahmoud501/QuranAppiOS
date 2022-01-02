//
//  SortTestVC+TableView.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/24/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

import UIKit

extension SortTestVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unsortAyat?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "SortTestCell", for: indexPath) as! SortTestCell
        cell.item = unsortAyat![indexPath.row]
        return cell

    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // code
        if let element = unsortAyat?.remove(at: sourceIndexPath.row) {
            unsortAyat?.insert(element, at: destinationIndexPath.row)
        }

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SortTestHeader.init(frame: .zero)
        header.text = "sort.t1".localized
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
        
            return 100
        
        }
        
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TVSort.deselectRow(at: indexPath, animated: true)
    }
    
    
  
}
