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

    @IBOutlet weak var outletTVName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationKeyboardShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: <#T##Any?#>)
        
        
        outletTVName.addTarget(self, action: #selector(self.editingChanged(textField:)), for: .editingChanged)
        
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
    
    func notificationKeyboardShow(_ notification: Notification){
        print("Keyboard will show")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

