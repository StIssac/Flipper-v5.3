//
//  TextFieldController.swift
//  Flipper
//
//  Created by clare on 05/05/2018.
//  Copyright © 2018 CSE 208-Group India. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var invalidLabel: UILabel!
    @IBOutlet weak var accountText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Login in page
        accountText.addTarget(self, action: #selector(textChange(_:)), for: .allEditingEvents)
        passwordText.addTarget(self, action: #selector(textChange(_:)), for: .allEditingEvents)
        accountText.clearButtonMode = UITextFieldViewMode.whileEditing
        passwordText.clearButtonMode = UITextFieldViewMode.whileEditing
        passwordText.isSecureTextEntry = true
        loginButton.isEnabled = false
        loginButton.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: UIControlState.disabled)
        loginButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControlState.normal)
    }
    
    func registerView(_ animated: Bool){
        super.viewDidAppear(animated)
        // Window of registration
        let alertController = UIAlertController(title: "Create Account",
                                            message: "Please enter username and password:", preferredStyle: .alert)
        let success = UIAlertController(title: "succeeded!",
                                                message: nil, preferredStyle: .alert)
        let failed = UIAlertController(title: "failed!",
                                        message: nil, preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "username: less than 10 characters"
        }
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "password: at least 4 characters"
            textField.isSecureTextEntry = true
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "create", style: .default, handler: {
            action in
            let registerFlag = logInToFlipper.register(userName: alertController.textFields!.first!.text!, password: alertController.textFields!.last!.text!)
            if registerFlag == true{
                self.presentedViewController?.dismiss(animated: false, completion: nil)
                self.present(success, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: 1, execute: {self.presentedViewController?.dismiss(animated: false, completion: nil)})
            }else{
                self.present(failed, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: 1, execute: {self.presentedViewController?.dismiss(animated: false, completion: nil)})
            }
        })

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // The login Button is avaliable only after both of textfields are not empty.
    @objc func textChange(_ textField:UITextField) {
        invalidLabel.alpha = 0
        loginButton.isEnabled = (accountText.text?.count)!>0 && (passwordText.text?.count)!>0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        let loginFlag = logInToFlipper.logIn(userName: accountText.text!, password: passwordText.text!)
        if loginFlag == true{
            readFile.learnedWordFileName = accountText.text! + "learnedWord"
            readFile.DocunmentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            readFile.learnedWordFileURL = readFile.DocunmentDirURL.appendingPathComponent(readFile.learnedWordFileName).appendingPathExtension("txt")
            readFile.update()
            let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeNav") as! UINavigationController
            self.present(nav, animated: true, completion: nil)
        }else{
            invalidLabel.alpha = 1
            accountText.clearsOnBeginEditing = true
            passwordText.clearsOnBeginEditing = true
        }
        
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        registerView(true)
    }
    
    
    
}

