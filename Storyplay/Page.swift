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
    
    var _firstChoice: SChoice?
    var _secondChoice: SChoice?
    
    
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
        
        
        return self
    }
    
}

struct SChoice{
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
}


struct SAdventure{
    static var story: CPage = CPage(story: EStory.returnTrip)
    
    
}
