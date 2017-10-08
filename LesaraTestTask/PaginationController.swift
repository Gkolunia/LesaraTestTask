//
//  PaginationController.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/8/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation

class PaginationController<T : PaginationModel> {

    typealias PaginationRequestHandler = (Int, @escaping (Bool, T?, ErrorMessage?) -> ()) -> ()
    
    var paginationRequest : PaginationRequestHandler
    
    private var paginationModel : PaginationModel?
    private var isLoadingNewPage : Bool = false
    
    init(_ defaultPaginationRequest : @escaping PaginationRequestHandler) {
        paginationRequest = defaultPaginationRequest
    }

    func nextPage(_ handler:@escaping (Bool, T?, ErrorMessage?) -> ()) {
        if !isLoadingNewPage {
            isLoadingNewPage = true
            let handleResponseState = {[unowned self] (success: Bool, paginationState : T?, error : ErrorMessage?) in
                self.paginationModel = paginationState
                handler(success, paginationState, error)
                self.isLoadingNewPage = false
            }
            if let existState = paginationModel {
                paginationRequest(existState.currentPage+1, handleResponseState)
            }
            else {
                paginationRequest(1, handleResponseState)
            }
        }
    }
    
    func resetState() {
        paginationModel = nil
    }

}
