//
//  Error+Extension.swift
//  Place Search
//
//  Created by Everson Trindade on 25/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

struct CustomError {
    
    var message = "Ops... ocorreu algum erro =("
    
    init() { }
    
    init(error: Error?) {
        message = error?.localizedDescription ?? ""
    }
}
