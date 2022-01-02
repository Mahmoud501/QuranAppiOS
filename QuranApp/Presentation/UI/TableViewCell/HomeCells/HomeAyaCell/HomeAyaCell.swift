//
//  HomeAyaCell.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import SwipeCellKit

class HomeAyaCell: SwipeTableViewCell {

    var didSelectSection : (() -> ())?

    @IBOutlet weak var ImgMark: UIImageView!
    @IBOutlet weak var vuSurha: UIView!
    @IBOutlet weak var lblSurhaName: UILabel!    
    @IBOutlet weak var imgSelect: UIImageView!
    @IBOutlet weak var lblAyaDesc: UILabel!
    @IBOutlet weak var lblTafseer: UILabel!    
    @IBOutlet weak var vuNum: UIView!
    @IBOutlet weak var btnNum: UIButton!
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    
    
    @IBAction func selectClicked(_ sender: Any) {
        didSelectSection?()
    }
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        vuNum.setCirleCornerRadius()
        self.vuSurha.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(ayah: CAyatModel?, setting: CSetting?) {
        let tafseers = (ayah?.tafseers?.array as? [CTafseerDetailModel])
        let tafseer = tafseers?.first(where: { $0.tafseer_id == AppFactory.currentTafseer?.id})
        if (tafseer?.tafseer?.id ?? "0") == TafseerName.None.rawValue {
            //self.imgStar2.isHidden = false
            //self.imgStar.isHidden = true
        }else {
            
        }
        self.imgStar2.isHidden = false
        self.imgStar.isHidden = true
        self.lblTafseer.text = tafseer?.desc
        if setting?.quranWithMark == true {
            if (ayah?.error ?? "") != "" {
                self.lblAyaDesc.text = ayah?.simple_error
            }else {
                self.lblAyaDesc.text = ayah?.desc
            }
        }else {
            if (ayah?.simple_error ?? "") != "" {
                self.lblAyaDesc.text = ayah?.simple_error
            }else {
                self.lblAyaDesc.text = ayah?.simple_desc
            }
        }
        self.lblAyaDesc.attributedText = String.colorText(text: self.lblAyaDesc.text!, searchText: ["(", ")"])

        var quranFontSize: CGFloat = 0
        if setting?.quran_font_size == "0" {
            quranFontSize = 20
            
        }else if setting?.quran_font_size == "1" {
            quranFontSize = 24
        }else {
            quranFontSize = 30
        }
        var fontType = ""
        if setting?.font_type == "0" {
            quranFontSize = quranFontSize - 5
            fontType = "Cairo-Bold"            
        }else if setting?.font_type == "1" {
            fontType = "KFGQPCHAFSUthmanicScript-Regula"
        }else  if setting?.font_type == "2" {
            fontType = "Quran-Standard"
        }else if setting?.font_type == "3" {
            fontType = "Al-QuranAlKareem"
        }else if setting?.font_type == "4" {
            fontType = "AlQalamQuranMajeedWeb"
        }else {
            
            fontType = "Al_Mushaf"
        }
        
        var tafseerFontSize: CGFloat = 0
        if setting?.tafseer_font_size == "0" {
            tafseerFontSize = 13
        }else if setting?.tafseer_font_size == "1" {
            tafseerFontSize = 16
        }else {
            tafseerFontSize = 26
        }
        
        if AppFactory.isIPad {
            quranFontSize = quranFontSize * 2
            tafseerFontSize = tafseerFontSize * 2
        }
        let font = UIFont.init(name: fontType, size: quranFontSize)
        self.lblAyaDesc.font = font
        self.lblTafseer.font = UIFont.init(name: self.lblTafseer.font.fontName, size: tafseerFontSize)        

        self.btnNum.setTitle(ayah?.sort.description, for: .normal)
        if ayah?.isMemorized == true { //memrized
            imgStar.image = UIImage.init(named: "star-selected")
            imgStar.tintColor = UIColor.c4
            imgStar2.image = UIImage.init(named: "star-selected")
            imgStar2.tintColor = UIColor.c4
        }else {
            imgStar.image = UIImage.init(named: "star-notselected")
            imgStar2.image = UIImage.init(named: "star-notselected")
        }
        if ayah?.isSelected == true {
            imgSelect.image = UIImage.init(named: "checkbox-selected")
        }else {
            imgSelect.image = UIImage.init(named: "Ellipse 1")
        }
        if let color = AyaOptionsView.getBackgroundColor(index: ayah?.color ?? "") {
            self.backgroundColor = color
        }else {
            if ayah?.isSelected == true {
                self.backgroundColor = UIColor.c3.withAlphaComponent(0.4)
            }else {
                self.backgroundColor = .clear
            }
        }
        
        if ayah?.sort == 1 {
            let name = (AppFactory.isArabic == true ? ayah?.surha?.name_ar : ayah?.surha?.name_en) ?? ""
            self.lblSurhaName.text = "- " + "Surha".localized + " " + name + " -"
            self.vuSurha.isHidden = false
        }else {
            self.vuSurha.isHidden = true
        }
        
        if setting?.mark_ayah_id == ayah?.id {
            ImgMark.alpha = 1
        }else {
            ImgMark.alpha = 0
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        paragraphStyle.lineSpacing = 10
        paragraphStyle.baseWritingDirection = .rightToLeft
        paragraphStyle.lineBreakMode = .byWordWrapping

        let text: NSMutableAttributedString = NSMutableAttributedString.init(attributedString: lblAyaDesc.attributedText!)
        text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.length))
        self.lblAyaDesc.attributedText = text
        
        
        let paragraphStyle2 = NSMutableParagraphStyle()
        paragraphStyle2.alignment = .justified
        paragraphStyle2.baseWritingDirection = .rightToLeft
        paragraphStyle2.lineBreakMode = .byWordWrapping

        if let att = lblTafseer.attributedText {
            let text2: NSMutableAttributedString = NSMutableAttributedString.init(attributedString: att)
            text2.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle2, range: NSMakeRange(0, text2.length))
            self.lblTafseer.attributedText = text2
        }else {
            self.lblTafseer.text = ""
        }
        
        
    }
    
    
}


