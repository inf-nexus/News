//
//  RequestHelper.swift
//  News
//
//  Created by Jacob Contreras on 1/22/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import Foundation

enum RequestStatus {
      case success, loading, failed, uninitialized
  }
  
class RequestHelper {
    var pageSize: Int 
    var page: Int
    var loadedResults: Int
    var totalResults: Int
    var status: RequestStatus
    
    func shouldMakeRequest() -> Bool {
        switch(status) {
        case .success:
            return loadedResults < totalResults
        case .loading:
            return false
        case .failed:
            return false
        case .uninitialized:
            return true
        }
    }
    
    func loadingUpdate() {
        status = .loading
    }
    
    func successUpdate(articleCount: Int, totalResults: Int) {
        status = .success
        loadedResults += articleCount
        self.totalResults = totalResults
        page += 1
    }
    
    func failureUpdate() {
        status = .failed
    }
        
    init (pageSize: Int, page: Int, loadedResults: Int, totalResults: Int, status: RequestStatus) {
        self.pageSize = pageSize
        self.page = page
        self.loadedResults = loadedResults
        self.totalResults = totalResults
        self.status = status
    }
}

class QueryRequestHelper: RequestHelper {
    
    var query: String = ""
    
    func loadingUpdate(nextQuery: String) {
        status = .loading
        query = nextQuery
    }
    
    func shouldMakeRequest(nextQuery: String) -> Bool {
        
        if self.query != nextQuery {
            refreshRequestHelper(query: nextQuery)
            return true
        }
        
        return super.shouldMakeRequest()
    }
    
    private func refreshRequestHelper(query: String) {
        self.query = query
        self.pageSize = 20
        self.page = 1
        self.loadedResults = 0
        self.totalResults = 0
        self.status = .uninitialized
    }
    
}
