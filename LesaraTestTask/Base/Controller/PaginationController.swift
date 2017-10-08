//
//  PaginationController.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/8/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation

/**
 * @brief Universal pagination controller. Save current state of pagination.
 */
class PaginationController<T : PaginationModel> {

    typealias PaginationRequestHandler = (_ pageNumber: Int, @escaping (Bool, T?, ErrorMessage?) -> ()) -> ()
    
    /**
     * @brief In the closure can be call any web api which has pages. With input parameter page number.
     */
    var paginationRequest : PaginationRequestHandler
    
    /**
     * @brief Describes current pagination state.
     */
    private var paginationModel : PaginationModel?
    private var isLoadingNewPage : Bool = false
    
    init(_ defaultPaginationRequest : @escaping PaginationRequestHandler) {
        paginationRequest = defaultPaginationRequest
    }
    
    /**
     * @brief Make iteration to the next page and call closure with current number page.
     */
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
    
    /**
     * @brief Reset current state.
     */
    func resetState() {
        paginationModel = nil
    }

}
