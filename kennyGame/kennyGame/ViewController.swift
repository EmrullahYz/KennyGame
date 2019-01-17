//
//  ViewController.swift
//  kennyGame
//
//  Created by Emrullah Yılmaz on 16.01.2019.
//  Copyright © 2019 Emrullah Yılmaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var userNameTxt: UITextField!
    
    var username :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userNameTxt.delegate = self
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToGame"{
            let destinationVc = segue.destination as! GameViewController
            destinationVc.name = username
        }
    }

    @IBAction func playClicked(_ sender: Any) {
        username = userNameTxt.text!
        if username == "" {
            let alert = UIAlertController (title: "Hata", message: "Please Enter a Username", preferredStyle: UIAlertController.Style.alert)
            let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okBtn)
            self.present(alert, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: "GoToGame", sender: nil)
        }
    }
    
}

