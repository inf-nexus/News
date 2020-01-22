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
  
struct RequestHelper {
    var pageSize: Int
    var page: Int
    var loadedResults: Int
    var totalResults: Int
    var status: RequestStatus
    
    var shouldMakeRequest: Bool {
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
}
