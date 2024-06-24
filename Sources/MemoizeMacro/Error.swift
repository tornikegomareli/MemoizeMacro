//
//  MemoizeError.swift
//
//
//  Created by Tornike Gomareli on 24.06.24.
//

import Foundation

enum MemoizeError: Error, CustomStringConvertible {
  case onlyApplicableToFunctions
  
  var description: String {
    switch self {
    case .onlyApplicableToFunctions:
      return "@Memoize can only be applied to functions"
    }
  }
}

