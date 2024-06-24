// The Swift Programming Language
import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftCompilerPlugin


public struct MemoizeMacro: PeerMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingPeersOf declaration: some DeclSyntaxProtocol,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard let funcDecl = declaration.as(FunctionDeclSyntax.self) else {
      throw MemoizeError.onlyApplicableToFunctions
    }
    
    let funcName = funcDecl.name.text
    let parameters = funcDecl.signature.parameterClause.parameters
    let returnType = funcDecl.signature.returnClause?.type.description ?? "Void"
    
    let cacheKeyParams = parameters.map { param in
      let paramName = param.firstName.text
      return "\(paramName): \\(\(paramName))"
    }.joined(separator: ", ")
    
    let paramNames = parameters.map { $0.firstName.text }.joined(separator: ", ")
    
    let memoizedFunc = """
        private var memoize\(funcName)Cache: [String: \(returnType)] = [:]
        
        func memoized\(funcName.capitalized)(\(parameters)) -> \(returnType) {
            let cacheKey = "\\(\(cacheKeyParams))"
            if let cachedResult = memoize\(funcName)Cache[cacheKey] {
                return cachedResult
            }
            let result = \(funcName)(\(paramNames))
            memoize\(funcName)Cache[cacheKey] = result
            return result
        }
        """
    
    return [DeclSyntax(stringLiteral: memoizedFunc)]
  }
}
