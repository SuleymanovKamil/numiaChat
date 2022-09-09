//
//  ChatEndpoint.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//

import Foundation


enum ChatEndpoint: Endpoint {
    case fetchMessages(offset: Int)
    
    var path: String {
        switch self {
        case .fetchMessages(let offset):
            return "/getMessages?offset=\(offset)"
        }
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        return [ : ]
    }
}

