//
//  BackendErrors.swift
//  BallerScrabble
//
//  Created by Kayser, Zack (NonEmp) on 1/12/18.
//  Copyright © 2018 Kayser, Zack (NonEmp). All rights reserved.
//

import Foundation

enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}
