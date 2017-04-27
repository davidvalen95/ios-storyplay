//
//  PageController.swift
//  Storyplay
//
//  Created by suryasoft konsultama on 4/26/17.
//  Copyright © 2017 DavidValentino. All rights reserved.
//

import UIKit

let kSegueIdentifierStartAdventure = "segueStartAdventure"

class PageController: UIViewController {

    var _page:CPage? = nil
    
    // MARK: - user interface properties
    let artworkView: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        return uiImageView
    }()
    let storyLabel: UILabel = {
        let uiLabel: UILabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        return uiLabel
        
    }()
    let firstChoiceButton   = UIButton(type: UIButtonType.system)
    let secondChoiceButton  = UIButton(type: UIButtonType.system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
//        super.view.backgroundColor  = UIColor.blue
        
        if let page = _page{
            guard page._story != nil else {return}
            artworkView.image   = page._story!.getArtwork()
            
            
            let atributedString = NSMutableAttributedString(string: page._story!.getStory())
            let atributParagraphStyle = NSMutableParagraphStyle()
            atributParagraphStyle.lineSpacing = 10
            atributParagraphStyle.alignment = NSTextAlignment.justified
            atributedString.addAttribute(NSParagraphStyleAttributeName, value: atributParagraphStyle, range: NSMakeRange(0,atributedString.length))
                
            storyLabel.attributedText = atributedString
            
            if let firstChoice = page._firstChoice{
                firstChoiceButton.setTitle(firstChoice._title, for: UIControlState.normal)
                firstChoiceButton.setTitle("clicked", for: UIControlState.selected)
                firstChoiceButton.addTarget(self, action: #selector(self.loadChoice(sender:)), for: UIControlEvents.touchUpInside)
            }else{
                firstChoiceButton.setTitle("Play Again", for: UIControlState.normal)
                firstChoiceButton.addTarget(self, action: #selector(self.buttonPlayAgain), for: .touchUpInside)
                
            }
            
            if let secondChoice = page._secondChoice{
                secondChoiceButton.setTitle(secondChoice._title, for: UIControlState.normal)
                secondChoiceButton.setTitle("clicked", for: UIControlState.focused)
                secondChoiceButton.addTarget(self, action: #selector(self.loadChoice(sender:)), for: UIControlEvents.touchUpInside)
            }

        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
       
        
        
        super.view.addSubview(artworkView)
        NSLayoutConstraint.activate([
            artworkView.topAnchor.constraint(equalTo: view.topAnchor),
            artworkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            artworkView.leftAnchor.constraint(equalTo: view.leftAnchor),
            artworkView.rightAnchor.constraint(equalTo: view.rightAnchor)
            
            ])
        super.view.addSubview(storyLabel)
        NSLayoutConstraint.activate(
        [
            storyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
            storyLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
            storyLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -48.0)
            ]
        )
        
        
        
        view.addSubview(firstChoiceButton)
        firstChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0)
            ])
        
        view.addSubview(secondChoiceButton)
        secondChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
            ])
        
        
    }
    
    
    func loadChoice(sender: UIButton){
        var whichChoice:SChoice? = nil
        if sender == firstChoiceButton{
            whichChoice = _page?._firstChoice
        }else{
            whichChoice = _page?._secondChoice
        }
        if let page = _page, let choiced = whichChoice{
            let pageNext = choiced._page
            let pageController = PageController()
            pageController._page = pageNext
            super.navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    func buttonPlayAgain(){
        super.navigationController?.popToRootViewController(animated: true)
        
    }
   

}





