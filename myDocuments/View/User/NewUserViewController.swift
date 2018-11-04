//
//  NewUserViewController.swift
//  myDocuments
//
//  Created by Wesley Brito on 03/11/18.
//  Copyright © 2018 Wesley Brito. All rights reserved.
//

import UIKit
import JMMaskTextField_Swift

class NewUserViewController: UIViewController, UITextFieldDelegate {

    let userController = UserController()
    
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textTelefone: UITextField!
    
    @IBOutlet weak var buttonAddUser: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textName.delegate = self
        textEmail.delegate = self
        textTelefone.delegate = self
        let maskTextField = JMMaskTextField(frame: CGRect.zero)
        maskTextField.maskString = "(00) 0 0000-0000"
    }
    
    
    @IBAction func register(_ sender: UIButton) {
        var title = ""
        var message = "Atenção"
        if let nome = textName.text, let email = textEmail.text {
            let userSaveSuccess = userController.saveUser(userName: nome, userEmail: email, userPhone: textTelefone.text)
            if nome.isEmpty, email.isEmpty {
                message = "Você precisa preencher os campos de nome e email"
            } else {
                message = "Erro ao salvar"
                if userSaveSuccess  {
                    title = ""
                    message = "Usuário salvo com sucesso"
                }
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                if userSaveSuccess {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == textTelefone {
            
            guard let text = textField.text as NSString? else { return true }
            let newText = text.replacingCharacters(in: range, with: string)
            
            let maskTextField = textField as! JMMaskTextField
            guard let unmaskedText = maskTextField.stringMask?.unmask(string: newText) else { return true }
            
            if unmaskedText.characters.count >= 11 {
                maskTextField.maskString = "(00) 0 0000-0000"
            } else {
                maskTextField.maskString = "(00) 0000-0000"
            }
        }
        return true
    }

}
