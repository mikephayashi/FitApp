//
//  JTSHVCalendarBaseView.swift
//  JTCalendarSwift
//
//  Created by 刘振兴 on 2018/1/11.
//  Copyright © 2018年 zoneland. All rights reserved.
//

import UIKit

open class JTSHVCalendarBaseView: UIScrollView,JTSContent {
    
    weak public var manager: JTSCalendarManager?
    
    open var date: Date?
    
    open func loadPreviousPage() {
       fatalError("loadPreviousPage")
    }
    
    open func loadNextPage() {
        fatalError("loadNextPage")
    }
    
    open func loadPreviousPageWithAnimation() {
        fatalError("loadPreviousPageWithAnimation")
    }
    
    open func loadNextPageWithAnimation() {
        fatalError("loadNextPageWithAnimation")
    }
    

}
