//
//  ViewController.swift
//  custom-alertview
//
//  Created by Mahesh Dhumpeti on 17/01/22.
//

import UIKit

class ViewController: UIViewController {
    
//    var dialog: CustomDialogView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showAlert() {
        let dialog = CustomDialog(title: "Your card is ready to use",
                                  message: "Your card has been activated by the primary cardmember and can be used immediately",
                                  actionTitle: "Back to home")
        dialog.onAction = {
            print("Action")
        }
        dialog.onClose = {
            print("Close")
        }
        self.present(dialog, animated: true, completion: nil)
        
//        dialog = CustomDialogView(title: "Success!", message: "You have successfully completed your first dose of vaccine You have successfully completed your first dose of vaccine.", actionTitle: "Dismiss")
//        dialog?.show()
    }


}

