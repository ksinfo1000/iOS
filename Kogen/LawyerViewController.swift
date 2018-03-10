//
//  LawyerViewController.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 7/27/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit
import Alamofire

//class LawyerViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate{
class LawyerViewController: UITableViewController{

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!

    @IBOutlet weak var nameLabel: MaxLengthTextField!
    @IBOutlet weak var emailLabel: MaxLengthTextField!
    @IBOutlet weak var telephoneLabel: MaxLengthTextField!
    @IBOutlet weak var myTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.maxLength = 30
        emailLabel.maxLength = 50
        telephoneLabel.maxLength = 30

        self.title = "Твой адвокат"
        
        myLabel.text = "Наша Юридическая консультация занимает лидирующие позиции, объединяя адвокатов и юристов в различных областях права. Напишите нам сейчас и Вам тут же ответят специалисты по Вашему вопросу."
        
        sendButton.layer.cornerRadius = 5
        sendButton.layer.borderWidth = 0.5
        sendButton.layer.borderColor = UIColor.lightGray.cgColor
        sendButton.setBackgroundColor(color: UIColor.lightGray, forState: .highlighted)

        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 300
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func sendButtonMessage(_ sender: Any) {
        
        if (self.nameLabel.text?.characters.count)! > 0
            && self.myTextField.text.characters.count > 0
            && (self.emailLabel.text?.characters.count)! > 0
         {
            
            
            
            let url = "http://ksinfo1000.com/backend.php/connect/lawyer"
            
            var parameters = [String:String]()
            
            if let name = self.nameLabel.text {
                parameters["name"] = name
            }
            
            if let email = self.emailLabel.text {
                parameters["email"] = email
            }
            
            if let telephone = self.telephoneLabel.text {
                parameters["telephone"] = telephone
            }
            
            if let my_text = self.myTextField.text {
                parameters["text"] = my_text
            }
            
            Alamofire.request(
                URL(string: url)!,
                method: .post,
                parameters: parameters)
                .validate()
                .responseJSON { (response) -> Void in

                    self.nameLabel.text = ""
                    self.emailLabel.text = ""
                    self.telephoneLabel.text = ""
                    self.myTextField.text = ""
                    
                    var alert_title = "Ваш вопрос отправлен!"
                    let alert = UIAlertController.init(title: alert_title, message: "Ваш вопрос отправлен. Если Вы не получите ответ в ближайшее время, то возможно он был задан неточно. В силу своей специфики и большого количества вопросов консультация юриста и адвоката не может гарантировать обязательного ответа на все вопросы.  \nПри возможности настоятельно рекомендуем Вам связываться по телефону: \n+38 096 456 1000 ", preferredStyle: UIAlertControllerStyle.alert)
                    
                    let cancel1 = UIAlertAction.init(title: "ok", style: UIAlertActionStyle.cancel) { (UIAlertAction) in
                        
                        self.revealViewController().revealToggle(animated: true)
                        
                    }
                    alert.addAction(cancel1)
                    
                    self.present(alert, animated: true, completion: {
                        do{
                            
                        }
                    })

                }

        }
        else {
            var alert_title = "Заполните все поля"
            
            let alert1 = UIAlertController.init(title: alert_title, message: nil, preferredStyle: UIAlertControllerStyle.alert)
            
            let cancel = UIAlertAction.init(title: "Ok!", style: UIAlertActionStyle.destructive) { (UIAlertAction) in
            }
            alert1.addAction(cancel)

            
            self.present(alert1, animated: true, completion: {
                do{
                    
                }
            })
        }
        
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
}

