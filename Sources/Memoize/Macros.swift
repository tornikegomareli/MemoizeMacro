//
//  Macros.swift
//
//
//  Created by Tornike Gomareli on 24.06.24.
//

import Foundation

@attached(peer, names: arbitrary)
public macro Memoize() = #externalMacro(module: "MemoizeMacro", type: "Memoize")
