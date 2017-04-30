//
//  ViewController.swift
//  Storyplay
//
//  Created by suryasoft konsultama on 4/25/17.
//  Copyright © 2017 DavidValentino. All rights reserved.
//

import UIKit


enum ErrorTextField:Error{
    case empty
}

class ViewController: UIViewController {

    @IBOutlet weak var constraintTvNameBottom: NSLayoutConstraint!
    @IBOutlet weak var outletTVName: UITextField!
    var _defaultPosition:[NSLayoutConstraint:CGFloat] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationKeyboardShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationKeyboardShow(_:)), name: Notification.Name.UIKeyboardWillHide , object: nil)
        
        
        outletTVName.addTarget(self, action: #selector(self.editingChanged(textField:)), for: .editingChanged)
        
        _defaultPosition.updateValue(constraintTvNameBottom.constant, forKey: constraintTvNameBottom)
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueIdentifierStartAdventure{
            guard let pageController = segue.destination as? PageController else {return}
            
            do{
                if outletTVName.text == "" {
                    //let UIAl
                    throw ErrorTextField.empty
                }
                else{
                    pageController._page = SAdventure.getStory(name: outletTVName.text!)
                    print(outletTVName.text?.characters.count ?? "ok")
                }
                

            }catch ErrorTextField.empty{
                let alertController = UIAlertController(title: "Name Not Provided", message: "pls provide name", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alertController.addAction(action)
                present(alertController, animated: true, completion: nil)
            }catch let error{
                fatalError(error.localizedDescription)
            }
            
                
            
            
        }
    }
    
    func editingChanged(textField:UITextField){
        print (textField.text)
    }
    
    func notificationKeyboardShow(_ notification:
        Notification){
        if notification.name == Notification.Name.UIKeyboardWillShow{
        
            print(notification)
            if let info = notification.userInfo, let keyboardFrame = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let frame = keyboardFrame.cgRectValue
                constraintTvNameBottom.constant = frame.size.height + 10
            
                            UIView.animate(withDuration: 0.8){
                    self.view.layoutIfNeeded()
                }
                
            }//if let
        }//if name
        
        else if notification.name == Notification.Name.UIKeyboardWillHide{
            constraintTvNameBottom.constant = _defaultPosition[constraintTvNameBottom]!
            
            UIView.animate(withDuration: 0.8){
                self.view.layoutIfNeeded()
            }//animatee
        }//else if
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    
    
}


extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text ?? "ok")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text ?? "ok")
        return true

    }
}
























