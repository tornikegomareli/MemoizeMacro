import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct Memoize: PeerMacro {
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
    let returnType = funcDecl.signature.returnClause?.type.trimmedDescription ?? "Void"
    
    let cacheKeyParams = parameters.map { param in
      let paramName = param.firstName.text
      return "\(paramName): \\(\(paramName))"
    }.joined(separator: ", ")
    
    let paramNames = parameters.map { param in
      let firstName = param.firstName.text
      if let secondName = param.secondName?.text {
        return "\(firstName): \(secondName)"
      } else {
        return firstName
      }
    }.joined(separator: ", ")
    
    let capitalizedFuncName = funcName.prefix(1).uppercased() + funcName.dropFirst()
    
    let memoizedFunc = """
            private var memoize\(funcName)Cache: [String: \(returnType)] = [:]
            
            func memoized\(capitalizedFuncName)(\(parameters)) -> \(returnType) {
                let cacheKey = "\(cacheKeyParams)"
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
