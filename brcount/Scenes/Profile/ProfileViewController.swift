//
//  ProfileViewController.swift
//  brcount
//
//  Created by Daniel Aragon Ore on 11/23/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    var operador: Operator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.masksToBounds = false
        photoImageView.layer.borderColor = UIColor.black.cgColor
        photoImageView.layer.cornerRadius = photoImageView.frame.height/2
        photoImageView.clipsToBounds = true
        
        BetterRideApi.getOperator(operatorId: 4, responseHandler: handleResponse.self)
        
    }
    
    func handleResponse(response: OperatorResponse){
        if response.code != "200"{
            print("Error in response: \(response.message!)")
            return
        }
        if let oper = response.data {
            self.operador =  oper
            photoImageView.setImage(fromUrlString: (oper.photo)!,
                                    withDefaultNamed: "operatorPlaceHolder",
                                    withErrornamed: "operatorPlaceHolder")
            nameTextField.text = oper.name
            lastNameTextField.text = oper.last_name
            emailTextField.text = oper.email
            usernameTextField.text = oper.username
        }
    }
    
    func handleError(error: Error){
        print("Error while requesting Operators: \(error.localizedDescription)")
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        operador?.name = nameTextField.text
        operador?.last_name =  lastNameTextField.text
        operador?.email = emailTextField.text
        operador?.username = usernameTextField.text
        if currentPassword.text == operador?.password && newPasswordTextField.text != "" {
            operador?.password = newPasswordTextField.text
        }
        BetterRideApi.setOperator(operatorId: 4, with: operador!)
        
        let alert = UIAlertController(title: "Changes saved", message: "Your profile changes were saved correctly.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
