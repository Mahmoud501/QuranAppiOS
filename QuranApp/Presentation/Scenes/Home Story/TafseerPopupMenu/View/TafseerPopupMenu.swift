//
//  TafseerPopupMenu.swift
//  ShopApp
//
//  Created by MAJED A  ALGARNI on 7/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

protocol TafseerPopupMenuDelegate: class {
    func didDismissTafseerController()
}

class TafseerPopupMenu: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
        
    var orderAyat: [CAyatModel]?    
    var startIndex: Int = 0
    var initialTouchPoint: CGPoint = CGPoint.init(x: 0, y: 0)
    var text: String?
    weak var delegate: TafseerPopupMenuDelegate?
    
    @IBAction func changeTafseerClicked(_ sender: Any) {
        let vc = SelectTafseerVC.createVC(type: 2)
        vc.didSelectTafseer = { [weak self] (tafseer) in
            guard let self = self else { return }
            self.bindTafseer()
            self.TVTafseer.reloadData()
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    //
    
    @IBOutlet weak var vuContain: UIView!
    @IBOutlet weak var vuDrag: UIView!
    @IBOutlet weak var vuDragLine: UIView!
    @IBOutlet weak var TVTafseer: UITableView!
    @IBOutlet weak var btnTafseerName: UIButton!
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        setupUI()
        bindTafseer()
    }
    
    func setupUI() {
        vuDrag.layer.cornerRadius = 10
        vuDrag.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        vuDrag.layer.masksToBounds = true
        vuDragLine.layer.cornerRadius = vuDragLine.frame.size.height / 2
        vuDragLine.layer.masksToBounds = true
        //vuContain.delegate = self
        TVTafseer.rowHeight = UITableView.automaticDimension
        TVTafseer.estimatedRowHeight = 44
        TVTafseer.register(UINib.init(nibName: "TafseerCell", bundle: nil), forCellReuseIdentifier: "cell")
        TVTafseer.delegate  = self
        TVTafseer.dataSource  = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.scrollToAyah(index: self.startIndex, animation: true)
        }
    }
    
    func bindTafseer() {
        let name = AppFactory.isArabic == true ? AppFactory.tempTafseer?.name_ar : AppFactory.tempTafseer?.name_en
        btnTafseerName.setTitle(name, for: .normal)
    }
    
    
    
    
    @IBAction func tapClicked(_ sender: Any) {
        close()
    }
    
    
    @IBAction func dragView(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            print(touchPoint)
            if touchPoint.y - initialTouchPoint.y > 0{
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - initialTouchPoint.y > self.vuContain.frame.height * 0.25 {
                delegate?.didDismissTafseerController()
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
         if scroll == 0{
             return true
         }
         return false
     }
    
     var scroll : CGFloat = 0.0
     
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         NSLog("Table view scroll detected at offset: %f", scrollView.contentOffset.y)
         scroll = scrollView.contentOffset.y
     }
    
    
    func close() {
        delegate?.didDismissTafseerController()
        UIView.animate(withDuration: 0.25, animations: {
            var frm = self.vuContain.frame
            frm.origin.y = UIScreen.main.bounds.size.height
            self.vuContain.frame = frm
        }) { (com) in
            self.dismiss(animated: false, completion: nil)
        }

    }
    
    func scrollToAyah (index: Int, animation: Bool? = nil) {
                    
        self.TVTafseer.scrollToRow(at: IndexPath.init(row: index, section: 0), at: UITableView.ScrollPosition.top, animated: animation ?? false)

     }

}


extension TafseerPopupMenu: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderAyat?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TafseerCell
        cell.ayah = orderAyat?[indexPath.row]
        return cell
    }

    
}
