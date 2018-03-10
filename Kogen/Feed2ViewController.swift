//
//  Feed2ViewController.swift
//  Kogen
//
//  Created by Kogen on 9/20/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import MessageUI

class Feed2ViewController: UITableViewController, MFMailComposeViewControllerDelegate, UITextViewDelegate, UITextFieldDelegate{

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    
    @IBOutlet weak var messageTextView: UITextView!


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {


            revealViewController().rearViewRevealWidth = 300
            //revealViewController().rearViewRevealDisplacement = 60
            
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        messageTextView.delegate = self
        nameTextField.delegate = self
        subjectTextField.delegate = self
        emailTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        subjectTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        return true
    }
    
    

    @IBAction func sendAction(_ sender: AnyObject) {
        
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setSubject(subjectTextField.text!)
        
        let email = emailTextField.text!.lowercased()
        
        let finalEmail = email.trimmingCharacters(in: CharacterSet.whitespaces)
        
        let mailContent = "Name: \(nameTextField.text!)\n\n Subject: \(subjectTextField.text!)\n\n Email: \(finalEmail)\n\n Message: \(messageTextView.text!)"
        mailVC.setMessageBody(mailContent, isHTML: false)
        
        let toRecipient = "iv.savchuk@gmail.com"
        mailVC.setToRecipients([toRecipient])
        
        self.present(mailVC, animated: true) {
            self.nameTextField.text = ""
            self.subjectTextField.text = ""
            self.emailTextField.text = ""
        }
        
       /*
        func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?){
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
        */
    
    /*
    func mailComposeController(controller: MFMailComposeViewController,
                               didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismissViewControllerAnimated(true, completion: nil)
    
        */
    }
}
