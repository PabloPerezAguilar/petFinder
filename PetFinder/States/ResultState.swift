//
//  ResultState.swift
//  PetFinder
//
//  Created by Consultant on 1/25/23.
//

import Foundation

enum ResultState<T>{
    case success(content: [T])
    case error(error: Error)
}
