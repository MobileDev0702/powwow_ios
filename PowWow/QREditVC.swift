//
//  QREditVC.swift
//  PowWow
//
//  Created by WuSongBai on 2020/8/6.
//  Copyright © 2020 WuSongBai. All rights reserved.
//

import UIKit

class QREditVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var langSwitch: UISwitch!
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var editTextField: UITextField!
    @IBOutlet weak var generateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
        initValue()
    }
    
    func initUI() {
        generateBtn.layer.cornerRadius = generateBtn.frame.size.height / 2
        generateBtn.layer.borderWidth = 1
        generateBtn.layer.borderColor = UIColor.systemBlue.cgColor
        generateBtn.clipsToBounds = true
    }
    
    func initValue() {
        let qrText = UserDefaults.standard.string(forKey: "QRText")
        let lang = UserDefaults.standard.bool(forKey: "Language")
        editTextField.text = qrText
        if lang {
            langSwitch.isOn = true
            inputLabel.text = "Por favor, introduce tu número de teléfono (sin espacios) y tu nombre."
            generateBtn.setTitle("Generar imagen QR", for: .normal)
        } else {
            langSwitch.isOn = false
            inputLabel.text = "Please, input your phone number (no spaces) and your name."
            generateBtn.setTitle("Generate QR Image", for: .normal)
        }
        if qrText?.count == 0 {
            generateBtn.isEnabled = false
        } else {
            generateBtn.isEnabled = true
        }
    }

    @IBAction func onClickGenerateBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "EditToImageVC", sender: nil)
    }
    
    @IBAction func onChangeLangSwitch(_ sender: UISwitch) {
        if sender.isOn {
            inputLabel.text = "Por favor, introduce tu número de teléfono (sin espacios) y tu nombre."
            generateBtn.setTitle("Generar imagen QR", for: .normal)
            UserDefaults.standard.set(true, forKey: "Language")
        } else {
            inputLabel.text = "Please, input your phone number (no spaces) and your name."
            generateBtn.setTitle("Generate QR Image", for: .normal)
            UserDefaults.standard.set(false, forKey: "Language")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField.text?.count == 0 {
            generateBtn.isEnabled = false
        } else {
            generateBtn.isEnabled = true
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EditToImageVC" {
            if let destinationVC = segue.destination as? QRImageVC {
                destinationVC.qrCode = editTextField.text!
                UserDefaults.standard.set(editTextField.text!, forKey: "QRText")
            }
        }
    }
    

}
