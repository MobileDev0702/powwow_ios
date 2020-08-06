//
//  QRImageVC.swift
//  PowWow
//
//  Created by WuSongBai on 2020/8/6.
//  Copyright © 2020 WuSongBai. All rights reserved.
//

import UIKit

class QRImageVC: UIViewController {

    @IBOutlet weak var codText: UILabel!
    @IBOutlet weak var qrImage: UIImageView!
    
    var qrCode: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    func loadData() {
        let image = generateQRCode(from: qrCode)
        qrImage.image = image
        let code = UserDefaults.standard.string(forKey: "QRText")
        codText.text = "QR Code: \(code!)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
