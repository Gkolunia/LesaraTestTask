//
//  NestedScrollController.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/8/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class EndlessScrollController : NSObject, EndlessScrollControllerProtocol {
    
    var needsLoadMoreCallBack: (() -> ())?

    weak var scrollView : UIScrollView?
    
    init(_ defaultScrollView: UIScrollView) {
        super.init()
        scrollView = defaultScrollView
        scrollView?.delegate = self
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height*8) >= scrollView.contentSize.height) {
            if let callBack = needsLoadMoreCallBack {
                callBack()
            }
        }
    }
    
}
