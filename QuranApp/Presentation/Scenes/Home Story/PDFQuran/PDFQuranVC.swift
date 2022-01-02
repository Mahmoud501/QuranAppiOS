//
//  PDFQuranVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/23/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import PDFKit

class PDFQuranVC: UIViewController {

    var change: Bool = false
    var path: String?
    var pdfView: PDFView!
    var ayah: CAyatModel? {
        didSet {
            let number = Int(ayah?.page?.id ?? "0") ?? 0
            if let page = pdfView.document?.page(at: number + 8) {
                change = false
                pdfView.go(to: page)
                change = true
            }
        }        
    }
    
    var currentPage: Int?
    var quranPage: Int?
    
    @IBOutlet weak var vuContain: UIView!
    
}


extension PDFQuranVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.pdfView = PDFView(frame: self.vuContain.bounds)
            self.vuContain.addSubview(self.pdfView)
            // Fit content in PDFView.
            self.pdfView.autoScales = true
            self.pdfView.displayDirection = .horizontal
            self.pdfView.displaysRTL = true
        }
        NotificationCenter.default.removeObserver(self, name: Notification.Name.PDFViewPageChanged, object: nil)

        NotificationCenter.default.addObserver (self, selector: #selector(handlePageChange), name: Notification.Name.PDFViewPageChanged, object: nil)
    }
    
    
}

extension PDFQuranVC {
    
    @objc func handlePageChange() {
        if change == false { return }
        currentPage = pdfView.currentPage?.pageRef?.pageNumber
        quranPage = (currentPage ?? 0) - 9
        if (quranPage ?? -11) <= 0 {
            quranPage = 1
        }
        if (quranPage ?? 0) > 604 {
            quranPage = 604
        }
        if let pageNumber = quranPage {
            let pageRepo = CoreDataRepository<CPage>.init()
            let page = pageRepo.query(with: "id == \"\(pageNumber)\"")?.first
            if let ayah = page?.ayat?.array.first as? CAyatModel {
                AppFactory.homeVC?.scrollToAyah(ayah: ayah)
            }
        }
    }

    func openPDF() {
        // Add PDFView to view controller.
        // Load Sample.pdf file.
        if let fileURL = URL.init(string: path ?? "") {
            pdfView.document = PDFDocument(url: fileURL)
            pdfView.usePageViewController(true, withViewOptions: nil)
            pdfView.displayMode = .singlePageContinuous
            pdfView.backgroundColor = self.view.backgroundColor ?? .white
        }
                
    }
        
}



extension PDFQuranVC {
    
    static func createVC() -> PDFQuranVC {
        let vc = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "PDFQuranVC") as! PDFQuranVC
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        return vc
    }
    
}
