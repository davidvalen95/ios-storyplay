//
//  ViewController.swift
//  Storyplay
//
//  Created by suryasoft konsultama on 4/25/17.
//  Copyright © 2017 DavidValentino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        
        
        
        
         }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueIdentifierStartAdventure{
            guard let pageController = segue.destination as? PageController else {return}
            pageController._page = SAdventure().story
            
            
        }
    }
    

}

