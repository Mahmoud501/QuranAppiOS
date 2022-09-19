

import UIKit
import CoreData
import AVFoundation
import AVKit

extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .userInitiated).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}

class test : UIViewController {
    
    
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var vuSlider: UIView!
    @IBOutlet weak var lblTest: UILabel!

    @IBAction func insertClicked(_ sender: Any) {
     


    }
    
    @IBAction func readClicked(_ sender: Any) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            var fontType = "Al-QuranAlKareem"
            let font = UIFont.init(name: fontType, size: self.lblText.font.pointSize)
            //self.lblText.font = font
        }
        

    }
    
}
