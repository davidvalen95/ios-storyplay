//
//  Page.swift
//  Storyplay
//
//  Created by suryasoft konsultama on 4/25/17.
//  Copyright © 2017 DavidValentino. All rights reserved.
//

import Foundation


class CPage{
    
    let _story: EStory?
    
    var _firstChoice: SChoice? = nil
    var _secondChoice: SChoice? = nil
    
    
    init(story:EStory){
        _story = story
    }
    
    
    func addChoiceWith(title: String, story:EStory) -> CPage{
        let page = CPage(story: story)
        return addChoiceWith(title: title, page: page)
    }
    
    func addChoiceWith(title:String, page:CPage) -> CPage{
        
//        //# guard
//        guard page != nil else {return self }
        
        
        
        //# optional is derived from enum, with .some or .none
        switch(_firstChoice, _secondChoice){
        case (.some,.some):
            return self
        case(.none, .none), (.none,.some):
            _firstChoice = SChoice(title: title,page: page)
        case(.some, .none):
            _secondChoice = SChoice(title: title,page: page)
            
        }
        
        
        return page
    }
    
}//CPage

class SChoice{
    let _title: String?
    let _page: CPage?
    
    
    init?(title: String?, page:CPage?){
        
        //# if
        if title == nil && page == nil{
            return nil
        }
        _title = title
        _page = page
    }
}//SChoice

struct SAdventure {
    static func getStory( name:String) -> CPage{
        let story = CPage(story: .returnTrip(name: name))
        let pageTouchDown = story.addChoiceWith(title: "Stop and Investigate", story: .touchDown)
        let pageRover = pageTouchDown.addChoiceWith(title: "Explore the Rover", story: .rover(name: name))
        let pageCrate = pageTouchDown.addChoiceWith(title: "Open the Crate", story: .crate)
        
        let pageHomeWard = story.addChoiceWith(title: "Continue home to Earth", story: .homeward)
        pageHomeWard.addChoiceWith(title: "Head back to Mars", page: pageTouchDown)
        let pageHome = pageHomeWard.addChoiceWith(title: "Continue Home to Earth", story: .home)
        
        let pageCave = pageRover.addChoiceWith(title: "Explore the Coordinates", story: .cave)
        pageRover.addChoiceWith(title: "Return to Earth", page: pageHome)
        
        pageCave.addChoiceWith(title: "Continue towards faint light", story: .droid(name: name))
        pageCave.addChoiceWith(title: "Refill the ship and explore the rover", page: pageRover)
        
        pageCrate.addChoiceWith(title: "Explore the Rover", page: pageRover)
        pageCrate.addChoiceWith(title: "Use the key", story: .monster)
        
        return story

    }
    
  

    
    init(){
        
    }
}//SAdv
