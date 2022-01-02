
//
//  FAQViewController.swift
//  Majdona
//
//  Created by MAJED A  ALGARNI on 5/1/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import UIKit
import ESPullToRefresh

class FAQTEST {
    var question: String?
    var answers: [String]? = [String]()
    var isexpand: Bool?
    init() {}
    init(dict: [String: Any]?) {
        self.question = dict?["title"] as? String
        let answer = dict?["content"] as? String
        answers?.append(answer ?? "no answer")
    }
    
}


class FAQViewController: BaseViewController {

    var data: [FAQTEST]? = [FAQTEST]()

    //
    
    @IBOutlet weak var vuContain: UIView!
    @IBOutlet weak var TVFAQ: UITableView!
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FAQViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        mockData()
    }
}


extension FAQViewController {
    func setupUI() {
        self.setupColoredBackground()
        TVFAQ.separatorStyle = .none
        TVFAQ.register(UINib.init(nibName: "FAQCell", bundle: nil), forCellReuseIdentifier: "mainCell")
        TVFAQ.register(UINib.init(nibName: "AnswerCell", bundle: nil), forCellReuseIdentifier: "subCell")
        TVFAQ.rowHeight = UITableView.automaticDimension
        TVFAQ.estimatedRowHeight = 136
    }
    
    
    
    func mockData() {
        let q1 = FAQTEST()
        q1.question = "ماذا تعبر العلامه النسبيه فى الاختبارات ؟"
        q1.answers?.append("تعبر عن مستواك الحالي وكم حفظت من القران الكريم")
        
     
        data?.append(q1)

        self.TVFAQ.reloadData()

    }
    
    
    
}


extension FAQViewController {
    
    
    
    
}


extension FAQViewController : UITableViewDelegate,UITableViewDataSource{
     
    func numberOfSections(in tableView: UITableView) -> Int {
        return data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data?[section].isexpand ?? false {
            return (data?[section].answers?.count ?? 0) + 1
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! FAQCell
            cell.ImgArrow.image = UIImage(named: "arrow-down")
            if data?[indexPath.section].isexpand ?? false {
                cell.ImgArrow.image = UIImage(named: "arrow-rigth")
            }
            cell.lblQuestion.text = data?[indexPath.section].question
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath)  as! AnswerCell
            
            let answer = data?[indexPath.section].answers?[indexPath.row - 1]
            cell.lblAnswer.text = answer
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let isexpand = (data?[indexPath.section].isexpand ?? false)
            data?[indexPath.section].isexpand = !isexpand
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: UITableView.RowAnimation.fade)
        }else{
        }
 
    }
}

extension FAQViewController {
    static func createFAQViewController() -> UIViewController {
        let vc = UIStoryboard
                           .init(name: "Setting", bundle: nil)
                           .instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
        return vc
    }
}
