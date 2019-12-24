//
//  NetworkRequest.swift
//  Kuban Kredit Test
//
//  Created by Антон Захарченко on 21.12.2019.
//  Copyright © 2019 Антон Захарченко. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    
    let config = GetConfiguration()
    
    let firstFullUrl: String
    let firstHttpMethod: String
    
    let secondServer: Bool
    let secondFullUrl: String
    let secondHttpMethod: String
    
    init() {
        firstFullUrl = "\(config.firstUrl)\(config.firstEndpoint)"
        firstHttpMethod = "\(config.firstHttpMethod)"
        
        secondServer = config.secondServer
        secondFullUrl = "\(config.secondUrl)\(config.secondEndpoint)"
        secondHttpMethod = "\(config.secondHttpMethod)"
    }
    
    func checkStatus(_ statusCode: Int) -> String {
        switch statusCode {
        case 100...103:
            return "Informational response"
        case 200...226:
            return "Success"
        case 300...308:
            return "Redirection"
        case 400...451:
            return "Client error"
        case 500...511:
            return "Server error"
        default:
            return "Error"
        }
        
    }
}


