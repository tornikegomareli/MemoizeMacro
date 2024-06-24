//
//  MemoizePlugin.swift
//
//
//  Created by Tornike Gomareli on 24.06.24.
//

import Foundation
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct MemoizePlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    MemoizeMacro.self
  ]
}
