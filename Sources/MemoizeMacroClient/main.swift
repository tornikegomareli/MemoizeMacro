//
//  main.swift
//
//
//  Created by Tornike Gomareli on 25.06.24.
//

import Foundation
import Memoize

class MemoizeClass {
  @Memoize
  func test(numberOne: Int, numberTwo: Int) -> Int {
    print("Calculating...")
    Thread.sleep(forTimeInterval: 1)
    return numberOne + numberTwo
  }
}
