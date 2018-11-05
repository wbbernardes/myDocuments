//
//  DocumentViewController.swift
//  myDocuments
//
//  Created by Wesley Brito on 04/11/18.
//  Copyright © 2018 Wesley Brito. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var imagePicker: UIImagePickerController!
    var document: DocumentModel?
    let documentConroller = DocumentController()
    var userID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        
        if let document = document {
            navigationItem.title = document.nome
            if let photoid = document.photoid {
                documentConroller.selectPhoto(idPhoto: photoid) { (result) in
                    
                    if result != nil {
                        let photoDocument = result as! PhotoModel
                        if let imgData = Data(base64Encoded: photoDocument.img!), let img = UIImage(data: imgData) {
                            self.photoImageView.image = img
                        }
                    } else {
                        self.photoImageView.image = UIImage(named: "defaultPhoto")
                    }
                }
            }
        }
       updateSaveButtonState()
    }
    

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        if textField.text == "" {
            saveButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let chosenImage = info[.originalImage] as? UIImage {
            photoImageView.contentMode = .scaleAspectFit
            photoImageView.image = chosenImage
            dismiss(animated:true, completion: nil)
        } else {
            print("erro ao escolher imagem")
        }
    }
    
    //ACTIONS
    
    @IBAction func registerDocument(_ sender: UIBarButtonItem) {
        //registro
        var dataPhoto = Data()
        let name = nameTextField.text ?? ""
        if let photo = photoImageView.image {
            dataPhoto = photo.pngData()!
        }
        var alert = UIAlertController()
        documentConroller.saveDocument(userID: userID!, name: name, photo: dataPhoto) { (result) in
            
            if result as! Bool {
                alert = UIAlertController(title: "", message: "Documento salvo com sucesso", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
                    self.navigationController?.popViewController(animated: true)
                }))
            } else {
                alert = UIAlertController(title: "Erro", message: "Erro ao salvar o documento", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
                }))
            }
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func buttonShared(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [photoImageView.image as Any] , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddDocumentMode = presentingViewController is UINavigationController
        
        if isPresentingInAddDocumentMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The DocumentViewController is not inside a navigation controller.")
        }
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}
