//
//  NetworkConfiguration.swift
//  Kuban Kredit Test
//
//  Created by Антон Захарченко on 21.12.2019.
//  Copyright © 2019 Антон Захарченко. All rights reserved.
//

import Foundation

let defaults = UserDefaults.standard
struct NetworkConfiguration {

    let firstUrl = "https://portal.kubankredit.ru/auth/login"
    let firstEndpoint = "/backend/rest/stateful/personal/ping"
    let firstHttpMethod = "GET"
    
    var secondServer = false
    let secondUrl = ""
    let secondEndpoint = ""
    let secondHttpMethod = "GET"
    
    let timerCounter = 10
    
    
    mutating func defaultConfiguration() {
        defaults.register(defaults: [
            "firstUrl" : firstUrl,
            "firstEndpoint" : firstEndpoint,
            "firstHttpMethod" : firstHttpMethod,
            "secondServer" : secondServer,
            "secondUrl" : secondUrl,
            "secondEndpoint" : secondEndpoint,
            "secondHttpMethod" : secondHttpMethod,
            "timerCounter" : timerCounter
        ])
    }
    
}

struct GetConfiguration {
    let firstUrl = defaults.string(forKey: "firstUrl") ?? ""
    let firstEndpoint = defaults.string(forKey: "firstEndpoint") ?? ""
    let firstHttpMethod = defaults.string(forKey: "firstHttpMethod") ?? ""

    let secondServer = defaults.bool(forKey: "secondServer")
    let secondUrl = defaults.string(forKey: "secondUrl") ?? ""
    let secondEndpoint = defaults.string(forKey: "secondEndpoint") ?? ""
    let secondHttpMethod = defaults.string(forKey: "secondHttpMethod") ?? ""
    
    let timerCounter = defaults.integer(forKey: "timerCounter")
    
    
    
}
