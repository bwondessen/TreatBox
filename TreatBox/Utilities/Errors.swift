//
//  Errors.swift
//  TreatBox
//
//  Created by Bruke Wondessen on 9/26/24.
//

import Foundation

enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
